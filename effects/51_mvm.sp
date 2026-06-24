#pragma semicolon 1

public void Event_RoundStart_51_Mvm(Event event, const char[] name, bool dontBroadcast) {
     ConVar quota = FindConVar("tf_bot_quota");
     ConVar quotaMode = FindConVar("tf_bot_quota_mode");

     g_Effect51_OriginalBotCount = quota.IntValue;

     quotaMode.SetString("normal", true, false);

     int playerCount = CountActivePlayers();
     int newBotCount = RoundToFloor(playerCount * 1.1) + 1;

     quota.SetInt(newBotCount, true, false);

     g_Effect51_RealPlayerTeam = view_as<TFTeam>(GetRandomInt(2, 3));

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && !IsFakeClient(i) && TF2_GetClientTeam(i) != g_Effect51_RealPlayerTeam) {
               ChangeClientTeam(i, g_Effect51_RealPlayerTeam);
          }
     }bots
}

public void Event_PlayerUpdate_51_Mvm(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(!IsFakeClient(client) && TF2_GetClientTeam(client) != g_Effect51_RealPlayerTeam) {
          ChangeClientTeam(client, g_Effect51_RealPlayerTeam);
     }
}

public void Event_RoundEnd_51_Mvm(Event event, const char[] name, bool dontBroadcast) {
     ConVar quota = FindConVar("tf_bot_quota");
     quota.SetInt(g_Effect51_OriginalBotCount, true, false);
}
