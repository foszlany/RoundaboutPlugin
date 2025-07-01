#pragma semicolon 1

public void Event_RoundStart_20_Infection(Event event, const char[] name, bool dontBroadcast) {
     PrintCenterTextAll("Infection Tag");
     ShowHintToAllClients("Infection Tag\n\nBring killed players into your team and try to win.");
}

public void Event_PlayerDeath_20_Infection(Event event, const char[] name, bool dontBroadcast) {
     int victim = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(victim == attacker || attacker == 0) {
          return;
     }

     if(IsClientInGame(victim)) {
          TF2_ChangeClientTeam(victim, TF2_GetClientTeam(attacker));
     }

     InfectionTeamCheck();
}

public void Event_RoundEnd_20_Infection(Event event, const char[] name, bool dontBroadcast) {
     ServerCommand("mp_scrambleteams"); // this needs fixing
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