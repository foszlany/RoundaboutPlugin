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

     E75_DamagePlayers(client, origin, team);
     E75_DamageBuildings(client, origin, team);

     EmitSoundToAll("weapons/explode3.wav", SNDCHAN_AUTO, SNDLEVEL_NORMAL, _, _, 0.7, _, _, origin);
     CreateStaticParticle(client, "ExplosionCore_MidAir", 1.5, 0.0);
}

public void E75_DamagePlayers(int client, float origin[3], TFTeam team) {
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
}

public void E75_DamageBuildings(int client, float origin[3], TFTeam team) {
     static const char buildingClasses[][] = {
          "obj_sentrygun",
          "obj_dispenser",
          "obj_teleporter"
     };

     for(int c = 0; c < sizeof(buildingClasses); c++) {
          int ent = -1;
          while((ent = FindEntityByClassname(ent, buildingClasses[c])) != -1) {
               if(!IsValidEntity(ent) || view_as<TFTeam>(GetEntProp(ent, Prop_Send, "m_iTeamNum")) == team) {
                    continue;
               }


               float pos[3];
               GetEntPropVector(ent, Prop_Send, "m_vecOrigin", pos);

               float distance = GetVectorDistance(origin, pos);
               if(distance > E75_RADIUS) {
                    continue;
               }

               float scaled = E75_MAXDMG * (1.0 - (distance / E75_RADIUS));

               SDKHooks_TakeDamage(ent, client, client, scaled, DMG_BLAST);
          }
     }
}

