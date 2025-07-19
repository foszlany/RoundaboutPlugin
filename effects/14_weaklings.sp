#pragma semicolon 1

public void Event_RoundStart_14_Weaklings(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2Attrib_SetByName(i, "dmg taken increased", 0.3333333);
               TF2Attrib_SetByName(i, "dmg penalty vs buildings", 0.3333333);
          }
     }

     ShowCurrentEffectDescription(-1);
}

public void Event_PlayerUpdate_14_Weaklings(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     TF2Attrib_SetByName(client, "dmg taken increased", 0.3333333);
     TF2Attrib_SetByName(client, "dmg penalty vs buildings", 0.3333333);
}


public void Event_RoundEnd_14_Weaklings(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               TF2Attrib_RemoveByName(i, "dmg taken increased");
               TF2Attrib_RemoveByName(i, "dmg penalty vs buildings");
          }
     }
}