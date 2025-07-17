#pragma semicolon 1

public void Event_RoundStart_18_Snowball(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          g_Effect18_EffectIndex[i] = 0;
          g_Effect18_EffectTimer[i] = null;
     }

     PrintCenterTextAll("Snowball");
     ShowHintToAllClients("Snowball\n\nChain kills to receive better temporary effects.");
}

public void Event_PlayerDeath_18_Snowball(Event event, const char[] name, bool dontBroadcast) {
     int victim = GetClientOfUserId(event.GetInt("userid"));
     g_Effect18_EffectIndex[victim] = 0;
     SnowballKillTimer(victim);

     int attacker = GetClientOfUserId(event.GetInt("attacker"));
     
     if(attacker > 0 && IsClientInGame(attacker) && IsPlayerAlive(attacker)) {
          SnowballKillTimer(attacker);
          
          switch(++g_Effect18_EffectIndex[attacker]) {
               case 1: TF2_AddCondition(attacker, TFCond_SpeedBuffAlly);
               case 2: TF2_AddCondition(attacker, TFCond_Buffed);
               case 3: TF2_AddCondition(attacker, TFCond_DefenseBuffed);
               case 4: TF2_AddCondition(attacker, TFCond_CritOnWin);
               case 5: TF2_AddCondition(attacker, TFCond_UberchargedCanteen);
          }

          g_Effect18_EffectTimer[attacker] = CreateTimer(8.0, SnowballRemoveEffectsTimer, attacker);
     }
}

public void Event_RoundEnd_18_Snowball(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          SnowballRemoveEffects(i);
          SnowballKillTimer(i);
     }
}

public Action SnowballRemoveEffectsTimer(Handle timer, int client) {
     g_Effect18_EffectTimer[client] = null;
     g_Effect18_EffectIndex[client] = 0;
     SnowballRemoveEffects(client);
     
     return Plugin_Handled;
}

public void SnowballRemoveEffects(int client) {
     if(IsClientInGame(client)) {
          TF2_RemoveCondition(client, TFCond_SpeedBuffAlly);
          TF2_RemoveCondition(client, TFCond_Buffed);
          TF2_RemoveCondition(client, TFCond_DefenseBuffed);
          TF2_RemoveCondition(client, TFCond_CritOnWin);
          TF2_RemoveCondition(client, TFCond_UberchargedCanteen);
     }
}

public void SnowballKillTimer(int client) {
     if(g_Effect18_EffectTimer[client] != null) {
        KillTimer(g_Effect18_EffectTimer[client]);
        g_Effect18_EffectTimer[client] = null;
     }
}