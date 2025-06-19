// TODO: FIRST JOIN SHOW EFFECT
// TODO: DESCRIPTIONS?

#pragma semicolon 1

#include "header.inc"

public Plugin myinfo = {
	name = "Roundabout",
	author = "foszlany",
	description = "Experience a new type of gimmick every round!",
	version = PLUGIN_VERSION,
	url = "https://github.com/foszlany/RoundaboutPlugin"
};

public void OnPluginStart() {
	/* PRECACHE SOUNDS */
	PrecacheSound("weapons/explode3.wav", true);
	PrecacheSound("player/taunt_scorchers_solo2.wav", true);

	/* CREATE CONVARS */
	if(g_CVAR_EnablePlugin == null) {
		g_CVAR_EnablePlugin = CreateConVar("sm_roundabout_enable", "1", "Enables/disables my feature", FCVAR_NOTIFY, true, 0.0, true, 1.0);
	}
	HookConVarChange(g_CVAR_EnablePlugin, ConvarChange_EnablePlugin);

	/* INITIALIZE GLOBAL VARIABLES */
	g_RestartGameHandle = FindConVar("mp_restartgame");
	g_hudSync = CreateHudSynchronizer();

	/* INITIALIZE FUNCTION POINTERS */
	g_OnRoundStartFuncPtr = INVALID_FUNCTION;
	g_OnRoundEndFuncPtr = INVALID_FUNCTION;
	g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
	g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
	g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;

	/* COMMANDS */
	RegAdminCmd("sm_roundabout_enable", Command_EnablePlugin, ADMFLAG_ROOT | ADMFLAG_CHEATS, "Enables or disables the plugin. Usage: !roundabout_enable <1 | 0>");
	RegAdminCmd("sm_roundabout_force", Command_ForceRound, ADMFLAG_GENERIC, "Forces a specific round event. Usage: !roundabout_force <id>");
	RegConsoleCmd("sm_roundabout_github", Command_Github, "Returns the Github link for the repository of this plugin.");
	RegConsoleCmd("sm_roundabout_version", Command_Version, "Returns the version of the plugin.");

	/* EVENT HOOKS */
	HookEvent("teamplay_round_start", Event_RoundStart);

	HookEvent("teamplay_round_win", Event_RoundEnd, EventHookMode_Pre);
	HookEvent("teamplay_round_stalemate", Event_RoundEnd, EventHookMode_Pre);
	
	HookEvent("post_inventory_application", Event_PlayerUpdate, EventHookMode_Post);

	HookEvent("player_hurt", Event_PlayerHit, EventHookMode_Pre);
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);

	AddCommandListener(Event_ChatMessage, "say");
	AddCommandListener(Event_ChatMessage, "say_team");

	g_RestartGameHandle = FindConVar("mp_restartgame");
	if(g_RestartGameHandle != INVALID_HANDLE) {
		HookConVarChange(g_RestartGameHandle, OnRestartGameChanged);
	}
}

public void OnPluginEnd() {
	DisablePluginFeatures();
}

public void EnablePluginFeatures() {
	HookEvent("teamplay_round_start", Event_RoundStart);
	HookEvent("teamplay_round_win", Event_RoundEnd, EventHookMode_Pre);
	HookEvent("teamplay_round_stalemate", Event_RoundEnd, EventHookMode_Pre);
	HookEvent("post_inventory_application", Event_PlayerUpdate, EventHookMode_Post);
	HookEvent("player_hurt", Event_PlayerHit, EventHookMode_Pre);
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);

	if(g_RestartGameHandle != INVALID_HANDLE) {
		HookConVarChange(g_RestartGameHandle, OnRestartGameChanged);
	}

	AddCommandListener(Event_ChatMessage, "say");
	AddCommandListener(Event_ChatMessage, "say_team");
}

public void DisablePluginFeatures() {
	g_OnRoundStartFuncPtr = INVALID_FUNCTION;
	g_OnRoundEndFuncPtr = INVALID_FUNCTION;
	g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
	g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
	g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;

	UnhookEvent("teamplay_round_start", Event_RoundStart);
	UnhookEvent("teamplay_round_win", Event_RoundEnd, EventHookMode_Pre);
	UnhookEvent("teamplay_round_stalemate", Event_RoundEnd, EventHookMode_Pre);
	UnhookEvent("post_inventory_application", Event_PlayerUpdate, EventHookMode_Post);
	UnhookEvent("player_hurt", Event_PlayerHit, EventHookMode_Pre);
	UnhookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);
	if(g_RestartGameHandle != INVALID_HANDLE) {
		UnhookConVarChange(g_RestartGameHandle, OnRestartGameChanged);
	}

	RemoveCommandListener(Event_ChatMessage, "say");
	RemoveCommandListener(Event_ChatMessage, "say_team");
}

/* ENABLES CURRENT ROUND EFFECT AND DISPLAYS IT ON THE SCREEN */
public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
	if(GameRules_GetProp("m_bInWaitingForPlayers") != 1) {
		if(g_CurrentEffect != -1) {
			CallEventFunction(g_OnRoundEndFuncPtr, event, name, dontBroadcast);
		}

		g_OnRoundStartFuncPtr = INVALID_FUNCTION;
		g_OnRoundEndFuncPtr = INVALID_FUNCTION;
		g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
		g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
		g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;

		if(g_ForceRoundEffect == -1) {
			g_CurrentEffect = setEffect(-1);
		}
		else {
			g_CurrentEffect = setEffect(g_ForceRoundEffect);
			g_ForceRoundEffect = -1;
		}

		CallEventFunction(g_OnRoundStartFuncPtr, event, name, dontBroadcast);

		g_OnRoundStartFuncPtr = INVALID_FUNCTION;
	}
}

/* REAPPLIES EFFECTS IF NEEDED */
public void Event_PlayerUpdate(Event event, const char[] name, bool dontBroadcast) {
	CallEventFunction(g_OnPlayerUpdateFuncPtr, event, name, dontBroadcast);
}

/* PLAYER HIT EVENT */
public void Event_PlayerHit(Event event, const char[] name, bool dontBroadcast) {
	CallEventFunction(g_OnPlayerHitFuncPtr, event, name, dontBroadcast);
}

/* PLAYER DEATH EVENT */
public void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast) {
	CallEventFunction(g_OnPlayerDeathFuncPtr, event, name, dontBroadcast);
}

/* CHAT MESSAGE EVENT */
public Action Event_ChatMessage(int client, const char[] command, int argc) {
	// not planning to do more chat related effects for now, so this should do
	if(g_CurrentEffect == view_as<int>(EFFECT_MATH)) {
		checkMathResponse(client, command, argc);
	}

	return Plugin_Handled;
}

/* DISABLES CURRENT ROUND EFFECT AND ROLLS THE NEXT ONE */
public void Event_RoundEnd(Event event, const char[] name, bool dontBroadcast) {
	g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
	g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
	g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;

	CallEventFunction(g_OnRoundEndFuncPtr, event, name, dontBroadcast);
	g_CurrentEffect = -1;
}

/* REMOVE EFFECTS UPON RESTARTING THE ROUND */
public void OnRestartGameChanged(ConVar convar, const char[] oldValue, const char[] newValue) {
	Event event = CreateEvent("teamplay_round_end");
	Event_RoundEnd(event, "teamplay_round_end", false);
}

public void CallEventFunction(RoundEventFunc funcPointer, Event event, const char[] name, bool dontBroadcast) {
	if(funcPointer != INVALID_FUNCTION) {
		Call_StartFunction(INVALID_HANDLE, funcPointer);
		Call_PushCell(event);
		Call_PushString(name);
		Call_PushCell(dontBroadcast);
		Call_Finish();
	}
}