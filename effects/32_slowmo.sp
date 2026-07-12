#pragma semicolon 1

#define E32_GRAVITY_SCALE 350
#define E32_RELOAD_TIME_INCREASED 1.50
#define E32_FIRE_RATE_PENALTY 1.50
#define E32_PROJECTILE_SPEED_DECREASED 0.50
#define E32_HOLSTER_TIME_INCREASED 1.50
#define E32_DEPLOY_TIME_INCREASED 1.50
#define E32_HEAL_RATE_PENALTY 0.5
#define E32_MOVE_SPEED_PENALTY 0.80
#define E32_VOICE_PITCH_MULTIPLIER 0.7

public void Event_RoundStart_32_Slowmo(Event event, const char[] name, bool dontBroadcast) {
     ConVar gravity = FindConVar("sv_gravity");
     g_Effect1_OriginalGravity = GetConVarInt(gravity);

     if(gravity != null) {
          int originalFlags = GetConVarFlags(gravity);
          SetConVarFlags(gravity, originalFlags & ~(FCVAR_NOTIFY|FCVAR_REPLICATED));

          SetConVarInt(gravity, E32_GRAVITY_SCALE, true, false);
     }
     else {
          ServerCommand("sv_gravity %d", E32_GRAVITY_SCALE);
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               E32_SetSlowmoAttributes(i);
          }
     }
}

public void Event_PlayerUpdate_32_Slowmo(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     E32_SetSlowmoAttributes(client);
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

public void E32_SetSlowmoAttributes(int client) {
     int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
     if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
          TF2Attrib_SetByName(primaryWeapon, "Reload time increased", E32_RELOAD_TIME_INCREASED);
          TF2Attrib_SetByName(primaryWeapon, "fire rate penalty", E32_FIRE_RATE_PENALTY);
          TF2Attrib_SetByName(primaryWeapon, "Projectile speed decreased", E32_PROJECTILE_SPEED_DECREASED);
          TF2Attrib_SetByName(primaryWeapon, "single wep holster time increased", E32_HOLSTER_TIME_INCREASED);
          TF2Attrib_SetByName(primaryWeapon, "single wep deploy time increased", E32_DEPLOY_TIME_INCREASED);
     }

     int secondaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
     if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
          TF2Attrib_SetByName(secondaryWeapon, "Reload time increased", E32_RELOAD_TIME_INCREASED);
          TF2Attrib_SetByName(secondaryWeapon, "fire rate penalty", E32_FIRE_RATE_PENALTY);
          TF2Attrib_SetByName(secondaryWeapon, "Projectile speed decreased", E32_PROJECTILE_SPEED_DECREASED);
          TF2Attrib_SetByName(secondaryWeapon, "single wep holster time increased", E32_HOLSTER_TIME_INCREASED);
          TF2Attrib_SetByName(secondaryWeapon, "single wep deploy time increased", E32_DEPLOY_TIME_INCREASED);

          if(TF2_GetPlayerClass(client) == TFClass_Medic) {
               TF2Attrib_SetByName(secondaryWeapon, "heal rate penalty", E32_HEAL_RATE_PENALTY);
          }
     }
     
     int meleeWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
     if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
          TF2Attrib_SetByName(meleeWeapon, "fire rate penalty", E32_FIRE_RATE_PENALTY);
          TF2Attrib_SetByName(meleeWeapon, "Projectile speed decreased", E32_PROJECTILE_SPEED_DECREASED);
          TF2Attrib_SetByName(meleeWeapon, "single wep holster time increased", E32_HOLSTER_TIME_INCREASED);
          TF2Attrib_SetByName(meleeWeapon, "single wep deploy time increased", E32_DEPLOY_TIME_INCREASED);
     }

     TF2Attrib_SetByName(client, "move speed penalty", E32_MOVE_SPEED_PENALTY);
     TF2Attrib_SetByName(client, "voice pitch scale", E32_VOICE_PITCH_MULTIPLIER);
}