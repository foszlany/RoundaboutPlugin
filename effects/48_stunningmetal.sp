#pragma semicolon 1

public void Event_RoundStart_48_StunningMetal(Event event, const char[] name, bool dontBroadcast) {
     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerHit_48_StunningMetal(Event event, const char[] name, bool dontBroadcast) {
     int victim = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(attacker <= 0 || attacker == victim || !IsClientInGame(victim) || !IsPlayerAlive(victim)) {
          return;
     }
          
     int damage = event.GetInt("damageamount");

     if(damage < 25) {
          return;
     }
     if(damage >= 25 && damage < 50) {
          TF2_StunPlayer(victim, 1.4, 0.17, TF_STUNFLAG_SLOWDOWN);
     }
     else if(damage >= 50 && damage < 80) {
          TF2_StunPlayer(victim, 2.6, 0.32, TF_STUNFLAG_SLOWDOWN);
     }
     else if(damage >= 80 && damage < 110) {
          TF2_StunPlayer(victim, 3.8, 0.50, TF_STUNFLAG_SLOWDOWN);
     }
     else if(damage >= 110 && damage < 160) {
          TF2_StunPlayer(victim, 5.0, 0.75, TF_STUNFLAG_SLOWDOWN);
     }
     else if(damage >= 160) {
          TF2_StunPlayer(victim, 5.0, 1.0, TF_STUNFLAG_BONKSTUCK);
     }
}