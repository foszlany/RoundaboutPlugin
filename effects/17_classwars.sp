#pragma semicolon 1

public void Event_RoundStart_17_ClassWars(Event event, const char[] name, bool dontBroadcast) {
     g_Effect17_RedTeamClass = GetRandomInt(1, 9);
     g_Effect17_BluTeamClass = GetRandomInt(1, 9);

     for(int i = 1; i <= MaxClients; i++) {
          ForceClassWarsTeam(i);
     }

     char classRed[9];
     GetClassString(g_Effect17_RedTeamClass, classRed, sizeof(classRed));

     char classBlu[9];
     GetClassString(g_Effect17_BluTeamClass, classBlu, sizeof(classBlu));
      
     PrintToChatAll("\x07B143F1[Roundabout]\x01 This round's matchup: %s vs. %s.", classRed, classBlu);

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_17_ClassWars(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     ForceClassWarsTeam(client);
}

public void ForceClassWarsTeam(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          if(TF2_GetClientTeam(client) == TFTeam_Red && TF2_GetPlayerClass(client) != view_as<TFClassType>(g_Effect17_RedTeamClass)) {
               TF2_SetPlayerClass(client, view_as<TFClassType>(g_Effect17_RedTeamClass), false);
               TF2_RegeneratePlayer(client);
          }
          else if(TF2_GetClientTeam(client) == TFTeam_Blue && TF2_GetPlayerClass(client) != view_as<TFClassType>(g_Effect17_BluTeamClass)) {
               TF2_SetPlayerClass(client, view_as<TFClassType>(g_Effect17_BluTeamClass), false);
               TF2_RegeneratePlayer(client);
          }
     }
}