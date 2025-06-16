#pragma semicolon 1

public int setEffect(int id) {
     if(id >= view_as<int>(EFFECT_MAXCOUNT)) {
          id = 0;
     }
     else if(id <= -1) {
          id = GetRandomInt(0, EFFECT_MAXCOUNT - EFFECT_LOWGRAVITY);
     }

     switch(id) {
          case EFFECT_PURE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_0_Pure;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_LOWGRAVITY: {
               g_OnRoundStartFuncPtr = Event_RoundStart_1_LowGravity;
               g_OnRoundEndFuncPtr = Event_RoundEnd_1_LowGravity;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_MINICRIT: {
               g_OnRoundStartFuncPtr = Event_RoundStart_2_MiniCrit;
               g_OnRoundEndFuncPtr = Event_RoundEnd_2_MiniCrit;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_2_MiniCrit;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_CRIT: {
               g_OnRoundStartFuncPtr = Event_RoundStart_3_Crit;
               g_OnRoundEndFuncPtr = Event_RoundEnd_3_Crit;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_3_Crit;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_SPEEDBOOST: {
               g_OnRoundStartFuncPtr = Event_RoundStart_4_SpeedBoost;
               g_OnRoundEndFuncPtr = Event_RoundEnd_4_SpeedBoost;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_4_SpeedBoost;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_THIRDPERSON: {
               g_OnRoundStartFuncPtr = Event_RoundStart_5_ThirdPerson;
               g_OnRoundEndFuncPtr = Event_RoundEnd_5_ThirdPerson;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_5_ThirdPerson;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_VAMPIRE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_6_Vampire;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = Event_PlayerHit_6_Vampire;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_SWIM: {
               g_OnRoundStartFuncPtr = Event_RoundStart_7_Swim;
               g_OnRoundEndFuncPtr = Event_RoundEnd_7_Swim;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_7_Swim;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_STRONGSUIT: {
               g_OnRoundStartFuncPtr = Event_RoundStart_8_StrongSuit;
               g_OnRoundEndFuncPtr = Event_RoundEnd_8_StrongSuit;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_8_StrongSuit;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_8_StrongSuit;
          }

          case EFFECT_FORCEMELEE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_9_ForceMelee;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_9_ForceMelee;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_FIREMELEE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_10_FireMelee;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = Event_PlayerHit_10_FireMelee;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_SCHADENFREUDE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_11_Schadenfreude;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_11_Schadenfreude;
          }

          case EFFECT_RNGDEATH: {
               g_OnRoundStartFuncPtr = Event_RoundStart_12_RNGDeath;
               g_OnRoundEndFuncPtr = Event_RoundEnd_12_RNGDeath;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_MATH: {
               g_OnRoundStartFuncPtr = Event_RoundStart_13_Math;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_13_Math;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_13_Math;
          }

          case EFFECT_WEAKLINGS: {
               g_OnRoundStartFuncPtr = Event_RoundStart_14_Weaklings;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = Event_PlayerHit_14_Weaklings;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_BLEEDBUFFED: {
               g_OnRoundStartFuncPtr = Event_RoundStart_15_BleedBuff;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = Event_PlayerHit_15_BleedBuff;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }
     }
     return id;
}