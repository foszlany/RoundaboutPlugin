#pragma semicolon 1

public void Event_RoundStart_19_Justice(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MAXPLAYERS; i++) {
          g_Effect19_LastKiller[i] = 0;
     }

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerDeath_19_Justice(Event event, const char[] name, bool dontBroadcast) {
     int victim = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(victim == attacker) {
          return;
     }

     g_Effect19_LastKiller[victim] = attacker;
     
     if(attacker != 0 && victim != 0 && g_Effect19_LastKiller[attacker] == victim && IsClientInGame(attacker) && IsPlayerAlive(attacker)) {
          g_Effect19_LastKiller[attacker] = 0;
          TF2_AddCondition(attacker, TFCond_CritOnWin, 8.0);

          PrintToChatAll("\x07B143F1[Roundabout]\x01 %N has avenged %N!", attacker, victim);
     }
}