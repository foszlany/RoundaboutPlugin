#pragma semicolon 1

public void Event_RoundStart_10_FireMelee(Event event, const char[] name, bool dontBroadcast) {
     PrintCenterTextAll("Fire Aspect");
     ShowHintToAllClients("Fire Aspect\n\nMelee hits set the enemy on fire for 8 seconds, burning players receive mini-crits.");
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
     int damage = event.GetInt("damageamount");
     if(weapon != -1 && weapon == GetEntPropEnt(attacker, Prop_Send, "m_hActiveWeapon") && damage > 6) {
          if(
               TF2_IsPlayerInCondition(victim, TFCond_OnFire)                   &&
               !TF2_IsPlayerInCondition(victim, TFCond_Jarated)                 &&
               !TF2_IsPlayerInCondition(attacker, TFCond_Buffed)                &&
               !TF2_IsPlayerInCondition(attacker, TFCond_NoHealingDamageBuff)
          ) {
               event.SetBool("minicrit", true);
               event.SetInt("damageamount", RoundToNearest(damage * 1.35));
          }
          else {
               TF2_IgnitePlayer(victim, attacker, 8.0);
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