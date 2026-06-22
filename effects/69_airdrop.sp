#pragma semicolon 1

public void Event_RoundStart_69_Airdrop(Event event, const char[] name, bool dontBroadcast) {
     HookEvent("player_spawn", Event_PlayerSpawn_Post, EventHookMode_Post);
}

public void Event_RoundEnd_69_Airdrop(Event event, const char[] name, bool dontBroadcast) {
     UnhookEvent("player_spawn", Event_PlayerSpawn_Post, EventHookMode_Post);
}

public void Event_PlayerSpawn_Post(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     if(IsClientInGame(client) && client > 1 && client <= MaxClients) {
          return;
     }

     CreateTimer(0.0, Timer_TeleportToSpectated, client);
}

public Action Timer_TeleportToSpectated(Handle timer, any client) {
     if(IsClientInGame(client) && client > 1 && client <= MaxClients || !IsPlayerAlive(client)) {
          return Plugin_Handled;
     }

     int target = GetEntPropEnt(client, Prop_Send, "m_hObserverTarget");

     if(target <= 0 || target > MaxClients || !IsPlayerAlive(target)) {
          return Plugin_Handled;
     }

     float pos[3], ang[3];
     GetClientAbsOrigin(target, pos);
     GetClientAbsAngles(target, ang);

     TeleportEntity(client, pos, ang, NULL_VECTOR);

     return Plugin_Handled;
}