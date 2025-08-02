#pragma semicolon 1

public void Event_RoundStart_58_King(Event event, const char[] name, bool dontBroadcast) {
     for(;;) {
          g_Effect58_King = GetRandomInt(1, MaxClients);

          if(IsClientInGame(g_Effect58_King)) {
               ApplyKingProperties();
               PrintToChatAll("\x07B143F1[Roundabout]\x01 %N has been selected as the King!", g_Effect58_King);
               break;
          }
     }

     HookEvent("player_disconnect", HandleKingDisconnect, EventHookMode_Pre);

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_58_King(Event event, const char[] name, bool dontBroadcast) {    
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(client == g_Effect58_King) {
          ApplyKingProperties();
     }
}

public void Event_PlayerDeath_58_King(Event event, const char[] name, bool dontBroadcast) {    
     int victim = GetClientOfUserId(event.GetInt("userid"));

     if(victim == g_Effect58_King) {
          int attacker = GetClientOfUserId(event.GetInt("attacker"));
          RemoveKingProperties();

          if(attacker > 0 && IsClientInGame(attacker) && attacker != victim) {
               g_Effect58_King = attacker;

               ApplyKingProperties();
               PrintToChatAll("\x07B143F1[Roundabout]\x01 The King has been slain by %N!", attacker);
          }
          else {
               for(;;) {
                    g_Effect58_King = GetRandomInt(1, MaxClients);

                    if(IsClientInGame(g_Effect58_King)) {
                         ApplyKingProperties();
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 %N didn't feel like being a King. %N has been selected as the new one!", victim, g_Effect58_King);
                         break;
                    }
               }
          }
     }
}

public void Event_RoundEnd_58_King(Event event, const char[] name, bool dontBroadcast) {
     UnhookEvent("player_disconnect", HandleKingDisconnect, EventHookMode_Pre);

     RemoveKingProperties();
}

public void HandleKingDisconnect(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(client == g_Effect58_King) {
          for(;;) { 
               g_Effect58_King = GetRandomInt(1, MaxClients);

               if(IsClientInGame(g_Effect58_King)) {
                    ApplyKingProperties();

                    PrintToChatAll("\x07B143F1[Roundabout]\x01 The King disconnected, %N has been selected as the new King!", g_Effect58_King);
                    break;
               }
          }
     }
}

public void ApplyKingProperties() {
     TF2Attrib_SetByName(g_Effect58_King, "damage bonus", 1.5);
     TF2Attrib_SetByName(g_Effect58_King, "max health additive bonus", 300.0);
     TF2Attrib_SetByName(g_Effect58_King, "health regen", 6.0);
     SetEntPropFloat(g_Effect58_King, Prop_Send, "m_flModelScale", 1.2);

     CreateStaticParticle(g_Effect58_King, "lava_playertouch", 1.0, 60.0);

     SetEntityHealth(g_Effect58_King, 500);
}

public void RemoveKingProperties() {
     TF2Attrib_RemoveByName(g_Effect58_King, "damage bonus");
     TF2Attrib_RemoveByName(g_Effect58_King, "max health additive bonus");
     TF2Attrib_RemoveByName(g_Effect58_King, "health regen");
     SetEntPropFloat(g_Effect58_King, Prop_Send, "m_flModelScale", 1.0);
}