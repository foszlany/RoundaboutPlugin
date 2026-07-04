public Action HandleCooldown(Handle timer) {
     char hudText[8];
     
     for(int i = 0; i < g_EffectCount; i++) {
          if(g_CooldownEffects[i] == EFFECT_INVALID) {
               break;
          }

          SetHudTextParams(0.95, 0.8 - i * 0.04, 0.15, g_CooldownColorR[i], g_CooldownColorG[i], g_CooldownColorB[i], 255);

          for(int client = 1; client <= MaxClients; client++) {
               if(!IsClientInGame(client) || !IsPlayerAlive(client)) {
                    continue;
               }

               float timeLeft = g_CooldownTimes[i][client] - GetGameTime();
               if(timeLeft > 0.0) {
                    Format(hudText, sizeof(hudText), "%.1fs", timeLeft);
               }
               else {
                    Format(hudText, sizeof(hudText), "Ready");
               }
                         
               ShowHudText(client, 10 + i, hudText);
          }
     }

     return Plugin_Handled;
}

public void SignalCooldown(Effect e, int r, int g, int b) {
     g_CooldownEffects[g_CooldownCount] = e;
     g_CooldownColorR[g_CooldownCount] = r;
     g_CooldownColorG[g_CooldownCount] = g;
     g_CooldownColorB[g_CooldownCount] = b;
     g_CooldownCount++
}

public void AddCooldown(Effect e, int client, float time) {
    float expireTime = GetGameTime() + time;

     for(int i = 0; i < g_EffectCount; i++) {
          if(g_CooldownEffects[i] == e) {
               g_CooldownTimes[i][client] = expireTime;
               break;
          }
     }
}
