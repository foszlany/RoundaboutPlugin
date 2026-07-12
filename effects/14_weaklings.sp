#pragma semicolon 1

#define E14_DAMAGE 0.33

public void Event_RoundStart_14_Weaklings(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2Attrib_SetByName(i, "dmg taken increased", E14_DAMAGE);
               TF2Attrib_SetByName(i, "dmg penalty vs buildings", E14_DAMAGE);
          }
     }
}

public void Event_PlayerUpdate_14_Weaklings(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     TF2Attrib_SetByName(client, "dmg taken increased", E14_DAMAGE);
     TF2Attrib_SetByName(client, "dmg penalty vs buildings", E14_DAMAGE);
}


public void Event_RoundEnd_14_Weaklings(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               TF2Attrib_RemoveByName(i, "dmg taken increased");
               TF2Attrib_RemoveByName(i, "dmg penalty vs buildings");
          }
     }
}