#pragma semicolon 1

public void Event_RoundStart_53_ShieldingMedicine(Event event, const char[] name, bool dontBroadcast) {
     g_Effect53_IsSpecialRound = false;
     if(GetRandomInt(1, 100) <= 15) {
          g_Effect53_IsSpecialRound = true;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Shields are Level 2.");
     }
     
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2Attrib_SetByName(i, "generate rage on heal", g_Effect53_IsSpecialRound ? 2.0 : 1.0);
          }
     }

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_53_ShieldingMedicine(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     TF2Attrib_SetByName(client, "generate rage on heal", g_Effect53_IsSpecialRound ? 2.0 : 1.0);
}

public void Event_RoundEnd_53_ShieldingMedicine(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               TF2Attrib_RemoveByName(i, "generate rage on heal");
          }
     }
}