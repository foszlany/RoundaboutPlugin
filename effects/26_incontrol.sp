#pragma semicolon 1

#define E26_AIRACCELERATE 250

public void Event_RoundStart_26_InControl(Event event, const char[] name, bool dontBroadcast) {
     ConVar airAcceleration = FindConVar("sv_airaccelerate");
     g_Effect26_OriginalAirAcceleration = GetConVarInt(airAcceleration);

     // AIR ACCEL
     if(airAcceleration != null) {
          int originalFlags = GetConVarFlags(airAcceleration);
          SetConVarFlags(airAcceleration, originalFlags & ~(FCVAR_NOTIFY|FCVAR_REPLICATED));

          SetConVarInt(airAcceleration, E26_AIRACCELERATE, true, false);
     }
     else {
          ServerCommand("sm_cvar sv_airaccelerate %d", E26_AIRACCELERATE);
     }

     // WEAPON STAT
     for(int i = 1; i <= MaxClients; i++) {
          E26_SetInControlAttributes(i);
     }
}

public void Event_PlayerUpdate_26_InControl(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     E26_SetInControlAttributes(client);
}

public void Event_RoundEnd_26_InControl(Event event, const char[] name, bool dontBroadcast) {
     ConVar airAcceleration = FindConVar("sv_airaccelerate");
     if(airAcceleration != null) {
          SetConVarInt(airAcceleration, g_Effect26_OriginalAirAcceleration, true, false);
     }
     else {
          ServerCommand("sm_cvar sv_airaccelerate %d", g_Effect26_OriginalAirAcceleration);
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               int primaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Primary);
               if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_RemoveByName(primaryWeapon, "mod mini-crit airborne");
               }

               int meleeWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Melee);
               if(IsValidEntity(meleeWeapon)) {
                    TF2Attrib_RemoveByName(meleeWeapon, "mod crit while airborne");
               }
          }
     }
}

public void E26_SetInControlAttributes(int client) {
     if(IsClientInGame(client)) {
          ForceClass(client, TFClass_Soldier);

          int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
          if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
               TF2Attrib_SetByName(primaryWeapon, "mod mini-crit airborne", 1.0);
          }

          int meleeWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
          if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
               TF2Attrib_SetByName(meleeWeapon, "mod crit while airborne", 1.0);
          }
     }
}