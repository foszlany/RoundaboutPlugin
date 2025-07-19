#pragma semicolon 1

public void Event_RoundStart_25_Assassins(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          forceClass(i, TFClass_Spy);
          applyAssassinEffect(i);
     }

     ShowCurrentEffectDescription(-1);
}

public void Event_PlayerUpdate_25_Assassins(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     forceClass(client, TFClass_Spy);
     applyAssassinEffect(client);
}

public void Event_RoundEnd_25_Assassins(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               int primaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Primary);
               if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_RemoveByName(primaryWeapon, "damage bonus");
                    TF2Attrib_RemoveByName(primaryWeapon, "clip size penalty");
               }
          }
     }
}

public void applyAssassinEffect(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);

          // REMOVE BULLETS FROM CLIP UPON SPAWNING
          if(IsValidEntity(primaryWeapon)) {
               EquipPlayerWeapon(client, primaryWeapon);
               SetEntProp(primaryWeapon, Prop_Send, "m_iClip1", 1);
          }

          // APPLY ATTRIBUTES
          if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
               TF2Attrib_SetByName(primaryWeapon, "damage bonus", 100.0);
               TF2Attrib_SetByName(primaryWeapon, "clip size penalty", 0.1);
          }
     }
}