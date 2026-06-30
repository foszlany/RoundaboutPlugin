#pragma semicolon 1

#define E74_COOLDOWN 24.0
#define E74_RARECOOLDOWN 8.0

public void Event_RoundStart_74_PumpkinBomb(Event event, const char[] name, bool dontBroadcast) {
     if(IsRareEffectForced(EFFECT_PUMPKIN) || GetRandomInt(0, 100) <= 3) {
          g_Effect74_IsSpecialRound = true;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Massively reduced cooldown.");
     }
     else {
          g_Effect74_IsSpecialRound = false;
     }

     AddCommandListener(E74_OnPumpkinSpawnAttempt, "voicemenu");

     for(int i = 1; i <= MaxClients; i++) {
          g_Effect74_PumpkinTimers[i] = null;
     }
}

public void Event_RoundEnd_74_PumpkinBomb(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          E74_NullifyClientPumpkinData(i);
     }
}

public Action E74_OnPumpkinSpawnAttempt(client, const String:command[], argc) {
     char arguments[4];
     GetCmdArgString(arguments, sizeof(arguments));

     if(StrEqual(arguments, "0 0") && IsEffectLive(EFFECT_PUMPKIN) && g_Effect74_PumpkinTimers[client] == null && IsClientInGame(client) && IsPlayerAlive(client)) {
          E74_SpawnPumpkinBomb(client);

          g_Effect74_PumpkinTimers[client] = CreateTimer(g_Effect74_IsSpecialRound ? E74_RARECOOLDOWN : E74_COOLDOWN, E74_ResetCooldown, client);
          return Plugin_Handled;
     }

     return Plugin_Continue;
}

public Action E74_SpawnPumpkinBomb(int client) {
     float eyePos[3];
     float eyeAng[3];
     float forwardVec[3];
     float endPos[3];

     GetClientEyePosition(client, eyePos);
     GetClientEyeAngles(client, eyeAng);

     GetAngleVectors(eyeAng, forwardVec, NULL_VECTOR, NULL_VECTOR);

     endPos[0] = eyePos[0] + forwardVec[0] * 1000.0;
     endPos[1] = eyePos[1] + forwardVec[1] * 1000.0;
     endPos[2] = eyePos[2] + forwardVec[2] * 1000.0;

     TR_TraceRayFilter(eyePos, endPos, MASK_SOLID, RayType_EndPoint, E74_TraceEntityFilterPlayers);

     float hitPos[3];
     TR_GetEndPosition(hitPos);

     int bomb = CreateEntityByName("tf_pumpkin_bomb");
     if(bomb != -1) {
          DispatchSpawn(bomb);
          TeleportEntity(bomb, hitPos, NULL_VECTOR, NULL_VECTOR);
     }

     return Plugin_Handled;
}

public bool E74_TraceEntityFilterPlayers(int entity, int contentsMask) {
    return (entity > MaxClients);
}


public Action E74_ResetCooldown(Handle timer, int client) {
     g_Effect74_PumpkinTimers[client] = null;
     return Plugin_Handled;
}

public void E74_NullifyClientPumpkinData(int client) {
     if(g_Effect74_PumpkinTimers[client] != null) {
          KillTimer(g_Effect74_PumpkinTimers[client]);
          g_Effect74_PumpkinTimers[client] = null;
     }
}