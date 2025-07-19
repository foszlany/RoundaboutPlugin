#pragma semicolon 1

public void Event_RoundStart_8_StrongSuit(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MAXPLAYERS; i++) {
          if(i <= MaxClients && IsClientInGame(i) && IsPlayerAlive(i)) {
               CreateTimer(0.2, GiveRandomInvuln_Timer, i);
          }
          else {
               g_Effect8_InvulnIndex[i] = -1;
          }
     }

     ShowCurrentEffectDescription(-1);
}

public void Event_PlayerUpdate_8_StrongSuit(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     if(g_Effect8_InvulnIndex[client] != -1) {
          switch(g_Effect8_InvulnIndex[client]) {
               case 0: {
                    TF2_AddCondition(client, TFCond_BulletImmune);
                    return;
               }
               case 1: {
                    TF2_AddCondition(client, TFCond_BlastImmune);
                    return;
               }
               case 2: {
                    TF2_AddCondition(client, TFCond_FireImmune);
                    return;
               }
          }
     }
     else {
          CreateTimer(0.2, GiveRandomInvuln_Timer, client);
     }
}

public void Event_PlayerDeath_8_StrongSuit(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     g_Effect8_InvulnIndex[client] = -1;
}

public void Event_RoundEnd_8_StrongSuit(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_RemoveCondition(i, TFCond_BulletImmune);
               TF2_RemoveCondition(i, TFCond_BlastImmune);
               TF2_RemoveCondition(i, TFCond_FireImmune);
          }
     }
}

public Action GiveRandomInvuln_Timer(Handle timer, int client) {
     GiveRandomInvuln(client);

     return Plugin_Handled;
}

public void GiveRandomInvuln(int client) {
     int effect = GetRandomInt(0, 2);

     switch(effect) {
          case 0: {
               TF2_AddCondition(client, TFCond_BulletImmune);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 You are invulnerable to \x07C1C1C1Bullets\x01");
          }
          case 1: {
               TF2_AddCondition(client, TFCond_BlastImmune);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 You are invulnerable to \x07ED6240Explosions\x01");
          }
          case 2: {
               TF2_AddCondition(client, TFCond_FireImmune);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 You are invulnerable to \x07FFE400Fire\x01");
          }
     }

     g_Effect8_InvulnIndex[client] = effect;
}