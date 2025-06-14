// TODO: FIRST JOIN SHOW EFFECT
// TODO: DESCRIPTIONS?

#pragma semicolon 1

#include "header.inc"

public Plugin myinfo = {
	name = "Roundabout",
	author = "foszlany",
	description = "Experience a new type of chaos or gimmick every round!",
	version = "0.01a",
	url = "https://steamcommunity.com/profiles/76561198198930633/"
};

public void OnPluginStart() {
	/* INITIALIZE GLOBAL VARIABLES */
	g_RestartGameHandle = FindConVar("mp_restartgame");

	/* INITIALIZE FUNCTION POINTERS */
	g_OnRoundStartFuncPtr = INVALID_FUNCTION;
	g_OnRoundEndFuncPtr = INVALID_FUNCTION;
	g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;

	/* COMMANDS */
	RegAdminCmd("sm_roundabout_force", Command_ForceRound, ADMFLAG_GENERIC, "Forces a specific round event. Usage: !roundabout_force <id>");

	/* EVENT HOOKS */
	HookEvent("teamplay_round_start", Event_RoundStart);

	HookEvent("teamplay_round_win", Event_RoundEnd, EventHookMode_Pre);
	HookEvent("teamplay_round_stalemate", Event_RoundEnd, EventHookMode_Pre);
	
	HookEvent("player_spawn", Event_PlayerUpdate, EventHookMode_Post);
	HookEvent("post_inventory_application", Event_PlayerUpdate, EventHookMode_Post);

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

		if(g_forceRoundEffect == -1) {
			setEffect(-1);
		}
		else {
			setEffect(g_forceRoundEffect);
			g_forceRoundEffect = -1;
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

/* DISABLES CURRENT ROUND EFFECT AND ROLLS THE NEXT ONE  */
public void Event_RoundEnd(Event event, const char[] name, bool dontBroadcast) {
	g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
	
	if(g_OnRoundEndFuncPtr != INVALID_FUNCTION) {
		Call_StartFunction(INVALID_HANDLE, g_OnRoundEndFuncPtr);
		Call_PushCell(event);
		Call_PushString(name);
		Call_PushCell(dontBroadcast);
		Call_Finish();
	}
	g_IsEffectActive = false;
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

public void OnRestartGameChanged(ConVar convar, const char[] oldValue, const char[] newValue) {
	Event event = CreateEvent("teamplay_round_end");
	Event_RoundEnd(event, "teamplay_round_end", false);
}