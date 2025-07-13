#pragma semicolon 1

public void Event_RoundStart_35_Hell(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               SetHellAttributes(i);
          }
     }

     PrintCenterTextAll("Hell");
     ShowHintToAllClients("Hell\n\nGreatly amplified Pyro abilties.");
}

public void Event_PlayerUpdate_35_Hell(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     SetHellAttributes(client);
}

public void Event_RoundEnd_35_Hell(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               int primaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Primary);
               if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_RemoveByName(primaryWeapon, "flame size bonus");
                    TF2Attrib_RemoveByName(primaryWeapon, "flame_spread_degree");

                    TF2Attrib_RemoveByName(primaryWeapon, "maxammo primary increased");
                    TF2Attrib_RemoveByName(primaryWeapon, "fire rate bonus");
                    TF2Attrib_RemoveByName(primaryWeapon, "airblast pushback scale");
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

public void SetHellAttributes(int client) {
     forceClass(client, TFClass_Pyro);

     int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
     if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
          TF2Attrib_SetByName(primaryWeapon, "flame size bonus", 1.75);
          TF2Attrib_SetByName(primaryWeapon, "flame_spread_degree", 40.0);

          TF2Attrib_SetByName(primaryWeapon, "maxammo primary increased", 3.5);
          TF2Attrib_SetByName(primaryWeapon, "fire rate bonus", 2.0);
          TF2Attrib_SetByName(primaryWeapon, "airblast pushback scale", 1.75);
     }

     int secondaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
     if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
          TF2Attrib_SetByName(secondaryWeapon, "damage bonus", 1.25);
     }
     
     int meleeWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
     if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
          TF2Attrib_SetByName(meleeWeapon, "damage bonus", 1.25);
     }
}