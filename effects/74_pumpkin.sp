#pragma semicolon 1

public void Event_RoundStart_74_PumpkinBomb(Event event, const char[] name, bool dontBroadcast) {
     AddCommandListener(OnPumpkinSpawnAttempt, "voicemenu");

     for(int i = 1; i <= MaxClients; i++) {
          g_Effect74_PumpkinTimers[i] = null;
     }
}

public void Event_RoundEnd_74_PumpkinBomb(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          NullifyClientPumpkinData(i);
     }
}

public Action OnPumpkinSpawnAttempt(client, const String:command[], argc) {
     char arguments[4];
     GetCmdArgString(arguments, sizeof(arguments));

     if(StrEqual(arguments, "0 0") && IsEffectLive(EFFECT_PUMPKIN) && g_Effect74_PumpkinTimers[client] == null && IsClientInGame(client) && IsPlayerAlive(client)) {
          SpawnPumpkinBomb(client);

          g_Effect74_PumpkinTimers[client] = CreateTimer(24.0, E74_ResetCooldown, client);
          return Plugin_Handled;
     }

     return Plugin_Continue;
}

public Action SpawnPumpkinBomb(int client) {
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

     TR_TraceRayFilter(eyePos, endPos, MASK_SOLID, RayType_EndPoint, TraceEntityFilterPlayers);

     float hitPos[3];
     TR_GetEndPosition(hitPos);

     int bomb = CreateEntityByName("tf_pumpkin_bomb");
     if(bomb != -1) {
          DispatchSpawn(bomb);
          TeleportEntity(bomb, hitPos, NULL_VECTOR, NULL_VECTOR);
     }

     return Plugin_Handled;
}

public bool TraceEntityFilterPlayers(int entity, int contentsMask) {
    return (entity > MaxClients);
}


public Action E74_ResetCooldown(Handle timer, int client) {
     g_Effect74_PumpkinTimers[client] = null;
     return Plugin_Handled;
}

public void NullifyClientPumpkinData(int client) {
     if(g_Effect74_PumpkinTimers[client] != null) {
          KillTimer(g_Effect74_PumpkinTimers[client]);
          g_Effect74_PumpkinTimers[client] = null;
     }
}