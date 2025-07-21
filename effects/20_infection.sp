#pragma semicolon 1

public void Event_RoundStart_20_Infection(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MAXPLAYERS; i++) {
          if(i <= MaxClients && IsClientInGame(i)) {
               g_Effect20_CurrentTeam[i] = TF2_GetClientTeam(i);
          }
          else {
               g_Effect20_CurrentTeam[i] = view_as<TFTeam>(GetRandomInt(2, 3));
          }
     }

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerDeath_20_Infection(Event event, const char[] name, bool dontBroadcast) {
     int victim = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(TF2_GetClientTeam(victim) != g_Effect20_CurrentTeam[victim]) {
          ChangeClientTeam(victim, g_Effect20_CurrentTeam[victim]);
          return;
     }

     if(victim == attacker || attacker == 0) {
          return;
     }

     if(IsClientInGame(victim)) {
          TFTeam attackerTeam = TF2_GetClientTeam(attacker);

          TF2_ChangeClientTeam(victim, attackerTeam);
          g_Effect20_CurrentTeam[victim] = attackerTeam;
     }

     InfectionTeamCheck();
}

public void Event_RoundEnd_20_Infection(Event event, const char[] name, bool dontBroadcast) {
     // TEMPORARY SCRAMBLE
     for(int i = 1; i <= MaxClients; i += 2) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TFTeam clientTeam = TF2_GetClientTeam(i);
               if(clientTeam != TFTeam_Blue && clientTeam != TFTeam_Red) {
                    return;
               }

               TF2_ChangeClientTeam(i, clientTeam == TFTeam_Red ? TFTeam_Blue : TFTeam_Red);
          }
     }
}

public void InfectionTeamCheck() {
     int redPlayers = 0;
     int bluPlayers = 0;

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               TFTeam playerTeam = TF2_GetClientTeam(i);

               if(playerTeam == TFTeam_Red) {
                    redPlayers++;
               }
               if(playerTeam == TFTeam_Blue) {
                    bluPlayers++;
               }
          }
     }

     if(redPlayers && bluPlayers > 0) {
          return;
     }
     else if(redPlayers == 0) {
          ForceWin(TFTeam_Blue);
          PrintToChatAll("\x07B143F1[Roundabout]\x01 \x075885A2BLU\x01 has infected all players and won!");
     }
     else {
          ForceWin(TFTeam_Red);
          PrintToChatAll("\x07B143F1[Roundabout]\x01 \x07B8383BRED\x01 has infected all players and won!");
     }
}