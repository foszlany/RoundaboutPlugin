#pragma semicolon 1

#define E58_KING_DAMAGE_BONUS 1.5
#define E58_KING_BONUS_HEALTH 300.0
#define E58_KING_HEALTH_REGEN 6.0
#define E58_KING_SCALE 1.2
#define E58_KING_GIVEN_HEALTH 500

public void Event_RoundStart_58_King(Event event, const char[] name, bool dontBroadcast) {
     for(;;) {
          if(CountActivePlayers() < 1) {
               break;
          }

          g_Effect58_King = GetRandomInt(1, MaxClients);

          if(IsClientInGame(g_Effect58_King)) {
               E58_ApplyKingProperties();
               PrintToChatAll("\x07B143F1[Roundabout]\x01 %N has been selected as the King!", g_Effect58_King);
               break;
          }
     }

     HookEvent("player_disconnect", E58_HandleKingDisconnect, EventHookMode_Pre);
}

public void Event_PlayerUpdate_58_King(Event event, const char[] name, bool dontBroadcast) {    
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(client == g_Effect58_King) {
          E58_ApplyKingProperties();
     }
}

public void Event_PlayerDeath_58_King(Event event, const char[] name, bool dontBroadcast) {    
     int victim = GetClientOfUserId(event.GetInt("userid"));

     if(victim == g_Effect58_King) {
          int attacker = GetClientOfUserId(event.GetInt("attacker"));
          E58_RemoveKingProperties();

          if(attacker > 0 && IsClientInGame(attacker) && attacker != victim) {
               g_Effect58_King = attacker;

               E58_ApplyKingProperties();
               PrintToChatAll("\x07B143F1[Roundabout]\x01 The King has been slain by %N!", attacker);
          }
          else {
               for(;;) {
                    g_Effect58_King = GetRandomInt(1, MaxClients);

                    if(IsClientInGame(g_Effect58_King)) {
                         E58_ApplyKingProperties();
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 %N didn't feel like being a King. %N has been selected as the new one!", victim, g_Effect58_King);
                         break;
                    }
               }
          }
     }
}

public void Event_RoundEnd_58_King(Event event, const char[] name, bool dontBroadcast) {
     UnhookEvent("player_disconnect", E58_HandleKingDisconnect, EventHookMode_Pre);

     E58_RemoveKingProperties();
}

public void E58_HandleKingDisconnect(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(client == g_Effect58_King) {
          for(;;) { 
               g_Effect58_King = GetRandomInt(1, MaxClients);

               if(IsClientInGame(g_Effect58_King)) {
                    E58_ApplyKingProperties();

                    PrintToChatAll("\x07B143F1[Roundabout]\x01 The King disconnected, %N has been selected as the new King!", g_Effect58_King);
                    break;
               }
          }
     }
}

public void E58_ApplyKingProperties() {
     TF2Attrib_SetByName(g_Effect58_King, "damage bonus", E58_KING_DAMAGE_BONUS);
     TF2Attrib_SetByName(g_Effect58_King, "max health additive bonus", E58_KING_BONUS_HEALTH);
     TF2Attrib_SetByName(g_Effect58_King, "health regen", E58_KING_HEALTH_REGEN);
     SetEntPropFloat(g_Effect58_King, Prop_Send, "m_flModelScale", E58_KING_SCALE);
     SetEntityHealth(g_Effect58_King, E58_KING_GIVEN_HEALTH);

     CreateStaticParticle(g_Effect58_King, "lava_playertouch", 1.0, 60.0);
}

public void E58_RemoveKingProperties() {
     TF2Attrib_RemoveByName(g_Effect58_King, "damage bonus");
     TF2Attrib_RemoveByName(g_Effect58_King, "max health additive bonus");
     TF2Attrib_RemoveByName(g_Effect58_King, "health regen");
     SetEntPropFloat(g_Effect58_King, Prop_Send, "m_flModelScale", 1.0);
}