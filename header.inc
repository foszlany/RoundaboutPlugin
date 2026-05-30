#if defined _RAHEADER
 #endinput
#endif
#define _RAHEADER

/* CONSTANTS */
#define PLUGIN_VERSION "0.40"

#define MULTIEFFECT_MAX_COUNT 10

#define MULTIEFFECT_DEFAULT_MAX_COUNT "5"
#define MULTIEFFECT_DEFAULT_BASE_CHANCE "0.04"
#define MULTIEFFECT_DEFAULT_RARITY_MULTIPLIER "2.0"

#define DMG_SOCIALDIST (1 << 30)

ArrayList MULTIEFFECT_EXCLUDED;
ArrayList MULTIEFFECT_MUTUALLY_EXCLUSIVE;
BidirectionalMap EFFECT_TOKENS;

/* GENERIC INCLUDES */
#include <sourcemod>
#include <sdkhooks>

#include <tf2>
#include <tf2_stocks>

/* LIB */
#include <tf2attributes>

/* CONVARS */
ConVar g_CVAR_EnablePlugin;
ConVar g_CVAR_EnableBlacklist;
ConVar g_CVAR_MultieffectMaxCount;
ConVar g_CVAR_MultieffectBaseChance;
ConVar g_CVAR_MultieffectRarityMultiplier;

/* GLOBAL VARIABLES */
Effect g_CurrentEffects[MULTIEFFECT_MAX_COUNT + 1] = {EFFECT_INVALID, ...};

int g_PreviousEffectCount = 1;
int g_EffectCount = 1;
bool g_IsMutuallyExclusiveEffectChosen = false;

bool g_IsForced = false;
bool g_IsForcedRandom = false;
bool g_IsForcedRare[MULTIEFFECT_MAX_COUNT + 1] = {false, ...};

bool g_VoteSkip[MAXPLAYERS + 1];
int g_VoteSkipCount = 0;

StringMap g_Blacklist;

bool g_HasSpawned[MAXPLAYERS + 1];

Handle g_HudSync;
Handle g_RestartGameHandle;
Handle g_Util_OneSecondTimer;

typedef RoundEventFunc = function void(Event event, const char[] name, bool dontBroadcast);
RoundEventFunc g_OnRoundStartFuncPtr[MULTIEFFECT_MAX_COUNT + 1];
RoundEventFunc g_OnRoundEndFuncPtr[MULTIEFFECT_MAX_COUNT + 1];
RoundEventFunc g_OnPlayerUpdateFuncPtr[MULTIEFFECT_MAX_COUNT + 1];
RoundEventFunc g_OnPlayerHitFuncPtr[MULTIEFFECT_MAX_COUNT + 1];
RoundEventFunc g_OnPlayerDeathFuncPtr[MULTIEFFECT_MAX_COUNT + 1];

/* EFFECT VARIABLES */
Handle g_Effect0_FakePure_Timer;
Handle g_Effect0_FakePure_ExplodeTimer;
bool g_Effect0_FakePure_IsActive;

int g_Effect1_OriginalGravity;

TFCond g_Effect3_CritType;

int g_Effect8_InvulnIndex[MAXPLAYERS + 1];

bool g_Effect13_isCommandListenerRegistered;
int g_Effect13_MathAnswer[MAXPLAYERS + 1];
Handle g_Effect13_MathQuestionTimers[MAXPLAYERS + 1];

int g_Effect15_BleedCauserIndex[MAXPLAYERS + 1];
int g_Effect16_AssignedClass[MAXPLAYERS + 1];

int g_Effect17_RedTeamClass;
int g_Effect17_BluTeamClass;

int g_Effect18_EffectIndex[MAXPLAYERS + 1];
Handle g_Effect18_EffectTimer[MAXPLAYERS + 1];

int g_Effect19_LastKiller[MAXPLAYERS + 1];

TFTeam g_Effect20_CurrentTeam[MAXPLAYERS + 1];

int g_Effect21_Duelee[MAXPLAYERS + 1];
Handle g_Effect21_EffectTimer[MAXPLAYERS + 1];

Handle g_Effect22_HeatwaveTimer;

float g_Effect24_KnockbackBonus;

int g_Effect26_OriginalAirAcceleration;

bool g_Effect27_IsPersistent;
float g_Effect27_Bodycount[MAXPLAYERS + 1];

float g_Effect28_SizeMultiplier;

int g_Effect30_BalanceIndicator;

bool g_Effect34_IsSpecialRound;

TFClassType g_Effect37_PreviousClass[MAXPLAYERS + 1];

TFClassType g_Effect40_DisabledClasses[7];

Handle g_Effect42_HorrorTimer;

bool g_Effect46_isCommandListenerRegistered;
Handle g_Effect46_BuffTimer[MAXPLAYERS + 1];

float g_Effect47_OriginalFriction;

bool g_Effect49_bIsLookingAt[MAXPLAYERS + 1][MAXPLAYERS + 1];
int g_Effect49_iCurrentPlayerIndex;
Handle g_Effect49_Timer = null;

bool g_Effect50_PlayersReadyToBeSwapped[MAXPLAYERS + 1];
Handle g_Effect50_SwapTimer;

TFTeam g_Effect51_RealPlayerTeam;
int g_Effect51_OriginalBotCount;
int g_Effect51_OriginalUnbalanceLimit;

bool g_Effect53_IsSpecialRound;

bool g_Effect57_isCommandListenerRegistered;
bool g_Effect57_HasBeenTeleportedRecently[MAXPLAYERS + 1];
bool g_Effect57_HasRecentlyCalled[MAXPLAYERS + 1];

int g_Effect58_King;

int g_Effect60_PlayerHealth[MAXPLAYERS + 1];
float g_Effect60_PlayerPosition[MAXPLAYERS + 1][3];
float g_Effect60_PlayerAngle[MAXPLAYERS + 1][3];
float g_Effect60_PlayerVelocity[MAXPLAYERS + 1][3];
int g_Effect60_PlayerSlot[MAXPLAYERS + 1];
int g_Effect60_PlayerClip[MAXPLAYERS + 1][3];
TFClassType g_Effect60_PlayerClass[MAXPLAYERS + 1];

bool g_Effect61_IsRareVariant;
bool g_Effect61_IsCommandListenerRegistered;
bool g_Effect61_IsParrying[MAXPLAYERS + 1];
bool g_Effect61_HasRecentlyParried[MAXPLAYERS + 1];
bool g_Effect61_DidSuccessfullyParry[MAXPLAYERS + 1];
float g_Effect61_fCooldownEndTime[MAXPLAYERS + 1];
Handle g_Effect61_hHUDTimer = null;

/* EFFECTS */
#include "effects/0_pure.sp"
#include "effects/1_lowgravity.sp"
#include "effects/2_medieval.sp"
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
#include "effects/18_snowball.sp"
#include "effects/19_justice.sp"
#include "effects/20_infection.sp"
#include "effects/21_duelies.sp"
#include "effects/22_heatwave.sp"
#include "effects/23_hyperheal.sp"
#include "effects/24_forceful.sp"
#include "effects/25_assassins.sp"
#include "effects/26_incontrol.sp"
#include "effects/27_bodycount.sp"
#include "effects/28_small.sp"
#include "effects/29_mosquito.sp"
#include "effects/30_balanced.sp"
#include "effects/31_pperform.sp"
#include "effects/32_slowmo.sp"
#include "effects/33_invis.sp"
#include "effects/34_secondary.sp"
#include "effects/35_hell.sp"
#include "effects/36_socialdist.sp"
#include "effects/37_disadvantaged.sp"
#include "effects/38_noscrubs.sp"
#include "effects/39_infiniteclip.sp"
#include "effects/40_restriction.sp"
#include "effects/41_nohud.sp"
#include "effects/42_horror.sp"
#include "effects/43_superjump.sp"
#include "effects/44_pulley.sp"
#include "effects/45_odglasscannon.sp"
#include "effects/46_buffersgambit.sp"
#include "effects/47_skatingrink.sp"
#include "effects/48_stunningmetal.sp"
#include "effects/49_deathstare.sp"
#include "effects/50_quickswap.sp"
#include "effects/51_mvm.sp"
#include "effects/52_pmayhem.sp"
#include "effects/53_shieldingmed.sp"
#include "effects/54_piercingbull.sp"
#include "effects/55_achievement.sp"
#include "effects/56_buffheal.sp"
#include "effects/57_mediccall.sp"
#include "effects/58_king.sp"
#include "effects/59_identitytheft.sp"
#include "effects/60_timetravel.sp"
#include "effects/61_parry.sp"

/* UTILS */
#include "utils/set_effect.sp"
#include "utils/show_description_hint.sp"
#include "utils/apply_timed_condition.sp"
#include "utils/force_win.sp"
#include "utils/is_opposing_team.sp"
#include "utils/explode_player.sp"
#include "utils/class_to_string.sp"
#include "utils/count_players.sp"
#include "utils/force_class.sp"
#include "utils/calculate_dist.sp"
#include "utils/is_arena.sp"
#include "utils/create_particle_on_player.sp"
#include "utils/show_effect_description.sp"
#include "utils/has_nav_mesh.sp"
#include "utils/roll_effect_count.sp"
#include "utils/is_effect_live.sp"
#include "utils/is_effect_forced_rare.sp"
#include "utils/apply_powerplay.sp"
#include "utils/to_lower.sp"

/* DATATYPES */
#include "datatypes/bmap.sp"

/* LISTS */
#include "lists/multieffect_exclude.sp"
#include "lists/multieffect_mutually_exclusive.sp"
#include "lists/effect_codename.sp"

/* CONVARS */
#include "convars/enable_plugin.sp"

/* COMMANDS */
#include "commands/force.sp"
#include "commands/github.sp"
#include "commands/version.sp"
#include "commands/enable.sp"
#include "commands/effectlist.sp"
#include "commands/effect.sp"
#include "commands/help.sp"
#include "commands/voteskip.sp"
#include "commands/roundabout.sp"
#include "commands/blacklist.sp"

/* EFFECTS */
enum Effect {
	EFFECT_INVALID			=	-1,
	EFFECT_PURE			=	0,
	EFFECT_LOWGRAVITY		=	1,
	EFFECT_MEDIEVAL		=	2,
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
	EFFECT_SNOWBALL		=	18,
	EFFECT_JUSTICE			=	19,
	EFFECT_INFECTION		=	20,
	EFFECT_DUELIES			=	21,
	EFFECT_HEATWAVE		=	22,
	EFFECT_HYPERHEAL		=	23,
	EFFECT_FORCEFUL		=	24,
	EFFECT_ASSASSINS		=	25,
	EFFECT_INCONTROL		=	26,
	EFFECT_BODYCOUNT		=	27,
	EFFECT_SMALL			=	28,
	EFFECT_MOSQUITO		=	29,
	EFFECT_BALANCED		=	30,
	EFFECT_PPERFORM		=	31,
	EFFECT_SLOWMO			=	32,
	EFFECT_INVIS			=	33,
	EFFECT_SECONDARY		=	34,
	EFFECT_HELL			=	35,
	EFFECT_SOCIALDIST		=	36,
	EFFECT_DISADVANTAGED	=	37,
	EFFECT_NOSCRUBS		=	38,
	EFFECT_INFINITECLIP		=	39,
	EFFECT_RESTRICTION		=	40,
	EFFECT_NOHUD			=	41,
	EFFECT_HORROR			=	42,
	EFFECT_SUPERJUMP		=	43,
	EFFECT_PULLEY			=	44,
	EFFECT_ODGLASSCANNON	=	45,
	EFFECT_BUFFERSGAMBIT	=	46,
	EFFECT_SKATINGRINK		=	47,
	EFFECT_STUNNINGMETAL	=	48,
	EFFECT_DEATHSTARE		=	49,
	EFFECT_QUICKSWAP		=	50,
	EFFECT_MVM			=	51,
	EFFECT_PMAYHEM			=	52,
	EFFECT_SHIELDINGMED		=	53,
	EFFECT_PIERCINGBULL		=	54,
	EFFECT_ACHIEVEMENT		=	55,
	EFFECT_BUFFHEAL		=	56,
	EFFECT_MEDICCALL		=	57,
	EFFECT_KING 			=	58,
	EFFECT_IDENTITYTHEFT	=	59,
	EFFECT_TIMETRAVEL		=	60,
	EFFECT_PARRY 			=	61,
	EFFECT_MAXCOUNT
}