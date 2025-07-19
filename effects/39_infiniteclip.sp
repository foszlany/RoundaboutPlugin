#pragma semicolon 1

public void Event_RoundStart_39_InfiniteClip(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               SetHighWeaponClip(i);
          }
     }

     ShowCurrentEffectDescription(-1);
}

public void Event_PlayerUpdate_39_InfiniteClip(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          SetHighWeaponClip(client);
     }
}

public void Event_RoundEnd_39_InfiniteClip(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               int primaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Primary);
               if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_RemoveByName(primaryWeapon, "clip size bonus");
                    TF2Attrib_RemoveByName(primaryWeapon, "maxammo primary increased");
               }

               int secondaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary);
               if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
                    TF2Attrib_RemoveByName(secondaryWeapon, "clip size bonus");
                    TF2Attrib_RemoveByName(secondaryWeapon, "maxammo primary increased");
               }
               
               int meleeWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Melee);
               if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
                    TF2Attrib_RemoveByName(meleeWeapon, "clip size bonus");
                    TF2Attrib_RemoveByName(meleeWeapon, "maxammo primary increased");
               }
          }
     }
}

public void SetHighWeaponClip(int client) {
     int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
     if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
          if(TF2_GetPlayerClass(client) == TFClass_Pyro || TF2_GetPlayerClass(client) == TFClass_Heavy) {
               TF2Attrib_RemoveByName(primaryWeapon, "clip size bonus");
               TF2Attrib_RemoveByName(primaryWeapon, "maxammo primary increased");
          }
          else {
               TF2Attrib_SetByName(primaryWeapon, "clip size bonus", 4.0);
               TF2Attrib_SetByName(primaryWeapon, "maxammo primary increased", 1.5);
          }
     }

     int secondaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
     if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon) && TF2_GetPlayerClass(client) != TFClass_Medic) {
          TF2Attrib_SetByName(secondaryWeapon, "clip size bonus", 4.0);
          TF2Attrib_SetByName(secondaryWeapon, "maxammo primary increased", 1.5);
     }
     
     int meleeWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
     if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
          TF2Attrib_SetByName(meleeWeapon, "clip size bonus", 4.0);
          TF2Attrib_SetByName(meleeWeapon, "maxammo primary increased", 1.5);
     }
}