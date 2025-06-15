// TODO: FIRST JOIN SHOW EFFECT
// TODO: DESCRIPTIONS?

#pragma semicolon 1

#include "header.inc"

public Plugin myinfo = {
	name = "Roundabout",
	author = "foszlany",
	description = "Experience a new type of chaos or gimmick every round!",
	version = PLUGIN_VERSION,
	url = "https://github.com/foszlany/RoundaboutPlugin"
};

public void OnPluginStart() {
	/* INITIALIZE GLOBAL VARIABLES */
	g_RestartGameHandle = FindConVar("mp_restartgame");

	/* INITIALIZE FUNCTION POINTERS */
	g_OnRoundStartFuncPtr = INVALID_FUNCTION;
	g_OnRoundEndFuncPtr = INVALID_FUNCTION;
	g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
	g_OnPlayerHitFuncPtr = INVALID_FUNCTION;

	/* COMMANDS */
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

	if(g_RestartGameHandle != INVALID_HANDLE) {
		HookConVarChange(g_RestartGameHandle, OnRestartGameChanged);
	}
}

/* ENABLES CURRENT ROUND EFFECT AND DISPLAYS IT ON THE SCREEN */
public void Event_RoundStart(Event event, const char[] name, bool dontBroadcast) {
	if(GameRules_GetProp("m_bInWaitingForPlayers") != 1) {
		if(g_IsEffectActive && g_OnRoundEndFuncPtr != INVALID_FUNCTION) {
				Call_StartFunction(INVALID_HANDLE, g_OnRoundEndFuncPtr);
				Call_PushCell(event);
				Call_PushString(name);
				Call_PushCell(dontBroadcast);
				Call_Finish();
		}

		g_OnRoundStartFuncPtr = INVALID_FUNCTION;
		g_OnRoundEndFuncPtr = INVALID_FUNCTION;
		g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
		g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
		g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;

		if(g_ForceRoundEffect == -1) {
			setEffect(-1);
		}
		else {
			setEffect(g_ForceRoundEffect);
			g_ForceRoundEffect = -1;
		}

		if(g_OnRoundStartFuncPtr != INVALID_FUNCTION) {
			Call_StartFunction(INVALID_HANDLE, g_OnRoundStartFuncPtr);
			Call_PushCell(event);
			Call_PushString(name);
			Call_PushCell(dontBroadcast);
			Call_Finish();
		}
		g_IsEffectActive = true;

		g_OnRoundStartFuncPtr = INVALID_FUNCTION;
	}
}

/* REAPPLIES EFFECTS IF NEEDED */
public void Event_PlayerUpdate(Event event, const char[] name, bool dontBroadcast) {
	if(g_OnPlayerUpdateFuncPtr != INVALID_FUNCTION) {
		Call_StartFunction(INVALID_HANDLE, g_OnPlayerUpdateFuncPtr);
		Call_PushCell(event);
		Call_PushString(name);
		Call_PushCell(dontBroadcast);
		Call_Finish();
	}
}

/* PLAYER HIT EVENT */
public void Event_PlayerHit(Event event, const char[] name, bool dontBroadcast) {
	if(g_OnPlayerHitFuncPtr != INVALID_FUNCTION) {
		Call_StartFunction(INVALID_HANDLE, g_OnPlayerHitFuncPtr);
		Call_PushCell(event);
		Call_PushString(name);
		Call_PushCell(dontBroadcast);
		Call_Finish();
	}
}

/* PLAYER DEATH EVENT */
public void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast) {
	if(g_OnPlayerDeathFuncPtr != INVALID_FUNCTION) {
		Call_StartFunction(INVALID_HANDLE, g_OnPlayerDeathFuncPtr);
		Call_PushCell(event);
		Call_PushString(name);
		Call_PushCell(dontBroadcast);
		Call_Finish();
	}
}

/* DISABLES CURRENT ROUND EFFECT AND ROLLS THE NEXT ONE  */
public void Event_RoundEnd(Event event, const char[] name, bool dontBroadcast) {
	g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
	g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
	g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;

	if(g_OnRoundEndFuncPtr != INVALID_FUNCTION) {
		Call_StartFunction(INVALID_HANDLE, g_OnRoundEndFuncPtr);
		Call_PushCell(event);
		Call_PushString(name);
		Call_PushCell(dontBroadcast);
		Call_Finish();
	}
	g_IsEffectActive = false;
}

/* REMOVE EFFECTS UPON RESTARTING THE ROUND */
public void OnRestartGameChanged(ConVar convar, const char[] oldValue, const char[] newValue) {
	Event event = CreateEvent("teamplay_round_end");
	Event_RoundEnd(event, "teamplay_round_end", false);
}