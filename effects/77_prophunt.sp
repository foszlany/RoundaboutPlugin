#pragma semicolon 1

#define E77_COOLDOWN 15.0
#define UPDATE_INTERVAL 0.02

public void Event_RoundStart_77_Prophunt(Event event, const char[] name, bool dontBroadcast) {
     if(g_Effect77_UpdateTimer == null) {
          g_Effect77_UpdateTimer = CreateTimer(UPDATE_INTERVAL, E77_UpdatePropsTimer, _, TIMER_REPEAT);
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               E77_ResetPlayerState(i);
          }
     }
}

public void Event_RoundEnd_77_Prophunt(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && g_Effect77_IsProp[i]) {
               E77_RemoveProp(i);
          }
     }

     if(g_Effect77_UpdateTimer != null) {
          KillTimer(g_Effect77_UpdateTimer);
          g_Effect77_UpdateTimer = null;
     }
}

public void Event_PlayerHit_77_Prophunt(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     E77_OnPlayerHurtOrShoot(client);
}

public void Event_PlayerDeath_77_Prophunt(Event event, const char[] name, bool dontBroadcast) {
     int victim = GetClientOfUserId(event.GetInt("userid"));
     if(g_Effect77_IsProp[victim]) {
          E77_RemoveProp(victim);
     }
}

public bool E77_CanBecomeProp(int client) {
     return !(g_Effect77_PropCooldown[client] && GetEngineTime() < g_Effect77_NextPropTime[client]);
}

public void E77_StartCooldown(int client) {
     g_Effect77_PropCooldown[client] = true;
     g_Effect77_NextPropTime[client] = GetEngineTime() + E77_COOLDOWN;
}

public void E77_ClearCooldown(int client) {
     g_Effect77_PropCooldown[client] = false;
     g_Effect77_NextPropTime[client] = 0.0;
}

public void E77_ApplyProp(int client) {
     if(!IsClientInGame(client) || !IsPlayerAlive(client)) {
          return;
     }

     if(g_Effect77_PropEntity[client] != -1 && IsValidEntity(g_Effect77_PropEntity[client])) {
          RemoveEntity(g_Effect77_PropEntity[client]);
          g_Effect77_PropEntity[client] = -1;
     }

     int idx = GetRandomInt(0, sizeof(g_PropModels) - 1);
     char mdl[64];
     strcopy(mdl, sizeof(mdl), g_PropModels[idx]);

     int prop = CreateEntityByName("prop_dynamic_override");

     DispatchKeyValue(prop, "model", mdl);
     DispatchKeyValue(prop, "solid", "0");
     DispatchKeyValue(prop, "targetname", "E77_prop");
     DispatchKeyValue(prop, "disableshadows", "1");
     DispatchKeyValue(prop, "rendermode", "0");
     DispatchKeyValue(prop, "renderamt", "255");

     DispatchSpawn(prop);
     ActivateEntity(prop);

     float pos[3], ang[3];
     GetClientAbsOrigin(client, pos);
     pos[2] += 20.0;
     GetClientAbsAngles(client, ang);
     ang[0] = 0.0;
     ang[2] = 0.0;
     TeleportEntity(prop, pos, ang, NULL_VECTOR);

     SetEntProp(prop, Prop_Send, "m_CollisionGroup", 1);
     SetEntProp(prop, Prop_Send, "m_usSolidFlags", 0x0004);
     SetEntProp(prop, Prop_Data, "m_nSolidType", 0);

     g_Effect77_PropEntity[client] = prop;
     g_Effect77_IsProp[client] = true;

     ApplyInvisibility(client, true);

     SetVariantInt(1);
     AcceptEntityInput(client, "SetForcedTauntCam");
}

public void E77_RemoveProp(int client) {
     if(!IsClientInGame(client) || !g_Effect77_IsProp[client]) {
          return;
     }

     if(g_Effect77_PropEntity[client] != -1 && IsValidEntity(g_Effect77_PropEntity[client])) {
          RemoveEntity(g_Effect77_PropEntity[client]);
          g_Effect77_PropEntity[client] = -1;
     }

     ApplyInvisibility(client, false);
     g_Effect77_IsProp[client] = false;
     g_Effect77_PropCooldown[client] = true;
     g_Effect77_NextPropTime[client] = GetEngineTime() + 15.0;

     SetVariantInt(0);
     AcceptEntityInput(client, "SetForcedTauntCam");
}

public void E77_ResetPlayerState(int client) {
     g_Effect77_IsProp[client] = false;
     g_Effect77_PropEntity[client] = -1;
     E77_ClearCooldown(client);
     ApplyInvisibility(client, false);
}

public void E77_OnPlayerHurtOrShoot(int client) {
     if(g_Effect77_IsProp[client]) {
          E77_RemoveProp(client);
     }
}

public Action OnPlayerRunCmd(int client, int &buttons, int &impulse, float vel[3], float angles[3], int &weapon) {
     if(!IsEffectLive(EFFECT_PROPHUNT) || !IsClientInGame(client) || !IsPlayerAlive(client)) {
          return Plugin_Continue;
     }

     bool isShooting = (buttons & (IN_ATTACK | IN_ATTACK2 | IN_ATTACK3)) != 0;
     bool isReloading = (buttons & IN_RELOAD) != 0;

     if(isShooting && g_Effect77_IsProp[client]) {
          E77_RemoveProp(client);
          return Plugin_Continue;
     }

     if(isReloading && !g_Effect77_ReloadHeld[client]) {
          g_Effect77_ReloadHeld[client] = true;
          if(g_Effect77_ReloadTimer[client] != null) {
               CloseHandle(g_Effect77_ReloadTimer[client]);
          }
          g_Effect77_ReloadTimer[client] = CreateTimer(0.5, E77_Timer_CheckReloadHold, client);
     }
     else if(!isReloading && g_Effect77_ReloadHeld[client]) {
          g_Effect77_ReloadHeld[client] = false;
          if(g_Effect77_ReloadTimer[client] != null) {
               CloseHandle(g_Effect77_ReloadTimer[client]);
               g_Effect77_ReloadTimer[client] = null;
          }
     }

     return Plugin_Continue;
}

public Action E77_UpdatePropsTimer(Handle timer) {
     for(int client = 1; client <= MaxClients; client++) {
          if(!g_Effect77_IsProp[client]) {
               continue;
          }

          if(!IsClientInGame(client) || !IsPlayerAlive(client)) {
               if(g_Effect77_PropEntity[client] != -1 && IsValidEntity(g_Effect77_PropEntity[client])) {
                    RemoveEntity(g_Effect77_PropEntity[client]);
               }

               g_Effect77_PropEntity[client] = -1;
               g_Effect77_IsProp[client] = false;

               continue;
          }
          
          int prop = g_Effect77_PropEntity[client];
          if(prop == -1 || !IsValidEntity(prop)) {
               continue;
          }
          
          float pos[3], ang[3];
          GetClientAbsOrigin(client, pos);
          GetClientAbsAngles(client, ang);
          pos[2] += 20.0;
          ang[0] = 0.0;
          ang[2] = 0.0;
          
          TeleportEntity(prop, pos, ang, NULL_VECTOR);
     }

     return Plugin_Continue;
}

public Action E77_Timer_CheckReloadHold(Handle timer, any client) {
     g_Effect77_ReloadTimer[client] = null;
     if(!IsClientInGame(client) || !IsPlayerAlive(client)) {
          return Plugin_Stop;
     }

     int buttons = GetClientButtons(client);
     if(buttons & IN_RELOAD) {
          E77_OnReloadHeld(client);
     }

     return Plugin_Stop;
}

public void E77_OnReloadHeld(int client) {
     if(!IsClientInGame(client) || !IsPlayerAlive(client)) return;

     if(g_Effect77_IsProp[client]) {
          E77_RemoveProp(client);
          return;
     }

     if(E77_CanBecomeProp(client)) {
          E77_ApplyProp(client);
     }
}