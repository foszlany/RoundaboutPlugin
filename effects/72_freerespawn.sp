#pragma semicolon 1

public void Event_RoundEnd_72_FreeRespawn(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          NullifyClientRespawnData(i);

          if(IsClientInGame(i) && !IsPlayerAlive(i) && g_Effect72_PreviousTeam[i] != TFTeam_Unassigned) {
               TF2_ChangeClientTeam(i, g_Effect72_PreviousTeam[i]);
               TF2_RespawnPlayer(i);
          }
     }
}

public void Event_PlayerDeath_72_FreeRespawn(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(!IsClientInGame(client) || IsFakeClient(client) || event.GetInt("death_flags") & 32) {
          return;
     }

     float respawnTime = 10.0;

     g_Effect72_PreviousTeam[client] = TF2_GetClientTeam(client);
     g_Effect72_RespawnTime[client] = GetGameTime() + respawnTime;

     TF2_ChangeClientTeam(client, TFTeam_Spectator);

     SetEntPropEnt(client, Prop_Send, "m_hObserverTarget", -1);
     SetEntProp(client, Prop_Send, "m_iObserverMode", 4);

     g_Effect72_HudTimer[client] = CreateTimer(1.0, RespawnHudTick, client, TIMER_REPEAT);
     g_Effect72_RespawnTimer[client] = CreateTimer(respawnTime, FreeRespawnPlayer, client);
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

     SetHudTextParams(-1.0, 0.2, 5.0, 255, 255, 255, 255);
     ShowHudText(client, 1, msg);

     return Plugin_Continue;
}

public Action FreeRespawnPlayer(Handle timer, int client) {
     if(!IsClientInGame(client)) {
          return Plugin_Handled;
     }

     float pos[3], ang[3];
     GetClientAbsOrigin(client, pos);
     GetClientAbsAngles(client, ang);

     TF2_ChangeClientTeam(client, g_Effect72_PreviousTeam[client]);
     TF2_RespawnPlayer(client);
     TeleportEntity(client, pos, ang, NULL_VECTOR);

     float currentPos[3];
     GetClientAbsOrigin(client, currentPos);
     if(GetVectorDistance(currentPos, pos) > 0.1) {
          PrintToChat(client, "\x07B143F1[Roundabout]\x01 Invalid target.");
     }

     NullifyClientRespawnData(client);
     return Plugin_Handled;
}

public void NullifyClientRespawnData(int client) {
     if(g_Effect72_HudTimer[client] != null) {
          KillTimer(g_Effect72_HudTimer[client]);
          KillTimer(g_Effect72_RespawnTimer[client]);
          g_Effect72_HudTimer[client] = null;
          g_Effect72_RespawnTimer[client] = null;
     }
}