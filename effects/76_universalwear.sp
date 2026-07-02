#pragma semicolon 1

public void Event_RoundStart_76_UniversalWear(Event event, const char[] name, bool dontBroadcast) {
     g_Effect76_KillCount = new StringMap();

     StringMapSnapshot snap = g_WeaponInfo.Snapshot();

     int len = snap.Length;
     char key[8];

     for(int i = 0; i < len; i++) {
          snap.GetKey(i, key, sizeof(key));
          g_Effect76_KillCount.SetValue(key, 0);
     }

     delete snap;
}

public void Event_RoundEnd_76_UniversalWear(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               int primaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Primary);
               if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_RemoveByName(primaryWeapon, "damage bonus");
               }

               int secondaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary);
               if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
                    TF2Attrib_RemoveByName(secondaryWeapon, "damage bonus");
               }
               
               int meleeWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Melee);
               if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
                    TF2Attrib_RemoveByName(meleeWeapon, "damage bonus");
               }
          }
     }
}

public void Event_PlayerUpdate_76_UniversalWear(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     E76_UpdateWeaponDamage(client);
}

public void Event_PlayerDeath_76_UniversalWear(Event event, const char[] name, bool dontBroadcast) {
     int victim = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(victim == attacker || !IsClientInGame(attacker) || !IsPlayerAlive(attacker)) {
          return;
     }

     int weaponIndex = event.GetInt("weapon_def_index");
     char weaponIndexString[8];
     IntToString(weaponIndex, weaponIndexString, sizeof(weaponIndexString));

     char reskinIndexString[8];
     bool isReskin = g_ReskinInfo.GetString(weaponIndexString, reskinIndexString, sizeof(reskinIndexString));
     if(isReskin) {
          strcopy(weaponIndexString, sizeof(weaponIndexString), reskinIndexString);
     }

     int currentValue;
     g_Effect76_KillCount.GetValue(weaponIndexString, currentValue);
     g_Effect76_KillCount.SetValue(weaponIndexString, currentValue + 1);

     E76_UpdateWeaponDamageAll(weaponIndex, currentValue + 1);
}

public void E76_UpdateWeaponDamageAll(int weaponIndex, int value) {
     char key[8];
     IntToString(weaponIndex, key, sizeof(key));

     char reskinKey[8];
     if(g_ReskinInfo.GetString(key, reskinKey, sizeof(reskinKey))) {
          strcopy(key, sizeof(key), reskinKey);
     }

     int canonicalIndex = StringToInt(key);

     float bonus = 1.0 - (value * 0.02);

     for(int i = 1; i <= MaxClients; i++) {
          if(!IsClientInGame(i) || !IsPlayerAlive(i)) {
               continue;
          }

          for(int s = 0; s < 3; s++) {
               int weapon = GetPlayerWeaponSlot(i, slots[s]);
               if(weapon == -1 || !IsValidEntity(weapon)) {
                    continue;
               }

               int defindex = GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex");

               char defKey[8];
               IntToString(defindex, defKey, sizeof(defKey));

               char defReskinKey[8];
               if(g_ReskinInfo.GetString(defKey, defReskinKey, sizeof(defReskinKey))) {
                    strcopy(defKey, sizeof(defKey), defReskinKey);
               }

               int defCanonical = StringToInt(defKey);

               if(defCanonical == canonicalIndex) {
                    TF2Attrib_SetByName(weapon, "damage bonus", bonus);
                    break;
               }
          }
     }
}

public void E76_UpdateWeaponDamage(int client) {
     if(!IsClientInGame(client) || !IsPlayerAlive(client)) {
          return;
     }

     for(int s = 0; s < 3; s++) {
          int weapon = GetPlayerWeaponSlot(client, slots[s]);
          if(weapon == -1 || !IsValidEntity(weapon)) {
               continue;
          }

          int defindex = GetEntProp(weapon, Prop_Send, "m_iItemDefinitionIndex");

          char key[8];
          IntToString(defindex, key, sizeof(key));

          char reskinKey[8];
          if(g_ReskinInfo.GetString(key, reskinKey, sizeof(reskinKey))) {
               strcopy(key, sizeof(key), reskinKey);
          }

          int kills = 0;
          g_Effect76_KillCount.GetValue(key, kills);

          float bonus = 1.0 - (kills * 0.02);
          TF2Attrib_SetByName(weapon, "damage bonus", bonus);
     }
}
