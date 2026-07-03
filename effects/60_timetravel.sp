#pragma semicolon 1

public void Event_RoundStart_60_TimeTravel(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          E60_ResetTimeTravelEffects(i);
     }

     CreateTimer(GetRandomFloat(8.0, 32.0), E60_CreateSnapshot);
}

public Action E60_CreateSnapshot(Handle timer) {
     if(IsEffectLive(EFFECT_TIMETRAVEL)) {
          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i) && IsPlayerAlive(i)) {
                    g_Effect60_PlayerHealth[i] = GetClientHealth(i);

                    GetClientAbsOrigin(i, g_Effect60_PlayerPosition[i]);
                    GetClientEyeAngles(i, g_Effect60_PlayerAngle[i]);

                    GetEntPropVector(i, Prop_Data, "m_vecVelocity", g_Effect60_PlayerVelocity[i]);

                    int weapon = GetEntPropEnt(i, Prop_Send, "m_hActiveWeapon");
                    g_Effect60_PlayerSlot[i] = (IsValidEntity(weapon) ? EntIndexToEntRef(weapon) : INVALID_ENT_REFERENCE);

                    for(int slot = 0; slot < 3; slot++) {
                         int slotWeapon = GetPlayerWeaponSlot(i, slot);
                         if(IsValidEntity(slotWeapon)) {
                              g_Effect60_PlayerClip[i][slot] = GetEntProp(slotWeapon, Prop_Send, "m_iClip1");
                         }
                    }

                    g_Effect60_PlayerClass[i] = TF2_GetPlayerClass(i);
               }
               else {
                    E60_ResetTimeTravelEffects(i);
               }
          }
          
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Snapshot created...");
          CreateTimer(GetRandomFloat(1.0, 24.0), E60_ActivateSnapshot);
     }

     return Plugin_Handled;
}

public Action E60_ActivateSnapshot(Handle timer) {
     if(IsEffectLive(EFFECT_TIMETRAVEL)) {
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

                         TeleportEntity(i, g_Effect60_PlayerPosition[i], g_Effect60_PlayerAngle[i], g_Effect60_PlayerVelocity[i]);

                         if(g_Effect60_PlayerSlot[i] != INVALID_ENT_REFERENCE) {
                              int weapon = EntRefToEntIndex(g_Effect60_PlayerSlot[i]);
                              if(IsValidEntity(weapon)) {
                                   SetEntPropEnt(i, Prop_Send, "m_hActiveWeapon", weapon);
                              }
                         }

                         for(int slot = 0; slot < 3; slot++) {
                              int weapon = GetPlayerWeaponSlot(i, slot);
                              if(IsValidEntity(weapon)) {
                                   SetEntProp(weapon, Prop_Send, "m_iClip1", g_Effect60_PlayerClip[i][slot]);
                              }
                         }

                         if(g_Effect60_PlayerClass[i] != TF2_GetPlayerClass(i)) {
                              TF2_SetPlayerClass(i, g_Effect60_PlayerClass[i]);
                              TF2_RegeneratePlayer(i);
                         }

                         SetEntityHealth(i, g_Effect60_PlayerHealth[i]);
                    }
               }
          }
                    
          EmitSoundToAll("misc/halloween/spell_teleport.wav");
          
          CreateTimer(GetRandomFloat(8.0, 32.0), E60_CreateSnapshot);
     }

     return Plugin_Handled;
}

public void E60_ResetTimeTravelEffects(int client) {
     g_Effect60_PlayerHealth[client] = -1;

     g_Effect60_PlayerPosition[client][0] = -1.0;
     g_Effect60_PlayerPosition[client][1] = -1.0;
     g_Effect60_PlayerPosition[client][2] = -1.0;

     g_Effect60_PlayerAngle[client][0] = -1.0;
     g_Effect60_PlayerAngle[client][1] = -1.0;
     g_Effect60_PlayerAngle[client][2] = -1.0;

     g_Effect60_PlayerClass[client] = TFClass_Unknown;
}