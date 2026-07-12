#pragma semicolon 1

#define E29_VOICE_PITCH_MULTIPLIER 2.0
#define E29_MODEL_SIZE_MULTIPLIER 0.75
#define E29_MOVE_SPEED_MULTIPLIER 1.2
#define E29_SECONDARY_DAMAGE_MULTIPLIER 1.3
#define E29_SECONDARY_AMMO_MULTIPLIER 2.0

public void Event_RoundStart_29_Mosquito(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               E29_SetMosquitoAttributes(i);
               TF2_RegeneratePlayer(i);
          }
     }
}

public void Event_PlayerUpdate_29_Mosquito(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     E29_SetMosquitoAttributes(client);
}

public void Event_RoundEnd_29_Mosquito(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               int primaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Primary);
               if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_RemoveByName(primaryWeapon, "air dash count");
               }

               int secondaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary);
               if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
                    TF2Attrib_RemoveByName(secondaryWeapon, "air dash count");
                    TF2Attrib_RemoveByName(secondaryWeapon, "maxammo secondary increased");
               }
               
               int meleeWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Melee);
               if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
                    TF2Attrib_RemoveByName(meleeWeapon, "air dash count");
               }

               TF2Attrib_RemoveByName(secondaryWeapon, "damage bonus");
               TF2Attrib_RemoveByName(i, "voice pitch scale");
               TF2Attrib_RemoveByName(i, "move speed penalty");
               
               SetEntPropFloat(i, Prop_Send, "m_flModelScale", 1.0);
          }
     }
}

public void E29_SetMosquitoAttributes(int client) {
     ForceClass(client, TFClass_Scout);

     int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
     if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
          TF2Attrib_SetByName(primaryWeapon, "air dash count", 999.0);
     }

     int secondaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
     if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
          TF2Attrib_SetByName(secondaryWeapon, "air dash count", 999.0);
          TF2Attrib_SetByName(secondaryWeapon, "maxammo secondary increased", E29_SECONDARY_AMMO_MULTIPLIER);
          TF2Attrib_SetByName(secondaryWeapon, "damage bonus", E29_SECONDARY_DAMAGE_MULTIPLIER);
     }
     
     int meleeWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
     if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
          TF2Attrib_SetByName(meleeWeapon, "air dash count", 999.0);
     }

     TF2Attrib_SetByName(client, "voice pitch scale", E29_VOICE_PITCH_MULTIPLIER);
     TF2Attrib_SetByName(client, "move speed penalty", E29_MOVE_SPEED_MULTIPLIER);

     SetEntPropFloat(client, Prop_Send, "m_flModelScale", E29_MODEL_SIZE_MULTIPLIER);
}