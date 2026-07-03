#pragma semicolon 1

#define E49_UPDATE_INTERVAL 0.06
#define E49_PLAYERS_PER_UPDATE 8
#define E49_MAX_LOOK_DISTANCE 3000.0

public void Event_RoundStart_49_DeathStare(Event event, const char[] name, bool dontBroadcast) {    
     for(int i = 0; i <= MAXPLAYERS; i++) {
          for(int j = 0; j <= MAXPLAYERS; j++) {
               g_Effect49_bIsLookingAt[i][j] = false;
          }
     }

     g_Effect49_Timer = CreateTimer(E49_UPDATE_INTERVAL, E49_UpdateLookMatrix, _, TIMER_REPEAT);
}

public void Event_RoundEnd_49_DeathStare(Event event, const char[] name, bool dontBroadcast) {
     if(g_Effect49_Timer != null) {
          KillTimer(g_Effect49_Timer);
          g_Effect49_Timer = null;
     }
}

public Action E49_UpdateLookMatrix(Handle timer) {
     E49_UpdateLookMatrixChunk();
     E49_CheckForMutualStares();
     return Plugin_Continue;
}

void E49_CheckForMutualStares() {
     bool[] explodedThisCycle = new bool[MAXPLAYERS+1];

     for(int i = 1; i <= MaxClients; i++) {
          if(explodedThisCycle[i] || !IsClientInGame(i) || !IsPlayerAlive(i)) {
               continue;
          }
          
          for(int j = i + 1; j <= MaxClients; j++) {
               if(explodedThisCycle[j] || !IsClientInGame(j) || !IsPlayerAlive(j) || !IsOpposingTeam(i, j)) {
                    continue;
               }
               
               // CHECK FOR MUTUAL STARE
               if(g_Effect49_bIsLookingAt[i][j] && g_Effect49_bIsLookingAt[j][i]) {
                    explodedThisCycle[i] = true;
                    explodedThisCycle[j] = true;
                    
                    ExplodePlayer(i);
                    ExplodePlayer(j);
                    PrintToChatAll("\x07B143F1[Roundabout]\x01 %N and %N had a staredown.", i, j);
                    
                    // PAIR FOUND
                    break;
               }
          }
     }
}

public void E49_UpdateLookMatrixChunk() {
     int playersProcessed;
     
     for(int i = 1; i <= MaxClients && playersProcessed < E49_PLAYERS_PER_UPDATE; i++) {
          int client = (g_Effect49_iCurrentPlayerIndex + i - 1) % MaxClients + 1;
          
          if(IsClientInGame(client) && IsPlayerAlive(client)) {
               // CLEAR PREVIOUS LOOK TARGET
               for(int target = 1; target <= MaxClients; target++) {
                    g_Effect49_bIsLookingAt[client][target] = false;
               }
               
               // FIND NEW LOOK TARGET
               int target = E49_GetClientAimTargetPlayer(client, E49_MAX_LOOK_DISTANCE);
               if(1 <= target <= MaxClients && IsPlayerAlive(target)) {
                    g_Effect49_bIsLookingAt[client][target] = true;
               }
               
               playersProcessed++;
          }
     }
     
     // UPDATE ROTATION INDEX
     g_Effect49_iCurrentPlayerIndex = (g_Effect49_iCurrentPlayerIndex + E49_PLAYERS_PER_UPDATE) % MaxClients;
}

public bool E49_TraceFilter_Players(int entity, int mask, any data) {
     // SKIP THE TRACING PLAYER AND EVERYONE ELSE
     if(entity == data) {
          return false; // SKIP SELF
     }
     return true; // HIT EVERYTHING ELSE
}

public int E49_GetClientAimTargetPlayer(int client, float maxDistance) {
     float eyePos[3], eyeAng[3], endPos[3];
     GetClientEyePosition(client, eyePos);
     GetClientEyeAngles(client, eyeAng);
     
     // CALCULATE RAY ENDPOINT
     float dir[3];
     GetAngleVectors(eyeAng, dir, NULL_VECTOR, NULL_VECTOR);
     ScaleVector(dir, maxDistance);
     AddVectors(eyePos, dir, endPos);
     
     // PERFORM FINITE RAY TRACE
     TR_TraceRayFilter(eyePos, endPos, MASK_SOLID, RayType_EndPoint, E49_TraceFilter_Players, client);
     
     if(TR_DidHit()) {
          int entity = TR_GetEntityIndex();
          if(1 <= entity <= MaxClients && IsClientInGame(entity) && IsPlayerAlive(entity)) {
               return entity;
          }
     }
     return -1;
}