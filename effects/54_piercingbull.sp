#pragma semicolon 1

public void Event_RoundStart_54_PiercingBullets(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          SetPierceAttributes(i);
     }
     
     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_54_PiercingBullets(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     SetPierceAttributes(client);
}

public void Event_RoundEnd_54_PiercingBullets(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               int primaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Primary);
               if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_RemoveByName(primaryWeapon, "projectile penetration heavy");
               }

               int secondaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary);
               if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
                    TF2Attrib_RemoveByName(secondaryWeapon, "projectile penetration heavy");
               }
          }
     }
}

public void SetPierceAttributes(int client) {
     if(IsClientInGame(client)) {
          int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
          if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
               TF2Attrib_SetByName(primaryWeapon, "projectile penetration heavy", 24.0);
          }

          int secondaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
          if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
               TF2Attrib_SetByName(secondaryWeapon, "projectile penetration heavy", 24.0);
          }
     }
}