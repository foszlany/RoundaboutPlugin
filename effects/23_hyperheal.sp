#pragma semicolon 1

public void Event_RoundStart_23_Hyperheal(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2Attrib_SetByName(i, "patient overheal penalty", 999.0);
          }
     }

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_23_Hyperheal(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     TF2Attrib_SetByName(client, "patient overheal penalty", 999.0);
}

public void Event_RoundEnd_23_Hyperheal(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               TF2Attrib_RemoveByName(i, "patient overheal penalty");
          }
     }
}