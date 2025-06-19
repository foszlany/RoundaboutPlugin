#if defined _RAHEADER
 #endinput
#endif
#define _RAHEADER

/* VERSION */
#define PLUGIN_VERSION "0.08a"

/* GENERIC INCLUDES */
#include <sourcemod>
#include <sdktools>
#include <sdktools_gamerules>
#include <tf2>
#include <tf2_stocks>

/* CONVARS */
ConVar g_EnablePlugin;

/* GLOBAL VARIABLES */
int g_CurrentEffect = -1;
int g_ForceRoundEffect = -1;

Handle g_hudSync;
Handle g_RestartGameHandle;
Handle g_Util_OneSecondTimer;

typedef RoundEventFunc = function void(Event event, const char[] name, bool dontBroadcast);
RoundEventFunc g_OnRoundStartFuncPtr;
RoundEventFunc g_OnRoundEndFuncPtr;
RoundEventFunc g_OnPlayerUpdateFuncPtr;
RoundEventFunc g_OnPlayerHitFuncPtr;
RoundEventFunc g_OnPlayerDeathFuncPtr;

Handle g_Effect0_FakePure_Timer;
Handle g_Effect0_FakePure_ExplodeTimer;
bool g_Effect0_FakePure_IsActive;

int g_Effect1_OriginalGravity;

int g_Effect8_InvulnIndex[MAXPLAYERS + 1];

int g_Effect13_MathAnswer[MAXPLAYERS + 1];
Handle g_Effect13_MathQuestionTimers[MAXPLAYERS + 1];

int g_Effect15_BleedCauserIndex[MAXPLAYERS + 1];
int g_Effect16_AssignedClass[MAXPLAYERS + 1];

int g_Effect17_RedTeamClass;
int g_Effect17_BluTeamClass;

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
#include "effects/10_firemelee.sp"
#include "effects/11_schadenfreude.sp"
#include "effects/12_rngdeath.sp"
#include "effects/13_math.sp"
#include "effects/14_weaklings.sp"
#include "effects/15_bleedbuffed.sp"
#include "effects/16_rolemodel.sp"
#include "effects/17_classwars.sp"

/* UTILS */
#include "utils/set_effect.sp"
#include "utils/show_description_hint.sp"
#include "utils/apply_timed_condition.sp"

/* CONVARS */
#include "convars/enableplugin.sp"

/* COMMANDS */
#include "commands/force.sp"
#include "commands/github.sp"
#include "commands/version.sp"
#include "commands/enable.sp"

/* EFFECTS */
enum Effect {
	EFFECT_PURE			=	0,
	EFFECT_LOWGRAVITY		=	1,
	EFFECT_MINICRIT		=	2,
	EFFECT_CRIT			=	3,
	EFFECT_SPEEDBOOST		=	4,
	EFFECT_THIRDPERSON		=	5,
	EFFECT_VAMPIRE			=	6,
	EFFECT_SWIM			=	7,
	EFFECT_STRONGSUIT		=	8,
	EFFECT_FORCEMELEE		=	9,
	EFFECT_FIREMELEE		=	10,
	EFFECT_SCHADENFREUDE	=	11,
	EFFECT_RNGDEATH		=	12,
	EFFECT_MATH			=	13,
	EFFECT_WEAKLINGS		=	14,
	EFFECT_BLEEDBUFFED		=	15,
	EFFECT_ROLEMODEL		=	16,
	EFFECT_CLASSWARS		=	17,
	// EFFECT_FAKEPURE		=	18,
	EFFECT_MAXCOUNT
}