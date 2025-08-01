#pragma semicolon 1

public void Event_RoundStart_32_Slowmo(Event event, const char[] name, bool dontBroadcast) {
     ConVar gravity = FindConVar("sv_gravity");
     g_Effect1_OriginalGravity = GetConVarInt(gravity);

     if(gravity != null) {
          int originalFlags = GetConVarFlags(gravity);
          SetConVarFlags(gravity, originalFlags & ~(FCVAR_NOTIFY|FCVAR_REPLICATED));

          SetConVarInt(gravity, 350, true, false);
     }
     else {
          ServerCommand("sv_gravity 350");
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               SetSlowmoAttributes(i);
          }
     }

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_32_Slowmo(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     SetSlowmoAttributes(client);
}

public void Event_RoundEnd_32_Slowmo(Event event, const char[] name, bool dontBroadcast) {
     ConVar gravity = FindConVar("sv_gravity");
     if(gravity != null) {
          SetConVarInt(gravity, g_Effect1_OriginalGravity, true, false);
     }
     else {
          ServerCommand("sv_gravity %d", g_Effect1_OriginalGravity);
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               int primaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Primary);
               if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_RemoveByName(primaryWeapon, "Reload time increased");
                    TF2Attrib_RemoveByName(primaryWeapon, "fire rate penalty");
                    TF2Attrib_RemoveByName(primaryWeapon, "Projectile speed decreased");
                    TF2Attrib_RemoveByName(primaryWeapon, "single wep holster time increased");
                    TF2Attrib_RemoveByName(primaryWeapon, "single wep deploy time increased");
               }

               int secondaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary);
               if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
                    TF2Attrib_RemoveByName(secondaryWeapon, "Reload time increased");
                    TF2Attrib_RemoveByName(secondaryWeapon, "fire rate penalty");
                    TF2Attrib_RemoveByName(secondaryWeapon, "Projectile speed decreased");
                    TF2Attrib_RemoveByName(secondaryWeapon, "single wep holster time increased");
                    TF2Attrib_RemoveByName(secondaryWeapon, "single wep deploy time increased");
                    TF2Attrib_RemoveByName(secondaryWeapon, "heal rate penalty");
               }
               
               int meleeWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Melee);
               if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
                    TF2Attrib_RemoveByName(meleeWeapon, "fire rate penalty");
                    TF2Attrib_RemoveByName(meleeWeapon, "Projectile speed decreased");
                    TF2Attrib_RemoveByName(meleeWeapon, "single wep holster time increased");
                    TF2Attrib_RemoveByName(meleeWeapon, "single wep deploy time increased");
               }
               
               TF2Attrib_RemoveByName(i, "move speed penalty");
               TF2Attrib_RemoveByName(i, "voice pitch scale");
          }
     }
}

public void SetSlowmoAttributes(int client) {
     int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
     if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
          TF2Attrib_SetByName(primaryWeapon, "Reload time increased", 1.50);
          TF2Attrib_SetByName(primaryWeapon, "fire rate penalty", 1.50);
          TF2Attrib_SetByName(primaryWeapon, "Projectile speed decreased", 0.50);
          TF2Attrib_SetByName(primaryWeapon, "single wep holster time increased", 1.50);
          TF2Attrib_SetByName(primaryWeapon, "single wep deploy time increased", 1.50);
     }

     int secondaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
     if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
          TF2Attrib_SetByName(secondaryWeapon, "Reload time increased", 1.50);
          TF2Attrib_SetByName(secondaryWeapon, "fire rate penalty", 1.50);
          TF2Attrib_SetByName(secondaryWeapon, "Projectile speed decreased", 0.50);
          TF2Attrib_SetByName(secondaryWeapon, "single wep holster time increased", 1.50);
          TF2Attrib_SetByName(secondaryWeapon, "single wep deploy time increased", 1.50);

          if(TF2_GetPlayerClass(client) == TFClass_Medic) {
               TF2Attrib_SetByName(secondaryWeapon, "heal rate penalty", 0.5);
          }
     }
     
     int meleeWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
     if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
          TF2Attrib_SetByName(meleeWeapon, "fire rate penalty", 1.50);
          TF2Attrib_SetByName(meleeWeapon, "Projectile speed decreased", 0.50);
          TF2Attrib_SetByName(meleeWeapon, "single wep holster time increased", 1.50);
          TF2Attrib_SetByName(meleeWeapon, "single wep deploy time increased", 1.50);
     }

     TF2Attrib_SetByName(client, "move speed penalty", 0.80);
     TF2Attrib_SetByName(client, "voice pitch scale", 0.7);
}