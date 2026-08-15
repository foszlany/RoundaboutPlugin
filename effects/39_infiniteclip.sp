#pragma semicolon 1

#define E39_PRIMARY_CLIP_SIZE_MULTIPLIER 4.0
#define E39_PRIMARY_RESERVE_SIZE_MULTIPLIER 2.5
#define E39_SECONDARY_CLIP_SIZE_MULTIPLIER 3.0
#define E39_SECONDARY_RESERVE_SIZE_MULTIPLIER 3.0
#define E39_MELEE_RESERVE_SIZE_MULTIPLIER 4.0

public void Event_RoundStart_39_InfiniteClip(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               E39_SetHighWeaponClip(i);
               TF2_RegeneratePlayer(i);
          }
     }
}

public void Event_PlayerUpdate_39_InfiniteClip(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          E39_SetHighWeaponClip(client);
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
                    TF2Attrib_RemoveByName(secondaryWeapon, "maxammo secondary increased");
                    TF2Attrib_RemoveByName(secondaryWeapon, "maxammo grenades1 increased");
               }
               
               int meleeWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Melee);
               if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
                    TF2Attrib_RemoveByName(meleeWeapon, "maxammo grenades1 increased");
               }
          }
     }
}

public void E39_SetHighWeaponClip(int client) {
     int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
     if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
          TF2Attrib_SetByName(primaryWeapon, "clip size bonus", E39_PRIMARY_CLIP_SIZE_MULTIPLIER);
          TF2Attrib_SetByName(primaryWeapon, "maxammo primary increased", E39_PRIMARY_RESERVE_SIZE_MULTIPLIER);
     }

     int secondaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
     if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon) && TF2_GetPlayerClass(client) != TFClass_Medic) {
          TF2Attrib_SetByName(secondaryWeapon, "clip size bonus", 3.5); 
          TF2Attrib_SetByName(secondaryWeapon, "maxammo secondary increased", E39_SECONDARY_CLIP_SIZE_MULTIPLIER);
          TF2Attrib_SetByName(secondaryWeapon, "maxammo grenades1 increased", E39_SECONDARY_RESERVE_SIZE_MULTIPLIER);
     }
     
     int meleeWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
     if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
          TF2Attrib_SetByName(meleeWeapon, "maxammo grenades1 increased", E39_MELEE_RESERVE_SIZE_MULTIPLIER);
     }
}