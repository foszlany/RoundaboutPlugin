#pragma semicolon 1

public void Event_RoundStart_26_InControl(Event event, const char[] name, bool dontBroadcast) {
     ConVar airAcceleration = FindConVar("sv_airaccelerate");
     g_Effect26_OriginalAirAcceleration = GetConVarInt(airAcceleration);

     // AIR ACCEL
     if(airAcceleration != null) {
          int originalFlags = GetConVarFlags(airAcceleration);
          SetConVarFlags(airAcceleration, originalFlags & ~(FCVAR_NOTIFY|FCVAR_REPLICATED));

          SetConVarInt(airAcceleration, 250, true, false);
     }
     else {
          ServerCommand("sm_cvar sv_airaccelerate 250");
     }

     // WEAPON STAT
     for(int i = 1; i <= MaxClients; i++) {
          SetInControlAttributes(i);
     }
     
     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_26_InControl(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     SetInControlAttributes(client);
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

public void SetInControlAttributes(int client) {
     if(IsClientInGame(client)) {
          forceClass(client, TFClass_Soldier);

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