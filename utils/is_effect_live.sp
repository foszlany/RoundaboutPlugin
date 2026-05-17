bool isEffectLive(Effect effect) {
     for(int i = 0; i < g_EffectCount; i++) {
          if(g_CurrentEffects[i] == effect) {
               return true;
          }
     }

     return false;
}