#pragma semicolon 1

#define E57_FAILED_COOLDOWN 6.0
#define E57_SUCCESSFUL_COOLDOWN 8.0

public void Event_RoundStart_57_MedicCall(Event event, const char[] name, bool dontBroadcast) {
     AddCommandListener(E57_CalledForMedic, "voicemenu");
     g_Effect57_isCommandListenerRegistered = true;
     
     for(int i = 1; i <= MAXPLAYERS; i++) {
          g_Effect57_HasBeenTeleportedRecently[i] = false;
          g_Effect57_HasRecentlyCalled[i] = false;
     }

     SignalCooldown(EFFECT_MEDICCALL, 255, 66, 66);
}

public void Event_RoundEnd_57_MedicCall(Event event, const char[] name, bool dontBroadcast) {    
     if(g_Effect57_isCommandListenerRegistered) {
          RemoveCommandListener(E57_CalledForMedic, "voicemenu");
          g_Effect57_isCommandListenerRegistered = false;
     }
}

public Action E57_CalledForMedic(client, const String:command[], argc) {    
     char arguments[4];
     GetCmdArgString(arguments, sizeof(arguments));
     
     if(StrEqual(arguments, "0 0")) {
          if(g_Effect57_HasRecentlyCalled[client]) {
               return Plugin_Handled;
          }

          g_Effect57_HasRecentlyCalled[client] = true;

          bool isMedicExisting = false;
          bool isMedicAlive = false;
          bool hasMedicNotBeenTeleportedRecently = false;

          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i) && !IsOpposingTeam(i, client) && TF2_GetPlayerClass(i) == TFClass_Medic) {
                    isMedicExisting = true;

                    if(IsPlayerAlive(i)) {
                         isMedicAlive = true;

                         if(!g_Effect57_HasBeenTeleportedRecently[i] && i != client) {
                              hasMedicNotBeenTeleportedRecently = true;

                              int medigun = GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary);
                              if(medigun != -1) {
                                   int target = GetEntDataEnt2(medigun, FindSendPropInfo("CWeaponMedigun", "m_hHealingTarget"));
                                   if(target < 1) {
                                        // FOUND CANDIDATE
                                        float origin[3];
                                        float angles[3];
                                        GetClientAbsOrigin(client, origin);
                                        GetClientEyeAngles(client, angles);
                                        TeleportEntity(i, origin, angles, NULL_VECTOR);

                                        g_Effect57_HasBeenTeleportedRecently[i] = true;
                                        CreateTimer(E57_SUCCESSFUL_COOLDOWN, E57_ResetMedicCooldown, i);
                                        AddCooldown(EFFECT_MEDICCALL, i, E57_SUCCESSFUL_COOLDOWN);

                                        PrintToChat(client, "\x07B143F1[Roundabout]\x01 \x079EFF99Medic successfully teleported!\x01");

                                        return Plugin_Continue;
                                   }
                                   else if(target == client) {
                                        PrintToChat(client, "\x07B143F1[Roundabout]\x01 \x07FF9999You already have a medic!\x01");
                                        return Plugin_Continue;
                                   }
                              }
                         }
                    } 
               }
          }

          CreateTimer(E57_FAILED_COOLDOWN, E57_ResetCallerCooldown, client);
          AddCooldown(EFFECT_MEDICCALL, client, E57_FAILED_COOLDOWN);

          if(!isMedicExisting) {
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 \x07FF9999There are no medics in your team. Try again later.\x01");
          }
          else if(!isMedicAlive) {
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 \x07FF9999There are no living medics in your team. Try again later.\x01");
          }
          else if(!hasMedicNotBeenTeleportedRecently) {
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 \x07FF9999There are no suitable medics in your team. Try again later.\x01");
          }
          else {
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 \x07FF9999There are no available medics in your team. Try again later.\x01");
          }

          return Plugin_Continue;
     }
     
     return Plugin_Continue;
}

public Action E57_ResetMedicCooldown(Handle timer, int client) {
     g_Effect57_HasBeenTeleportedRecently[client] = false;
     return Plugin_Handled;
}

public Action E57_ResetCallerCooldown(Handle timer, int client) {
     g_Effect57_HasRecentlyCalled[client] = false;
     EmitSoundToClient(client, "player/recharged.wav");

     return Plugin_Handled;
}