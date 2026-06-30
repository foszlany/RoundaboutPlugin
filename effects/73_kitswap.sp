#pragma semicolon 1

public void Event_RoundStart_73_KitSwap(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          StoreMaxAmmoCount(i);
     }

     HookAllPickups();
}

public void Event_RoundEnd_73_KitSwap(Event event, const char[] name, bool dontBroadcast) {
     UnhookAllPickups();
}

public void Event_PlayerUpdate_73_KitSwap(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     StoreMaxAmmoCount(client);
}

public void StoreMaxAmmoCount(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          for(int slot = 0; slot < 3; slot++) {
               g_Effect73_MaxAmmoCount[client][slot] = GetAmmo(client, slot);
          }
     }
}

public void OnEntityCreated(int entity, const char[] classname) {
     if(!IsEffectLive(EFFECT_KITSWAP)) {
          return;
     }

     if(StrEqual(classname, "item_healthkit_small", false)
     || StrEqual(classname, "item_healthkit_medium", false)
     || StrEqual(classname, "item_healthkit_full", false)
     || StrEqual(classname, "item_ammopack_small", false)
     || StrEqual(classname, "item_ammopack_medium", false)
     || StrEqual(classname, "item_ammopack_full", false)
     || StrEqual(classname, "tf_ammo_pack", false)) {
          SDKHook(entity, SDKHook_Touch, OnItemTouch);
     }
}

public Action OnItemTouch(int entity, int client) {
     if(client <= 0 || client > MaxClients || !IsClientInGame(client) || !IsPlayerAlive(client)) {
          return Plugin_Continue;
     }

     if(g_Effect73_PickupStatus[entity]) {
          return Plugin_Handled;
     }

     char classname[32];
     GetEntityClassname(entity, classname, sizeof(classname));

     if(StrEqual(classname, "item_healthkit_small", false)) {
          if(!IsAmmoObtainable(client)) {
               return Plugin_Handled;
          }

          SimulateAmmoPack(client, 0.2);
          HandlePickupRespawn(entity, false);
          return Plugin_Handled;
     }
     else if(StrEqual(classname, "item_healthkit_medium", false)) {
          if(!IsAmmoObtainable(client)) {
               return Plugin_Handled;
          }

          SimulateAmmoPack(client, 0.5);
          HandlePickupRespawn(entity, false);
          return Plugin_Handled;
     }
     else if(StrEqual(classname, "item_healthkit_full", false)) {
          if(!IsAmmoObtainable(client)) {
               return Plugin_Handled;
          }

          SimulateAmmoPack(client, 1.0);
          HandlePickupRespawn(entity, false);
          return Plugin_Handled;
     }
     else if(StrEqual(classname, "item_ammopack_small", false)) {
          if(!IsHealthObtainable(client)) {
               return Plugin_Handled;
          }

          SimulateHealthPack(client, 0.2);
          HandlePickupRespawn(entity, true);
          return Plugin_Handled;
     }
     else if(StrEqual(classname, "item_ammopack_medium", false)) {
          if(!IsHealthObtainable(client)) {
               return Plugin_Handled;
          }

          SimulateHealthPack(client, 0.5);
          HandlePickupRespawn(entity, true);
          return Plugin_Handled;
     }
     else if(StrEqual(classname, "tf_ammo_pack", false)) {
          if(!IsHealthObtainable(client)) {
               return Plugin_Handled;
          }
          
          SimulateHealthPack(client, 0.5);
          AcceptEntityInput(entity, "Kill");
          return Plugin_Handled;
     }
     else if(StrEqual(classname, "item_ammopack_full", false)) {
          if(!IsHealthObtainable(client)) {
               return Plugin_Handled;
          }

          SimulateHealthPack(client, 1.0);
          HandlePickupRespawn(entity, true);
          return Plugin_Handled;
     }

     return Plugin_Continue;
}

public bool IsHealthObtainable(int client) {
     int clientHealth = GetClientHealth(client);
     int clientMaxHealth = GetEntData(client, FindDataMapInfo(client, "m_iMaxHealth"), 4);

     return clientHealth != clientMaxHealth;
}

public bool IsAmmoObtainable(int client) {
     bool hasMissingAmmo = false;

     for(int slot = 0; slot < 3; slot++) {
          int maxAmmo = g_Effect73_MaxAmmoCount[client][slot];
          int currentAmmo = GetAmmo(client, slot);

          if(currentAmmo != maxAmmo) {
               hasMissingAmmo = true;
               break;
          }
     }
     
     return hasMissingAmmo;
}

public void HandlePickupRespawn(int entity, bool isAmmoPack) {
     g_Effect73_PickupStatus[entity] = true;

     AcceptEntityInput(entity, "Disable");

     float respawnTime;

     if(isAmmoPack) {
          respawnTime = 30.0;
     }
     else {
          respawnTime = 10.0;
     }

     CreateTimer(respawnTime, Timer_EnablePickup, entity);
}

public Action Timer_EnablePickup(Handle timer, any entity) {
     if(IsValidEntity(entity)) {
          g_Effect73_PickupStatus[entity] = false;
          AcceptEntityInput(entity, "Enable");
     }

     return Plugin_Handled;
}

public void HookAllPickups() {
     int entity = -1;

     while((entity = FindEntityByClassname(entity, "item_healthkit_small")) != -1) {
          SDKHook(entity, SDKHook_Touch, OnItemTouch);
     }
     while((entity = FindEntityByClassname(entity, "item_healthkit_medium")) != -1) {
          SDKHook(entity, SDKHook_Touch, OnItemTouch);
     }
     while((entity = FindEntityByClassname(entity, "item_healthkit_full")) != -1) {
          SDKHook(entity, SDKHook_Touch, OnItemTouch);
     }
     while((entity = FindEntityByClassname(entity, "item_ammopack_small")) != -1) {
          SDKHook(entity, SDKHook_Touch, OnItemTouch);
     }
     while((entity = FindEntityByClassname(entity, "item_ammopack_medium")) != -1) {
          SDKHook(entity, SDKHook_Touch, OnItemTouch);
     }
     while((entity = FindEntityByClassname(entity, "item_ammopack_full")) != -1) {
          SDKHook(entity, SDKHook_Touch, OnItemTouch);
     }
}

public void UnhookAllPickups() {
     int entity = -1;

     while((entity = FindEntityByClassname(entity, "item_healthkit_small")) != -1) {
          SDKUnhook(entity, SDKHook_Touch, OnItemTouch);
     }
     while((entity = FindEntityByClassname(entity, "item_healthkit_medium")) != -1) {
          SDKUnhook(entity, SDKHook_Touch, OnItemTouch);
     }
     while((entity = FindEntityByClassname(entity, "item_healthkit_full")) != -1) {
          SDKUnhook(entity, SDKHook_Touch, OnItemTouch);
     }
     while((entity = FindEntityByClassname(entity, "item_ammopack_small")) != -1) {
          SDKUnhook(entity, SDKHook_Touch, OnItemTouch);
     }
     while((entity = FindEntityByClassname(entity, "item_ammopack_medium")) != -1) {
          SDKUnhook(entity, SDKHook_Touch, OnItemTouch);
     }
     while((entity = FindEntityByClassname(entity, "item_ammopack_full")) != -1) {
          SDKUnhook(entity, SDKHook_Touch, OnItemTouch);
     }
}

public void SimulateHealthPack(int client, float multiplier) {
     int clientHealth = GetClientHealth(client);
     int clientMaxHealth = GetEntData(client, FindDataMapInfo(client, "m_iMaxHealth"), 4);

     float totalNewHealth = clientHealth + clientMaxHealth * multiplier;
     float newHealth = totalNewHealth >= clientMaxHealth ? float(clientMaxHealth) : totalNewHealth;

     SetEntityHealth(client, RoundToNearest(newHealth));
     EmitSoundToClient(client, "items/smallmedkit1.wav");
}

public void SimulateAmmoPack(int client, float multiplier) {
     for(int slot = 0; slot < 3; slot++) {
          int weapon = GetPlayerWeaponSlot(client, slot);
          if(!IsValidEntity(weapon)) {
               continue;
          }

          int ammoType = GetEntProp(weapon, Prop_Send, "m_iPrimaryAmmoType");
          if(ammoType < 0) {
               continue;
          }

          int maxAmmo = g_Effect73_MaxAmmoCount[client][slot];
          float totalNewAmmo = float(maxAmmo) * multiplier;

          GivePlayerAmmo(client, RoundToNearest(totalNewAmmo), ammoType);
     }
}

public int GetAmmo(int client, int slot) {
     int weapon = GetPlayerWeaponSlot(client, slot);
     if(!IsValidEntity(weapon)) {
          return 0;
     }

     int ammoType = GetEntProp(weapon, Prop_Send, "m_iPrimaryAmmoType");
     if(ammoType < 0) {
          return 0;
     }

     int ammoOffset = FindSendPropInfo("CTFPlayer", "m_iAmmo") + (ammoType * 4);
     return GetEntData(client, ammoOffset);
}
