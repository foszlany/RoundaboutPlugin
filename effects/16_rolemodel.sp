#pragma semicolon 1

public void Event_RoundStart_16_Rolemodel(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MAXPLAYERS; i++) {
          // CONNECTING PLAYERS WILL RECEIVE THE SAME INDEX, BUT IT SHOULDN'T MATTER
          g_Effect16_AssignedClass[i] = GetRandomInt(1, 9);
          if(i <= MaxClients && IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_SetPlayerClass(i, view_as<TFClassType>(g_Effect16_AssignedClass[i]), false);
               TF2_RegeneratePlayer(i);
          }
     }

     ShowCurrentEffectDescription(-1);
}

public void Event_PlayerUpdate_16_Rolemodel(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     if(IsClientInGame(client) && IsPlayerAlive(client) && view_as<TFClassType>(g_Effect16_AssignedClass[client]) != TF2_GetPlayerClass(client)) {
          TF2_SetPlayerClass(client, view_as<TFClassType>(g_Effect16_AssignedClass[client]), false);
          TF2_RegeneratePlayer(client);
     }
}