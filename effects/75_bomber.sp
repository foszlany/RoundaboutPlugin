#pragma semicolon 1

#define E75_MAXDMG 200.0
#define E75_RADIUS 300.0

public void Event_RoundStart_75_SuicideBomber(Event event, const char[] name, bool dontBroadcast) {
     AddCommandListener(E75_OnSuicide, "kill");
     AddCommandListener(E75_OnSuicide, "explode");
}

public void Event_PlayerDeath_75_SuicideBomber(Event event, const char[] name, bool dontBroadcast) {
     int victim = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(IsClientInGame(victim) && (attacker <= 0 || attacker > MaxClients || attacker == victim)) {
          E75_CreateExplosion(victim);
     }
}

public void Event_RoundEnd_75_SuicideBomber(Event event, const char[] name, bool dontBroadcast) {
     RemoveCommandListener(E75_OnSuicide, "kill");
     RemoveCommandListener(E75_OnSuicide, "explode");
}

public Action E75_OnSuicide(int client, const char[] command, int argc) {
     E75_CreateExplosion(client);
     return Plugin_Continue;
}

public void E75_CreateExplosion(int client) {
     float origin[3];
     GetClientAbsOrigin(client, origin);

     TFTeam team = TF2_GetClientTeam(client);

     for(int i = 1; i <= MaxClients; i++) {
          if(!IsClientInGame(i) || !IsPlayerAlive(i) || TF2_GetClientTeam(i) == team) {
               continue;
          }

          float targetPos[3];
          GetClientAbsOrigin(i, targetPos);

          float distance = GetVectorDistance(origin, targetPos);

          if(distance <= E75_RADIUS) {
               float scaled = E75_MAXDMG * (1.0 - (distance / E75_RADIUS));
               SDKHooks_TakeDamage(i, client, client, scaled, DMG_BLAST);
          }
     }

     EmitSoundToAll("weapons/explode3.wav", SNDCHAN_AUTO, SNDLEVEL_NORMAL, _, _, 0.7, _, _, origin);
}
