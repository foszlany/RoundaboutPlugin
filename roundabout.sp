#pragma semicolon 1

#include "header.inc"

public Plugin myinfo = {
	name = "Roundabout",
	author = "foszlany",
	description = "Random effects for roundwise chaos.",
	version = PLUGIN_VERSION,
	url = "https://github.com/foszlany/RoundaboutPlugin"
};

public void OnMapStart() {
	/* PRECACHE SOUNDS */
	PrecacheSound("weapons/explode3.wav", true);
	PrecacheSound("ambient/energy/zap3.wav", true);
	PrecacheSound("player/taunt_scorchers_solo2.wav", true);
	PrecacheSound("misc/halloween/spell_teleport.wav", true);
	PrecacheSound("ui/vote_yes.wav", true);
 	PrecacheSound("player/recharged.wav", true);
}

public void OnPluginStart() {
	OnMapStart();

	/* CREATE CONVARS */
	g_CVAR_EnablePlugin = CreateConVar("sm_roundabout_toggle", "1", "Enables or disables the plugin", FCVAR_NOTIFY, true, 0.0, true, 1.0);
	HookConVarChange(g_CVAR_EnablePlugin, ConvarChange_EnablePlugin);

	/* INITIALIZE GLOBAL VARIABLES */
	g_RestartGameHandle = FindConVar("mp_restartgame");
	g_hudSync = CreateHudSynchronizer();

	/* INITIALIZE FUNCTION POINTERS */
	g_OnRoundStartFuncPtr[0] = INVALID_FUNCTION;
	g_OnRoundEndFuncPtr[0] = INVALID_FUNCTION;
	g_OnPlayerUpdateFuncPtr[0] = INVALID_FUNCTION;
	g_OnPlayerHitFuncPtr[0] = INVALID_FUNCTION;
	g_OnPlayerDeathFuncPtr[0] = INVALID_FUNCTION;

	/* INITIALIZE GLOBAL ARRAYS */
	for(int i = 1; i <= MAXPLAYERS; i++) {
		g_HasSpawned[i] = false;
		g_voteSkip[i] = false;
	}

	/* INITIALIZE LISTS */
	InitializeExcludedMultieffects();
	InitializeMutuallyExclusiveMultieffects();

	/* COMMANDS */
	RegAdminCmd("sm_roundabout_enable", Command_EnablePlugin, ADMFLAG_ROOT | ADMFLAG_CHEATS, "Enables or disables the plugin. Usage: !roundabout_enable <1 | 0>");
	RegAdminCmd("sm_roundabout_force", Command_ForceRound, ADMFLAG_GENERIC, "Forces a specific round event. Usage: !roundabout_force <id>");
	RegConsoleCmd("sm_roundabout_help", Command_Help, "Prints the commands and their usages into the player's console.");
	RegConsoleCmd("sm_roundabout_github", Command_Github, "Returns the Github link for the repository of this plugin.");
	RegConsoleCmd("sm_roundabout_effectlist", Command_EffectList, "Returns the doc for every effect and their details.");
	RegConsoleCmd("sm_roundabout_version", Command_Version, "Returns the version of the plugin.");
	RegConsoleCmd("sm_roundabout_effect", Command_Effect, "Shows the effect details on screen. Usage: !roundabout_effect <id>");
	RegConsoleCmd("sm_roundabout_voteskip", Command_VoteSkip, "Initiates a vote to skip the current effect.");

	/* EVENT HOOKS */
	HookEvent("teamplay_round_start", Event_RoundStart);

	HookEvent("teamplay_round_win", Event_RoundEnd, EventHookMode_Pre);
	HookEvent("teamplay_round_stalemate", Event_RoundEnd, EventHookMode_Pre);
	
	HookEvent("post_inventory_application", Event_PlayerUpdate, EventHookMode_Post);

	HookEvent("player_hurt", Event_PlayerHit, EventHookMode_Pre);
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);

	HookEvent("player_disconnect", Event_PlayerDisconnect, EventHookMode_Pre);

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
}

public void DisablePluginFeatures() {
	Event event = CreateEvent("teamplay_round_end");
	Event_RoundEnd(event, "teamplay_round_end", false);

	for(int i = 0; i < MAX_MULTIEFFECT_COUNT; i++) {
		g_OnRoundStartFuncPtr[i] = INVALID_FUNCTION;
		g_OnRoundEndFuncPtr[i] = INVALID_FUNCTION;
		g_OnPlayerUpdateFuncPtr[i] = INVALID_FUNCTION;
		g_OnPlayerHitFuncPtr[i] = INVALID_FUNCTION;
		g_OnPlayerDeathFuncPtr[i] = INVALID_FUNCTION;
	}


	UnhookEvent("teamplay_round_start", Event_RoundStart);
	UnhookEvent("teamplay_round_win", Event_RoundEnd, EventHookMode_Pre);
	UnhookEvent("teamplay_round_stalemate", Event_RoundEnd, EventHookMode_Pre);
	UnhookEvent("post_inventory_application", Event_PlayerUpdate, EventHookMode_Post);
	UnhookEvent("player_hurt", Event_PlayerHit, EventHookMode_Pre);
	UnhookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);
	if(g_RestartGameHandle != INVALID_HANDLE) {
		UnhookConVarChange(g_RestartGameHandle, OnRestartGameChanged);
	}
}

/* ENABLES CURRENT ROUND EFFECT AND DISPLAYS IT ON THE SCREEN */
public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
	if(GameRules_GetProp("m_bInWaitingForPlayers") != 1) {
		for(int i = 0; i < g_EffectCount; i++) {
			if(g_OnRoundStartFuncPtr[i] != INVALID_FUNCTION) {
				CallEventFunction(g_OnRoundStartFuncPtr[i], event, name, dontBroadcast);
			}
		}

		for(int i = 0; i < g_EffectCount; i++) {
			g_OnRoundStartFuncPtr[i] = INVALID_FUNCTION;
			g_OnRoundEndFuncPtr[i] = INVALID_FUNCTION;
			g_OnPlayerUpdateFuncPtr[i] = INVALID_FUNCTION;
			g_OnPlayerHitFuncPtr[i] = INVALID_FUNCTION;
			g_OnPlayerDeathFuncPtr[i] = INVALID_FUNCTION;
		}

		if(!g_isForced) {
			g_EffectCount = RollEffectCount();
		}

		setEffect(0);

		for(int i = 0; i < g_EffectCount; i++) {
			CallEventFunction(g_OnRoundStartFuncPtr[i], event, name, dontBroadcast);
		}

		for(int i = 0; i < g_EffectCount; i++) {
			g_OnRoundStartFuncPtr[i] = INVALID_FUNCTION;
		}
	}
}

/* REAPPLIES EFFECTS IF NEEDED */
public void Event_PlayerUpdate(Event event, const char[] name, bool dontBroadcast) {
	int client = GetClientOfUserId(event.GetInt("userid"));

	if(!g_HasSpawned[client]) {
		for(int i = 0; i < g_EffectCount; i++) {
			if(g_OnPlayerUpdateFuncPtr[i] != INVALID_FUNCTION) {
				g_HasSpawned[client] = true;
				ShowCurrentEffectDescription(client, g_CurrentEffects[0]);
			}
		}
	}

	for(int i = 0; i < g_EffectCount; i++) {
		if(g_OnPlayerUpdateFuncPtr[i] != INVALID_FUNCTION) {
			CallEventFunction(g_OnPlayerUpdateFuncPtr[i], event, name, dontBroadcast);
		}
	}
}

/* PLAYER HIT EVENT */
public void Event_PlayerHit(Event event, const char[] name, bool dontBroadcast) {
	for(int i = 0; i < g_EffectCount; i++) {
		if(g_OnPlayerHitFuncPtr[i] != INVALID_FUNCTION) {
			CallEventFunction(g_OnPlayerHitFuncPtr[i], event, name, dontBroadcast);
		}
	}
}

/* PLAYER DEATH EVENT */
public void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast) {
	for(int i = 0; i < g_EffectCount; i++) {
		if(g_OnPlayerDeathFuncPtr[i] != INVALID_FUNCTION) {
			CallEventFunction(g_OnPlayerDeathFuncPtr[i], event, name, dontBroadcast);
		}
	}
}

/* DISABLES CURRENT ROUND EFFECT AND ROLLS THE NEXT ONE */
public void Event_RoundEnd(Event event, const char[] name, bool dontBroadcast) {
	for(int i = 0; i < g_EffectCount; i++) {
		g_OnPlayerUpdateFuncPtr[i] = INVALID_FUNCTION;
		g_OnPlayerHitFuncPtr[i] = INVALID_FUNCTION;
		g_OnPlayerDeathFuncPtr[i] = INVALID_FUNCTION;
	}

	for(int i = 0; i < g_EffectCount; i++) {
		if(g_OnRoundEndFuncPtr[i] != INVALID_FUNCTION) {
			CallEventFunction(g_OnRoundEndFuncPtr[i], event, name, dontBroadcast);
		}
	}

	for(int i = 0; i < g_EffectCount; i++) {
		g_OnRoundStartFuncPtr[i] = INVALID_FUNCTION;
	}

	for(int i = 1; i <= MAXPLAYERS; i++) {
		g_HasSpawned[i] = false;
		g_voteSkip[i] = false;
	}
}

/* RESET PLAYER DATA UPON DISCONNECT */
public void Event_PlayerDisconnect(Event event, const char[] name, bool dontBroadcast) {
	int client = GetClientOfUserId(event.GetInt("userid"));
	g_HasSpawned[client] = false;
	g_voteSkip[client] = false;
	g_voteSkipCount--;
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