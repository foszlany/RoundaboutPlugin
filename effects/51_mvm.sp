#pragma semicolon 1

public void Event_RoundStart_51_Mvm(Event event, const char[] name, bool dontBroadcast) {
     g_Effect51_RealPlayerTeam = view_as<TFTeam>(GetRandomInt(2, 3));

     int playerCount = CountActivePlayers();
     g_Effect51_OriginalBotCount = CountActiveFakePlayers();

     int newBotcount = RoundToFloor(playerCount * 1.1) + 1;
     
     ServerCommand("tf_bot_kick all");

     ServerCommand("tf_bot_add %d %s", newBotcount - g_Effect51_OriginalBotCount, g_Effect51_RealPlayerTeam == TFTeam_Red ? "blu" : "red");

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               if(!IsFakeClient(i) && TF2_GetClientTeam(i) != g_Effect51_RealPlayerTeam) {
                    ChangeClientTeam(i, g_Effect51_RealPlayerTeam);
               }
          }
     }

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_51_Mvm(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(!IsFakeClient(client) && TF2_GetClientTeam(client) != g_Effect51_RealPlayerTeam) {
          ChangeClientTeam(client, g_Effect51_RealPlayerTeam);
     }
}

public void Event_RoundEnd_51_Mvm(Event event, const char[] name, bool dontBroadcast) {
     int currentBotCount = CountActiveFakePlayers();

     for(int i = 1; i <= MaxClients; i++) {
          if(currentBotCount > g_Effect51_OriginalBotCount && IsClientInGame(i) && IsFakeClient(i)) {
               ServerCommand("tf_bot_kick %N", i);
               currentBotCount--;
          }
     }

     currentBotCount = CountActiveFakePlayers();
     if(currentBotCount < g_Effect51_OriginalBotCount) {
          ServerCommand("tf_bot_add %d", g_Effect51_OriginalBotCount - currentBotCount);
          currentBotCount++;
     }
}