#pragma semicolon 1

public void Event_RoundStart_33_Invis(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               CreateTimer(0.1, E33_ApplyInvisibilityTimer, i);
          }
     }
}

public void Event_PlayerUpdate_33_Invis(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     CreateTimer(0.1, E33_ApplyInvisibilityTimer, client);
}

public void Event_RoundEnd_33_Invis(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               ApplyInvisibility(i, false);
          }
     }
}

public Action E33_ApplyInvisibilityTimer(Handle timer, int client) {
     if(client > 0 && IsClientInGame(client) && IsPlayerAlive(client)) {
          ApplyInvisibility(client, true);
     }

     return Plugin_Handled;
}