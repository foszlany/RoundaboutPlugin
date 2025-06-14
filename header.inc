#if defined _RAHEADER
 #endinput
#endif
#define _RAHEADER

/* GENERIC INCLUDES */
#include <sourcemod>
#include <sdktools>
#include <tf2>
#include <tf2_stocks>
#include <sdktools_gamerules>

/* GLOBAL VARIABLES */
bool g_IsEffectActive = false;
int g_forceRoundEffect = -1;

Handle g_RestartGameHandle;

typedef RoundEventFunc = function void(Event event, const char[] name, bool dontBroadcast);
RoundEventFunc g_OnRoundStartFuncPtr;
RoundEventFunc g_OnRoundEndFuncPtr;
RoundEventFunc g_OnPlayerUpdateFuncPtr;

/* EFFECTS */
#include "effects/0_pure.sp"
#include "effects/1_lowgravity.sp"
#include "effects/2_minicrit.sp"
#include "effects/3_crit.sp"
#include "effects/4_speedboost.sp"
#include "effects/5_thirdperson.sp"

/* UTILS */
#include "utils/set_effect.sp"
#include "utils/show_description_hint.sp"
#include "utils/apply_timed_condition.sp"

/* COMMANDS */
#include "commands/force.sp"

/* EFFECTS */
enum Effect {
	EFFECT_PURE 			= 	0,
	EFFECT_LOWGRAVITY		=	1,
	EFFECT_MINICRIT		=	2,
	EFFECT_CRIT			=	3,
	EFFECT_SPEEDBOOST		=	4,
	EFFECT_THIRDPERSON		=	5,
	// EFFECT_VAMPIRE		=	6
	// EFFECT_MATH			= 	7,
	// EFFECT_FORCEMELEE	=	8,
	// EFFECT_FIREMELEE		=	9,
	// EFFECT_RNGDEATH		=	10,

	EFFECT_MAXCOUNT
}