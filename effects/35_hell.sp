#pragma semicolon 1

#define E35_FLAME_SIZE_BONUS 1.75
#define E35_FLAME_SPREAD_DEGREE 40.0
#define E35_MAXAMMO_PRIMARY_INCREASED 3.5
#define E35_FIRE_RATE_BONUS 2.0
#define E35_AIRBLAST_PUSHBACK_SCALE 1.75
#define E35_SECONDARY_DAMAGE_BONUS 1.25
#define E35_MELEE_DAMAGE_BONUS 1.25
#define E35_VOICE_PITCH_MULTIPLIER 0.5

public void Event_RoundStart_35_Hell(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               E35_SetHellAttributes(i);
          }
     }
}

public void Event_PlayerUpdate_35_Hell(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     E35_SetHellAttributes(client);
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

               TF2Attrib_RemoveByName(i, "voice pitch scale");
          }
     }
}

public void E35_SetHellAttributes(int client) {
     ForceClass(client, TFClass_Pyro);

     int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
     if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
          TF2Attrib_SetByName(primaryWeapon, "flame size bonus", E35_FLAME_SIZE_BONUS);
          TF2Attrib_SetByName(primaryWeapon, "flame_spread_degree", E35_FLAME_SPREAD_DEGREE);

          TF2Attrib_SetByName(primaryWeapon, "maxammo primary increased", E35_MAXAMMO_PRIMARY_INCREASED);
          TF2Attrib_SetByName(primaryWeapon, "fire rate bonus", E35_FIRE_RATE_BONUS);
          TF2Attrib_SetByName(primaryWeapon, "airblast pushback scale", E35_AIRBLAST_PUSHBACK_SCALE);
     }

     int secondaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
     if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
          TF2Attrib_SetByName(secondaryWeapon, "damage bonus", E35_SECONDARY_DAMAGE_BONUS);
     }
     
     int meleeWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
     if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
          TF2Attrib_SetByName(meleeWeapon, "damage bonus", E35_MELEE_DAMAGE_BONUS);
     }

     TF2Attrib_SetByName(client, "voice pitch scale", E35_VOICE_PITCH_MULTIPLIER);
}
