bool IsRareEffectForced(Effect effect) {
     for(int i = 0; i < g_EffectCount; i++) {
          if(g_IsForced && !g_IsForcedRandom && g_CurrentEffects[i] == effect && g_IsForcedRare[i] == true) {
               return true;
          }
     }

     return false;
}