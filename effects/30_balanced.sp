#pragma semicolon 1

#define E30_HEALTH_BONUS 2

public void Event_RoundStart_30_Balanced(Event event, const char[] name, bool dontBroadcast) {
     g_Effect30_BalanceIndicator = 0;
}

public void Event_PlayerUpdate_30_Balanced(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     E30_SetHealthAdvantage(client, true);
}

public void Event_PlayerDeath_30_Balanced(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(attacker < 1 || client == attacker) {
          return;
     }

     TFTeam attackerTeam = TF2_GetClientTeam(attacker);

     g_Effect30_BalanceIndicator += (attackerTeam == TFTeam_Red ? 1 : -1);

     for(int i = 1; i <= MaxClients; i++) {
          E30_SetHealthAdvantage(i, false);
     }
}


public void Event_RoundEnd_30_Balanced(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               TF2Attrib_RemoveByName(i, "max health additive bonus");
          }
     }
}

public void E30_SetHealthAdvantage(int client, bool isUpdate) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          int advantage = ((TF2_GetClientTeam(client) == TFTeam_Red) == (g_Effect30_BalanceIndicator > 0)) 
                              ? g_Effect30_BalanceIndicator 
                              : -g_Effect30_BalanceIndicator;

          float bonusHealth = float(advantage) * E30_HEALTH_BONUS;

          TF2Attrib_SetByName(client, "max health additive bonus", bonusHealth);
     }
}