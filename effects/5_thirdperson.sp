#pragma semicolon 1

public void Event_RoundStart_5_ThirdPerson(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               CreateTimer(0.2, E5_SetViewOnSpawn, i); 
          }
     }
}

public void Event_PlayerUpdate_5_ThirdPerson(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     CreateTimer(0.2, E5_SetViewOnSpawn, client); 
}

public void Event_RoundEnd_5_ThirdPerson(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               SetVariantInt(0);
               AcceptEntityInput(i, "SetForcedTauntCam");
          }
     }
}

/* DELAY SLIGHTLY TO AVOID INCONSISTENCIES */
public Action E5_SetViewOnSpawn(Handle timer, int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          SetVariantInt(1);
          AcceptEntityInput(client, "SetForcedTauntCam");
     }

     return Plugin_Handled;
}