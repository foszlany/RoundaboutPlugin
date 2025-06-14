#if defined _RAHEADER
 #endinput
#endif
#define _RAHEADER

/* VERSION */
#define PLUGIN_VERSION "0.03a"

/* GENERIC INCLUDES */
#include <sourcemod>
#include <sdktools>
#include <sdktools_gamerules>
#include <tf2>
#include <tf2_stocks>

/* GLOBAL VARIABLES */
bool g_IsEffectActive = false;
int g_forceRoundEffect = -1;

Handle g_RestartGameHandle;

typedef RoundEventFunc = function void(Event event, const char[] name, bool dontBroadcast);
RoundEventFunc g_OnRoundStartFuncPtr;
RoundEventFunc g_OnRoundEndFuncPtr;
RoundEventFunc g_OnPlayerUpdateFuncPtr;
RoundEventFunc g_OnPlayerHitFuncPtr;
RoundEventFunc g_OnPlayerDeathFuncPtr;

int g_Effect8_InvulnIndex[MAXPLAYERS];

/* EFFECTS */
#include "effects/0_pure.sp"
#include "effects/1_lowgravity.sp"
#include "effects/2_minicrit.sp"
#include "effects/3_crit.sp"
#include "effects/4_speedboost.sp"
#include "effects/5_thirdperson.sp"
#include "effects/6_vampire.sp"
#include "effects/7_swim.sp"
#include "effects/8_strongsuit.sp"
#include "effects/9_forcemelee.sp"

/* UTILS */
#include "utils/set_effect.sp"
#include "utils/show_description_hint.sp"
#include "utils/apply_timed_condition.sp"

/* COMMANDS */
#include "commands/force.sp"
#include "commands/github.sp"
#include "commands/version.sp"

/* EFFECTS */
enum Effect {
	EFFECT_PURE 			= 	0,
	EFFECT_LOWGRAVITY		=	1,
	EFFECT_MINICRIT		=	2,
	EFFECT_CRIT			=	3,
	EFFECT_SPEEDBOOST		=	4,
	EFFECT_THIRDPERSON		=	5,
	EFFECT_VAMPIRE			=	6,
	EFFECT_SWIM			=	7,
	EFFECT_STRONGSUIT		=	8,
	EFFECT_FORCEMELEE		=	9,
	// EFFECT_FIREMELEE		=	10,
	// EFFECT_RNGDEATH		=	11,
	// EFFECT_MATH			= 	12,
	EFFECT_MAXCOUNT
}