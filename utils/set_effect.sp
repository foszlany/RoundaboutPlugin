#pragma semicolon 1

public int setEffect(int id) {
     if(id == -1) {
          id = GetRandomInt(0, EFFECT_MAXCOUNT - EFFECT_LOWGRAVITY);
     }

     switch(id) {
          case EFFECT_PURE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_0_Pure;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_LOWGRAVITY: {
               g_OnRoundStartFuncPtr = Event_RoundStart_1_LowGravity;
               g_OnRoundEndFuncPtr = Event_RoundEnd_1_LowGravity;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_MINICRIT: {
               g_OnRoundStartFuncPtr = Event_RoundStart_2_MiniCrit;
               g_OnRoundEndFuncPtr = Event_RoundEnd_2_MiniCrit;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_2_MiniCrit;
          }

          case EFFECT_CRIT: {
               g_OnRoundStartFuncPtr = Event_RoundStart_3_Crit;
               g_OnRoundEndFuncPtr = Event_RoundEnd_3_Crit;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_3_Crit;
          }

          case EFFECT_SPEEDBOOST: {
               g_OnRoundStartFuncPtr = Event_RoundStart_4_SpeedBoost;
               g_OnRoundEndFuncPtr = Event_RoundEnd_4_SpeedBoost;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_4_SpeedBoost;
          }

          default:
               return id;
     }
     return id;
}