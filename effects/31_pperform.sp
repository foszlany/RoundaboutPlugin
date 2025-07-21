#pragma semicolon 1

public void Event_RoundStart_31_PPerform(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               ApplyVulnerability(i);
          }
     }

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_31_PPerform(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     ApplyVulnerability(client);
}

public void Event_PlayerDeath_31_PPerform(Event event, const char[] name, bool dontBroadcast) {
     int attacker = GetClientOfUserId(event.GetInt("attacker"));
     ApplyVulnerability(attacker);
}


public void Event_RoundEnd_31_PPerform(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               TF2Attrib_RemoveByName(i, "dmg taken from bullets increased");
               TF2Attrib_RemoveByName(i, "dmg taken from blast increased");
               TF2Attrib_RemoveByName(i, "dmg taken from fire increased");
          }
     }
}

void ApplyVulnerability(int client) {
     float kills   = float(GetClientFrags(client));
     float deaths  = float(GetClientDeaths(client));
     float fDeaths = (deaths <= 0.0) ? 1.0 : deaths;
     float kd      = kills / fDeaths;

     if(kd <= 1.0) {
          return;
     }

     float log2kd = Logarithm(kd) / Logarithm(2.0);

     float extra = log2kd * 0.5;
     extra       = (extra < 0.0) ? 0.0 : (extra > 2.0 ? 2.0 : extra);

     float multiplier = 1.0 + extra;

     TF2Attrib_SetByName(client, "dmg taken from bullets increased", multiplier);
     TF2Attrib_SetByName(client, "dmg taken from blast increased", multiplier);
     TF2Attrib_SetByName(client, "dmg taken from fire increased", multiplier);
}
