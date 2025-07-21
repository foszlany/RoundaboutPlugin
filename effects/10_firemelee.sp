#pragma semicolon 1

public void Event_RoundStart_10_FireMelee(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          applyMiniCritVsBurning(i);
     }
     
     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerHit_10_FireMelee(Event event, const char[] name, bool dontBroadcast) {
     int attacker = GetClientOfUserId(event.GetInt("attacker"));
     int victim = GetClientOfUserId(event.GetInt("userid"));

     if(attacker <= 0 || attacker > MaxClients || !IsClientInGame(attacker)) {
          return;
     }

     if(TF2_GetPlayerClass(attacker) == TFClass_Engineer) {
          int sentryTarget = GetSentryTarget(attacker);
          
          if(sentryTarget == victim) {
               return;
          }
     }

     int weapon = GetPlayerWeaponSlot(attacker, 2);
     if(weapon != -1 && weapon == GetEntPropEnt(attacker, Prop_Send, "m_hActiveWeapon")) {
          if(
               !TF2_IsPlayerInCondition(victim, TFCond_OnFire)                   &&
               TF2_IsPlayerInCondition(victim, TFCond_Jarated)                 &&
               TF2_IsPlayerInCondition(attacker, TFCond_Buffed)                &&
               TF2_IsPlayerInCondition(attacker, TFCond_NoHealingDamageBuff)
          ) {
               TF2_IgnitePlayer(victim, attacker, 8.0);
          }
     }
}

public void Event_PlayerUpdate_10_FireMelee(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     applyMiniCritVsBurning(client);
}

public void Event_RoundEnd_10_FireMelee(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               int meleeWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Melee);
               if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
                    TF2Attrib_RemoveByName(meleeWeapon, "minicrit vs burning player");
               }
          }
     }
}

public void applyMiniCritVsBurning(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          int meleeWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
          if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
               TF2Attrib_SetByName(meleeWeapon, "minicrit vs burning player", 1.0);
          }
     }
}

public int GetSentryTarget(int engineer) {
     int sentry = FindEngineerSentry(engineer);
     if(sentry != -1) {
          return GetEntPropEnt(sentry, Prop_Send, "m_hEnemy");
     }
     return -1;
}

public int FindEngineerSentry(int engineer) {
     int entity = -1;
     while((entity = FindEntityByClassname(entity, "obj_sentrygun")) != -1) {
          if(GetEntPropEnt(entity, Prop_Send, "m_hBuilder") == engineer) {
               return entity;
          }
     }
     return -1;
}