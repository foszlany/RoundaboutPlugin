#pragma semicolon 1

#define E72_RESPAWN_TIME 10.0

public void Event_RoundEnd_72_FreeRespawn(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          NullifyClientRespawnData(i);

          if(IsClientInGame(i) && !IsPlayerAlive(i) && g_Effect72_PreviousTeam[i] != TFTeam_Unassigned) {
               TF2_ChangeClientTeam(i, g_Effect72_PreviousTeam[i]);
               TF2_RespawnPlayer(i);
               TF2_RemoveCondition(i, TFCond_HalloweenGhostMode);
          }
     }
}

public void Event_PlayerDeath_72_FreeRespawn(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     if(!IsClientInGame(client) || IsFakeClient(client) || (event.GetInt("death_flags") & 32)) {
          return;
     }

     g_Effect72_RespawnTime[client] = GetGameTime() + E72_RESPAWN_TIME;

     GetClientAbsOrigin(client, g_Effect72_DeathPos[client]);
     GetClientAbsAngles(client, g_Effect72_DeathAng[client]);

     g_Effect72_HudTimer[client] = CreateTimer(0.5, RespawnHudTick, client, TIMER_REPEAT);
     g_Effect72_RespawnTimer[client] = CreateTimer(E72_RESPAWN_TIME, FreeRespawnPlayer, client);
     CreateTimer(0.1, RespawnPlayerGhost, client);
}

public Action RespawnPlayerGhost(Handle timer, int client) {
     TF2_RespawnPlayer(client);
     TeleportEntity(client, g_Effect72_DeathPos[client], g_Effect72_DeathAng[client], NULL_VECTOR);
     TF2_AddCondition(client, TFCond_HalloweenGhostMode, TFCondDuration_Infinite);

     return Plugin_Handled;
}

public Action RespawnHudTick(Handle timer, int client) {
     if(!IsClientInGame(client)) {
          return Plugin_Handled;
     }

     float remaining = g_Effect72_RespawnTime[client] - GetGameTime();
     if(remaining <= 0.0) {
          return Plugin_Continue;
     }

     char msg[64];
     Format(msg, sizeof(msg), "Respawning in %.0f seconds...", remaining);

     SetHudTextParams(-1.0, 0.2, 3.0, 255, 255, 255, 255);
     ShowHudText(client, 1, msg);

     return Plugin_Continue;
}

public Action FreeRespawnPlayer(Handle timer, int client) {
     if(!IsClientInGame(client)) {
          return Plugin_Handled;
     }

     TF2_RemoveCondition(client, TFCond_HalloweenGhostMode);

     NullifyClientRespawnData(client);
     return Plugin_Handled;
}

public void NullifyClientRespawnData(int client) {
     if(g_Effect72_HudTimer[client] != null) {
          KillTimer(g_Effect72_HudTimer[client]);
          KillTimer(g_Effect72_RespawnTimer[client]);
          g_Effect72_HudTimer[client] = null;
          g_Effect72_RespawnTimer[client] = null;

          SetHudTextParams(-1.0, 0.2, 0.0, 0, 0, 0, 0);
          ShowHudText(client, 1, "");
     }
}
