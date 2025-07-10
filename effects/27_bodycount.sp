#pragma semicolon 1

public void Event_RoundStart_27_Bodycount(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MAXPLAYERS; i++) {
          g_Effect27_Bodycount[i] = 0.0;
     }

     if(GetRandomInt(0, 1) == 0) { // TEMPORARY HEALTH BONUS
          g_Effect27_isPersistent = false;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Variant: Max health bonus is \x071BB0F6temporary\x01.", name);
     }
     else { // PERSISTENT
          g_Effect27_isPersistent = true;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Variant: Max health bonus is \x07FF9D05persistent\x01.", name);
     }

     PrintCenterTextAll("Bodycount");
     ShowHintToAllClients("Bodycount\n\nMaximum health is increased by 25 upon killing someone.");
}

public void Event_PlayerUpdate_27_Bodycount(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(g_Effect27_Bodycount[client] > 0) {
          TF2Attrib_SetByName(client, "max health additive bonus", g_Effect27_Bodycount[client] * 25.0);
     }
}

public void Event_PlayerDeath_27_Bodycount(Event event, const char[] name, bool dontBroadcast) {
     int attacker = GetClientOfUserId(event.GetInt("attacker"));
     int killed = GetClientOfUserId(event.GetInt("userid"));

     g_Effect27_Bodycount[attacker]++;
     SetEntityHealth(attacker, GetClientHealth(attacker) + 25);

     if(attacker != killed && attacker > 0 && IsClientInGame(attacker) && IsPlayerAlive(attacker)) {
          TF2Attrib_SetByName(attacker, "max health additive bonus", g_Effect27_Bodycount[attacker] * 25);
     }

     if(!g_Effect27_isPersistent) {
          g_Effect27_Bodycount[killed] = 0.0;
          TF2Attrib_RemoveByName(killed, "max health additive bonus");
     }
}

public void Event_RoundEnd_27_Bodycount(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               TF2Attrib_RemoveByName(i, "max health additive bonus");
          }
     }
}