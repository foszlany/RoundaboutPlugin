#pragma semicolon 1

public void Event_RoundStart_45_OnDemandGlassCannon(Event event, const char[] name, bool dontBroadcast) {
     PrintCenterTextAll("On Demand Glass Cannon");
     ShowHintToAllClients("On Demand Glass Cannon\n\nThe lower your health, the more you damage!");

     HookEvent("player_healed", Event_PlayerHit_45_OnDemandGlassCannon, EventHookMode_Post);
}

public void Event_RoundEnd_45_OnDemandGlassCannon(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               TF2Attrib_RemoveByName(i, "damage bonus");
          }
     }
     
     UnhookEvent("player_healed", Event_PlayerHit_45_OnDemandGlassCannon, EventHookMode_Post);
}

public void Event_PlayerHit_45_OnDemandGlassCannon(Event event, const char[] name, bool dontBroadcast) {
     int victim;
     
     char eventType[16];
     GetEventName(event, eventType, sizeof(eventType));

     if(StrEqual("player_healed", eventType)) {
          victim = GetClientOfUserId(event.GetInt("patient"));
     }
     else {
          victim = GetClientOfUserId(event.GetInt("userid"));
     }

     if(!IsClientInGame(victim) || !IsPlayerAlive(victim)) {
          return;
     }
          
     TF2Attrib_RemoveByName(victim, "damage bonus");

     float health = float(GetClientHealth(victim));
     if(health == 100.0) {
          return;
     }

     int maxHealth = GetEntProp(victim, Prop_Data, "m_iMaxHealth");
     float bonus = 1.01 + ((float(maxHealth) - health) / float(maxHealth));
     bonus = float(RoundToNearest(bonus * 100.0)) / 100.0;

     TF2Attrib_SetByName(victim, "damage bonus", bonus);
}

public void Event_PlayerDeath_45_OnDemandGlassCannon(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     TF2Attrib_RemoveByName(client, "damage bonus");
}