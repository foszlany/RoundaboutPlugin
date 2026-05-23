#pragma semicolon 1

public void Event_PlayerHit_36_SocialDistancing(Event event, const char[] name, bool dontBroadcast) {
     int attacker = GetClientOfUserId(event.GetInt("attacker"));
     int victim = GetClientOfUserId(event.GetInt("userid"));

     if(attacker <= 0 || attacker == victim || !IsPlayerAlive(attacker)) {
          return;
     }

     int damage = event.GetInt("damageamount");

     for(int i = 1; i <= MaxClients; i++) {
          int dmgtype = event.GetInt("damagebits");

          if(dmgtype & DMG_SOCIALDIST || !IsClientInGame(i) || !IsPlayerAlive(i) || i == victim || TF2_GetClientTeam(attacker) == TF2_GetClientTeam(i)) {
               continue;
          }

          float dist = CalculateDistance(victim, i);

          if(dist <= 256.0) {
               float newDamage = damage * 0.66;

               EmitSoundToClient(i, "ambient/energy/zap3.wav");

               SDKHooks_TakeDamage(
                    i,
                    attacker,
                    attacker,
                    newDamage,
                    DMG_GENERIC | DMG_SOCIALDIST,
                    -1,
                    NULL_VECTOR,
                    NULL_VECTOR
               );
          }
     }
}