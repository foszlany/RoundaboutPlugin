#pragma semicolon 1

public void Event_RoundStart_60_TimeTravel(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          ResetTimeTravelEffects(i);
     }

     CreateTimer(GetRandomFloat(8.0, 32.0), CreateSnapshot);

     ShowCurrentEffectDescriptionToAll(-1);
}

public Action CreateSnapshot(Handle timer) {
     if(g_CurrentEffect == EFFECT_TIMETRAVEL) {
          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i) && IsPlayerAlive(i)) {
                    g_Effect60_PlayerHealth[i] = GetClientHealth(i);

                    GetClientAbsOrigin(i, g_Effect60_PlayerPosition[i]);
                    GetClientEyeAngles(i, g_Effect60_PlayerAngle[i]);

                    g_Effect60_PlayerClass[i] = TF2_GetPlayerClass(i);
               }
               else {
                    ResetTimeTravelEffects(i);
               }
          }
          
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Snapshot created...");
          CreateTimer(GetRandomFloat(1.0, 24.0), ActivateSnapshot);
     }

     return Plugin_Handled;
}

public Action ActivateSnapshot(Handle timer) {
     if(g_CurrentEffect == EFFECT_TIMETRAVEL) {
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Snapshot activated.");

          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i)) {
                    if(g_Effect60_PlayerHealth[i] == -1) {
                         ForcePlayerSuicide(i);
                         PrintToChat(i, "\x07B143F1[Roundabout]\x01 \x07FF9999You weren't alive when the snapshot was taken!\x01");
                    }
                    else {
                         if(!IsPlayerAlive(i)) {
                              TF2_RespawnPlayer(i);
                         }

                         TeleportEntity(i, g_Effect60_PlayerPosition[i], g_Effect60_PlayerAngle[i], NULL_VECTOR);

                         if(g_Effect60_PlayerClass[i] != TF2_GetPlayerClass(i)) {
                              TF2_SetPlayerClass(i, g_Effect60_PlayerClass[i]);
                              TF2_RegeneratePlayer(i);
                         }

                         SetEntityHealth(i, g_Effect60_PlayerHealth[i]);
                    }
               }
          }
                    
          EmitSoundToAll("misc/halloween/spell_teleport.wav");
          
          CreateTimer(GetRandomFloat(8.0, 32.0), CreateSnapshot);
     }

     return Plugin_Handled;
}

public void ResetTimeTravelEffects(int client) {
     g_Effect60_PlayerHealth[client] = -1;

     g_Effect60_PlayerPosition[client][0] = -1.0;
     g_Effect60_PlayerPosition[client][1] = -1.0;
     g_Effect60_PlayerPosition[client][2] = -1.0;

     g_Effect60_PlayerAngle[client][0] = -1.0;
     g_Effect60_PlayerAngle[client][1] = -1.0;
     g_Effect60_PlayerAngle[client][2] = -1.0;

     g_Effect60_PlayerClass[client] = TFClass_Unknown;
}