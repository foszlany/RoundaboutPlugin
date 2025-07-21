#pragma semicolon 1

#define HEALTH_BONUS 2

public void Event_RoundStart_30_Balanced(Event event, const char[] name, bool dontBroadcast) {
     g_Effect30_BalanceIndicator = 0;

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_30_Balanced(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     SetHealthAdvantage(client, true);
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
          SetHealthAdvantage(i, false);
     }
}


public void Event_RoundEnd_30_Balanced(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               TF2Attrib_RemoveByName(i, "max health additive bonus");
          }
     }
}

public void SetHealthAdvantage(int client, bool isUpdate) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          int advantage = ((TF2_GetClientTeam(client) == TFTeam_Red) == (g_Effect30_BalanceIndicator > 0)) 
                              ? g_Effect30_BalanceIndicator 
                              : -g_Effect30_BalanceIndicator;

          /* this is so broken
               float clientMaxHealth = float(TF2_GetPlayerResourceData(client, TFResource_MaxHealth));
               if(advantage < 0 && clientMaxHealth <= MIN_HEALTH) {
                    if(isUpdate) {
                         clientMaxHealth = float(TF2_GetPlayerResourceData(client, TFResource_MaxHealth));

                         PrintToChatAll("mhealth: %f", clientMaxHealth);
                         
                         float offset = -1.0 * RoundToNearest((clientMaxHealth - MIN_HEALTH) / HEALTH_BONUS);

                         PrintToChatAll("offset: %f", offset);

                         TF2Attrib_SetByName(client, "max health additive bonus", offset * HEALTH_BONUS);
                         SetEntityHealth(client, MIN_HEALTH);
                    }

                    return;
               }
          */

          float bonusHealth = float(advantage) * HEALTH_BONUS;

          TF2Attrib_SetByName(client, "max health additive bonus", bonusHealth);
     }
}