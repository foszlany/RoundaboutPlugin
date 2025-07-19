#pragma semicolon 1

public void Event_RoundStart_15_BleedBuff(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MAXPLAYERS; i++) {
          g_Effect15_BleedCauserIndex[i] = -1;
     }

     ShowCurrentEffectDescription(-1);
}

public void Event_PlayerHit_15_BleedBuff(Event event, const char[] name, bool dontBroadcast) {
     int victim = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(IsClientInGame(victim) && IsPlayerAlive(victim) && victim >= 1 && attacker >= 1) {
          if(!TF2_IsPlayerInCondition(victim, TFCond_Bleeding)) {
               TF2_MakeBleed(victim, attacker, 8.0);
               g_Effect15_BleedCauserIndex[victim] = attacker;
          }
          else if(g_Effect15_BleedCauserIndex[victim] != attacker) {
               TF2_RemoveCondition(victim, TFCond_Bleeding);
               TF2_MakeBleed(victim, attacker, 8.0);
               g_Effect15_BleedCauserIndex[victim] = attacker;
          }
     }
}