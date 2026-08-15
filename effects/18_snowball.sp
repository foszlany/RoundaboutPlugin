#pragma semicolon 1

#define E18_EFFECT_DURATION 8.0

public void Event_RoundStart_18_Snowball(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          g_Effect18_EffectIndex[i] = 0;
          g_Effect18_EffectTimer[i] = null;
     }
}

public void Event_PlayerDeath_18_Snowball(Event event, const char[] name, bool dontBroadcast) {
     int victim = GetClientOfUserId(event.GetInt("userid"));
     g_Effect18_EffectIndex[victim] = 0;
     E18_SnowballKillTimer(victim);

     int attacker = GetClientOfUserId(event.GetInt("attacker"));
     
     if(attacker > 0 && IsClientInGame(attacker) && IsPlayerAlive(attacker)) {
          if(g_Effect18_EffectIndex[attacker] < 7) {
               E18_SnowballKillTimer(attacker);
          }
          
          switch(++g_Effect18_EffectIndex[attacker]) {
               case 1: TF2_AddCondition(attacker, TFCond_SpeedBuffAlly);
               case 2: TF2_AddCondition(attacker, TFCond_Buffed);
               case 3: TF2_AddCondition(attacker, TFCond_UberFireResist);
               case 4: TF2_AddCondition(attacker, TFCond_UberBlastResist);
               case 5: TF2_AddCondition(attacker, TFCond_UberBulletResist);
               case 6: TF2_AddCondition(attacker, TFCond_CritOnWin);
               case 7: {
                    TF2_AddCondition(attacker, TFCond_UberchargedCanteen);
                    PrintToChatAll("\x07B143F1[Roundabout]\x01 %N has achieved perfection!", attacker);
               }
          }

          g_Effect18_EffectTimer[attacker] = CreateTimer(E18_EFFECT_DURATION, E18_E18_SnowballRemoveEffectsTimer, attacker);
     }
}

public void Event_RoundEnd_18_Snowball(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          E18_SnowballRemoveEffects(i);
          E18_SnowballKillTimer(i);
     }
}

public Action E18_E18_SnowballRemoveEffectsTimer(Handle timer, int client) {
     g_Effect18_EffectTimer[client] = null;
     g_Effect18_EffectIndex[client] = 0;
     E18_SnowballRemoveEffects(client);
     
     return Plugin_Handled;
}

public void E18_SnowballRemoveEffects(int client) {
     if(IsClientInGame(client)) {
          TF2_RemoveCondition(client, TFCond_SpeedBuffAlly);
          TF2_RemoveCondition(client, TFCond_Buffed);
          TF2_RemoveCondition(client, TFCond_UberFireResist);
          TF2_RemoveCondition(client, TFCond_UberBlastResist);
          TF2_RemoveCondition(client, TFCond_UberBulletResist);
          TF2_RemoveCondition(client, TFCond_CritOnWin);
          TF2_RemoveCondition(client, TFCond_UberchargedCanteen);
     }
}

public void E18_SnowballKillTimer(int client) {
     if(g_Effect18_EffectTimer[client] != null) {
        KillTimer(g_Effect18_EffectTimer[client]);
        g_Effect18_EffectTimer[client] = null;
     }
}