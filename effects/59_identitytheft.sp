#pragma semicolon 1

public void Event_RoundStart_59_IdentityTheft(Event event, const char[] name, bool dontBroadcast) {
     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerDeath_59_IdentityTheft(Event event, const char[] name, bool dontBroadcast) {    
     int victim = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(attacker > 0 && IsClientInGame(attacker) && IsClientInGame(victim) && attacker != victim) {
          TF2_SetPlayerClass(attacker, TF2_GetPlayerClass(victim));
          TF2_RegeneratePlayer(attacker);
     }
}