#pragma semicolon 1

#define E61_BASEPARRYCOOLDOWN 1.5
#define E61_SUCCESSFULPARRYCOOLDOWN 0.5
#define E61_PARRYWINDOW 0.25

forward Action Effect61_OnHitCheckParry(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom);

public void Event_RoundStart_61_ParryIt(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MAXPLAYERS; i++) {
          g_Effect61_IsParrying[i] = false;
          g_Effect61_HasRecentlyParried[i] = false;
          g_Effect61_DidSuccessfullyParry[i] = false;
          g_Effect61_fCooldownEndTime[i] = 0.0;

          if(i <= MaxClients && IsClientInGame(i)) {
               SDKHook(i, SDKHook_OnTakeDamage, Effect61_OnHitCheckParry);
          }
     }   

     if(g_Effect61_hHUDTimer == null) {
          g_Effect61_hHUDTimer = CreateTimer(0.1, Timer_UpdateParryHUD, _, TIMER_REPEAT);
     }

     AddCommandListener(Parry, "voicemenu");

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_61_ParryIt(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     
     if(!SDKHookEx(client, SDKHook_OnTakeDamage, Effect61_OnHitCheckParry)) {
          SDKHook(client, SDKHook_OnTakeDamage, Effect61_OnHitCheckParry);
     }
}

public void Event_RoundEnd_61_ParryIt(Event event, const char[] name, bool dontBroadcast) {    
     RemoveCommandListener(Parry, "voicemenu");

     for(int i = 1; i <= MAXPLAYERS; i++) {
          SDKUnhook(i, SDKHook_OnTakeDamage, Effect61_OnHitCheckParry);
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

public Action Timer_UpdateParryHUD(Handle timer) {
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

public Action Effect61_OnHitCheckParry(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom) {    
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

     g_Effect61_fCooldownEndTime[victim] = GetGameTime() + E61_SUCCESSFULPARRYCOOLDOWN;
     CreateTimer(E61_SUCCESSFULPARRYCOOLDOWN, ResetParryCooldown, victim);

     return Plugin_Handled;
}

public Action Parry(client, const String:command[], argc) {    
     char arguments[4];
     GetCmdArgString(arguments, sizeof(arguments));
     
     if(StrEqual(arguments, "0 0")) {
          if(g_Effect61_HasRecentlyParried[client] || !IsPlayerAlive(client)) {
               return Plugin_Handled;
          }

          g_Effect61_HasRecentlyParried[client] = true;
          g_Effect61_IsParrying[client] = true;

          CreateTimer(E61_PARRYWINDOW, OnEndParryWindow, client);
     }
     
     return Plugin_Handled;
}

public Action OnEndParryWindow(Handle timer, int client) {
     if(!g_Effect61_IsParrying[client]) {
          return Plugin_Handled;
     }

     g_Effect61_IsParrying[client] = false;
     g_Effect61_DidSuccessfullyParry[client] = false;

     TF2Attrib_SetByName(client, "dmg taken increased", 1.25);
     
     g_Effect61_fCooldownEndTime[client] = GetGameTime() + E61_BASEPARRYCOOLDOWN;

     CreateTimer(E61_BASEPARRYCOOLDOWN, ResetParryCooldown, client);

     return Plugin_Handled;
}

public Action ResetParryCooldown(Handle timer, int client) {
     g_Effect61_HasRecentlyParried[client] = false;
     g_Effect61_fCooldownEndTime[client] = 0.0;

     TF2Attrib_RemoveByName(client, "dmg taken increased");

     EmitSoundToClient(client, "player/recharged.wav");

     return Plugin_Handled;
}