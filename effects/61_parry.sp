#pragma semicolon 1

#define E61_PARRY_WINDOW 0.25
#define E61_BASE_PARRY_COOLDOWN 1.5
#define E61_SUCCESSFUL_PARRY_COOLDOWN 0.5
#define E61_FAILED_PARRY_VULNERABILITY_MULTIPLIER 1.25

forward Action E61_OnHitCheckParry(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom);

public void Event_RoundStart_61_ParryIt(Event event, const char[] name, bool dontBroadcast) {
     if(IsRareEffectForced(EFFECT_PARRY) || GetRandomInt(0, 100) <= 2) {
          g_Effect61_IsRareVariant = true;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Failed parries instakill you.");
     }
     else {
          g_Effect61_IsRareVariant = false;
     }

     AddCommandListener(E61_Parry, "voicemenu");
     g_Effect61_IsCommandListenerRegistered = true;
     
     for(int i = 1; i <= MAXPLAYERS; i++) {
          g_Effect61_IsParrying[i] = false;
          g_Effect61_HasRecentlyParried[i] = false;
          g_Effect61_DidSuccessfullyParry[i] = false;
          g_Effect61_fCooldownEndTime[i] = 0.0;

          if(i <= MaxClients && IsClientInGame(i)) {
               SDKHook(i, SDKHook_OnTakeDamage, E61_OnHitCheckParry);
          }
     }   

     if(g_Effect61_hHUDTimer == null) {
          g_Effect61_hHUDTimer = CreateTimer(0.1, E61_UpdateParryHUD, _, TIMER_REPEAT);
     }
}

public void Event_PlayerUpdate_61_ParryIt(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     
     if(!SDKHookEx(client, SDKHook_OnTakeDamage, E61_OnHitCheckParry)) {
          SDKHook(client, SDKHook_OnTakeDamage, E61_OnHitCheckParry);
     }
}

public void Event_RoundEnd_61_ParryIt(Event event, const char[] name, bool dontBroadcast) {
     if(g_Effect61_IsCommandListenerRegistered) {
          RemoveCommandListener(E61_Parry, "voicemenu");
          g_Effect61_IsCommandListenerRegistered = false;

          for(int i = 1; i <= MAXPLAYERS; i++) {
               SDKUnhook(i, SDKHook_OnTakeDamage, E61_OnHitCheckParry);
               g_Effect61_fCooldownEndTime[i] = 0.0;
          }
          
          for(int client = 1; client <= MaxClients; client++) {
               if(IsClientInGame(client)) {
                    ShowHudText(client, 6, "");
               }
          }
          
          if(g_Effect61_hHUDTimer != null) {
               KillTimer(g_Effect61_hHUDTimer);
               g_Effect61_hHUDTimer = null;
          }
     }
}

public Action E61_UpdateParryHUD(Handle timer) {
     for(int client = 1; client <= MaxClients; client++) {
          if(IsClientInGame(client) && !IsFakeClient(client)) {
               char hudText[32];
               hudText[0] = '\0';

               SetHudTextParams(-1.0, 0.74, 0.11, 255, 0, 0, 255); // RED
               
               if(g_Effect61_IsParrying[client]) {
                    SetHudTextParams(-1.0, 0.74, 0.11, 0, 34, 255, 255); // BLUE
                    Format(hudText, sizeof(hudText), "PARRYING");
               }
               else if(g_Effect61_HasRecentlyParried[client]) {
                    if(g_Effect61_DidSuccessfullyParry[client]) {
                         SetHudTextParams(-1.0, 0.74, 0.11, 0, 255, 0, 255); // GREEN
                    } 

                    float timeLeft = g_Effect61_fCooldownEndTime[client] - GetGameTime();
                    if(timeLeft > 0.0) {
                         Format(hudText, sizeof(hudText), "Cooldown: %.1fs", timeLeft);
                    }
               }
               
               ShowHudText(client, 6, hudText);
          }
     }
     return Plugin_Continue;
}

public Action E61_OnHitCheckParry(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom) {    
     if(victim == attacker || attacker < 1 || attacker > MaxClients || !IsClientInGame(attacker) || !IsPlayerAlive(victim) || !g_Effect61_IsParrying[victim]) {
          return Plugin_Continue;
     }

     g_Effect61_IsParrying[victim] = false;
     g_Effect61_DidSuccessfullyParry[victim] = true;

     SetHudTextParams(-1.0, 0.52, 0.11, 255, 215, 0, 255); // GOLD
     ShowHudText(victim, -1, "PARRIED!");
     
     float origin[3];
     GetClientAbsOrigin(victim, origin);

     EmitAmbientSound("ui/vote_yes.wav", origin);
     EmitAmbientSound("ui/vote_yes.wav", origin);

     g_Effect61_fCooldownEndTime[victim] = GetGameTime() + E61_SUCCESSFUL_PARRY_COOLDOWN;
     CreateTimer(E61_SUCCESSFUL_PARRY_COOLDOWN, E61_ResetParryCooldown, victim);

     return Plugin_Handled;
}

public Action E61_Parry(client, const String:command[], argc) {    
     char arguments[4];
     GetCmdArgString(arguments, sizeof(arguments));
     
     if(StrEqual(arguments, "0 0")) {
          if(g_Effect61_HasRecentlyParried[client] || !IsPlayerAlive(client)) {
               return Plugin_Handled;
          }

          g_Effect61_HasRecentlyParried[client] = true;
          g_Effect61_IsParrying[client] = true;

          CreateTimer(E61_PARRY_WINDOW, E61_OnEndParryWindow, client);
          return Plugin_Handled;
     }
     
     return Plugin_Continue;
}

public Action E61_OnEndParryWindow(Handle timer, int client) {
     if(!g_Effect61_IsParrying[client]) {
          return Plugin_Handled;
     }

     g_Effect61_IsParrying[client] = false;
     g_Effect61_DidSuccessfullyParry[client] = false;

     if(g_Effect61_IsRareVariant == true) {
          SDKHooks_TakeDamage(client, client, client, 99999.0, DMG_GENERIC, -1);

          PrintToChat(client, "\x07B143F1[Roundabout]\x01 You failed to parry anything.");
     }

     TF2Attrib_SetByName(client, "dmg taken increased", E61_FAILED_PARRY_VULNERABILITY_MULTIPLIER);
     
     g_Effect61_fCooldownEndTime[client] = GetGameTime() + E61_BASE_PARRY_COOLDOWN;

     CreateTimer(E61_BASE_PARRY_COOLDOWN, E61_ResetParryCooldown, client);

     return Plugin_Handled;
}

public Action E61_ResetParryCooldown(Handle timer, int client) {
     g_Effect61_HasRecentlyParried[client] = false;
     g_Effect61_fCooldownEndTime[client] = 0.0;

     TF2Attrib_RemoveByName(client, "dmg taken increased");

     EmitSoundToClient(client, "player/recharged.wav");

     return Plugin_Handled;
}