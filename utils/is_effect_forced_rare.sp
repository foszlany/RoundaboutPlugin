bool IsRareEffectForced(Effect effect) {
     for(int i = 0; i < g_EffectCount; i++) {
          if(g_isForced && !g_isForcedRandom && g_CurrentEffects[i] == effect && g_IsForcedRare[i] == true) {
               return true;
          }
     }

     return false;
}