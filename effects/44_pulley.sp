#pragma semicolon 1

public void Event_RoundStart_44_Pulley(Event event, const char[] name, bool dontBroadcast) {
     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerHit_44_Pulley(Event event, const char[] name, bool dontBroadcast) {
     int victim = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(attacker <= 0 || attacker == victim || !IsClientInGame(victim) || !IsPlayerAlive(victim)) {
          return;
     }
          
     int damage = event.GetInt("damageamount");

     float victimPos[3];
     GetClientAbsOrigin(victim, victimPos);

     float attackerPos[3];
     GetClientAbsOrigin(attacker, attackerPos);

     float dir[3];
     SubtractVectors(attackerPos, victimPos, dir);
     NormalizeVector(dir, dir);
     ScaleVector(dir, 38.0 + 12.0 * damage);

     // FORCE AIRBORNE STATE FOR GROUNDED PLAYERS
     if(GetEntityFlags(victim) & FL_ONGROUND) {
          SetEntityFlags(victim, GetEntityFlags(victim) & ~FL_ONGROUND);
          SetEntPropEnt(victim, Prop_Send, "m_hGroundEntity", -1);
          dir[2] += 7.0 + RoundToFloor(damage / 20.0);
     }

     // APPLY VELOCITY
     float newVelocity[3];
     GetEntPropVector(victim, Prop_Data, "m_vecVelocity", newVelocity);
     AddVectors(newVelocity, dir, newVelocity);
     TeleportEntity(victim, NULL_VECTOR, NULL_VECTOR, newVelocity);
}