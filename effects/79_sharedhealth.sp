#pragma semicolon 1

#define E79_HEALTH_PER_PLAYER 300
#define E79_MIN_HEALTH 500

public void Event_RoundStart_79_SharedHealth(Event event, const char[] name, bool dontBroadcast) {
     E79_CalculateTeamHealth(TFTeam_Blue);
     E79_CalculateTeamHealth(TFTeam_Red);

     for(int i = 1; i <= MaxClients; i++) {
          if(!IsClientInGame(i) || !IsPlayerAlive(i)) {
               continue;
          }

          E79_CheckAndSwapFromSpy(i);
          CreateTimer(0.1, E79_SetSharedHealth, i);
     }
}

public void Event_RoundEnd_79_SharedHealth(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_RegeneratePlayer(i);
          }
     }
}

public void Event_PlayerUpdate_79_SharedHealth(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     if(!IsClientInGame(client) || !IsPlayerAlive(client)) {
          return;
     }

     E79_CheckAndSwapFromSpy(client);
     CreateTimer(0.1, E79_SetSharedHealth, client);
}

public void Event_PlayerHit_79_SharedHealth(Event event, const char[] name, bool dontBroadcast) {
     int victim = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));
     int damageamount = event.GetInt("damageamount");

     if(!IsClientInGame(victim) || !IsPlayerAlive(victim) || victim == attacker || attacker <= 0 || attacker > MaxClients) {
          return;
     }

     TFTeam team = TF2_GetClientTeam(victim);

     if(team == TFTeam_Red) {
          g_Effect79_RedHealth -= damageamount;

          if(g_Effect79_RedHealth <= 0) {
               E79_KillTeam(TFTeam_Red);
               E79_CalculateTeamHealth(TFTeam_Red);
               PrintToChatAll("\x07B143F1[Roundabout]\x01 \x07FF4040RED\x01 has fallen!");
               return;
          }

          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i) && IsPlayerAlive(i) && TF2_GetClientTeam(i) == TFTeam_Red) {
                    CreateTimer(0.1, E79_SetSharedHealth, i);
               }
          }
     }
     else if(team == TFTeam_Blue) {
          g_Effect79_BluHealth -= damageamount;

          if(g_Effect79_BluHealth <= 0) {
               E79_KillTeam(TFTeam_Blue);
               E79_CalculateTeamHealth(TFTeam_Blue);
               PrintToChatAll("\x07B143F1[Roundabout]\x01 \x0766C0FABLU\x01 has fallen!");
               return;
          }

          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i) && IsPlayerAlive(i) && TF2_GetClientTeam(i) == TFTeam_Blue) {
                    CreateTimer(0.1, E79_SetSharedHealth, i);
               }
          }
     }
}

public Action E79_SetSharedHealth(Handle timer, int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          TFTeam team = TF2_GetClientTeam(client);
          
          if(team == TFTeam_Red) {
               SetEntityHealth(client, g_Effect79_RedHealth);
          }
          else if(team == TFTeam_Blue) {
               SetEntityHealth(client, g_Effect79_BluHealth);
          }
     }

     return Plugin_Handled;
}

public void E79_KillTeam(TFTeam team) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i) && TF2_GetClientTeam(i) == team) {
               ForcePlayerSuicide(i);
          }
     }
}

public void E79_CalculateTeamHealth(TFTeam team) {
     int teamCount = 0;

     for(int i = 1; i <= MaxClients; i++) {
          if(!IsClientInGame(i)) {
               continue;
          }

          if(TF2_GetClientTeam(i) == team) {
               teamCount++;
          }
     }

     if(team == TFTeam_Red) {
          g_Effect79_RedHealth = E79_MIN_HEALTH + teamCount * E79_HEALTH_PER_PLAYER;
     }
     else if(team == TFTeam_Blue) {
          g_Effect79_BluHealth = E79_MIN_HEALTH + teamCount * E79_HEALTH_PER_PLAYER;
     }
}

public void E79_CheckAndSwapFromSpy(int client) {
     if(TF2_GetPlayerClass(client) == TFClass_Spy) {
          TF2_SetPlayerClass(client, TFClass_Scout);
          TF2_RegeneratePlayer(client);
          PrintToChat(client, "\x07B143F1[Roundabout]\x01 \x07D5D5D5Spy\x01 is not allowed for this round.");
     }
}