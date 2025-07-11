#pragma semicolon 1

public void Event_RoundStart_28_Small(Event event, const char[] name, bool dontBroadcast) {
     if(GetRandomInt(0, 100) <= 5) {
          g_Effect28_SizeMultiplier = 0.15;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Size multiplier is only 0.15!", name);
     }
     else {
          g_Effect28_SizeMultiplier = GetRandomFloat(0.35, 0.7);
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               SetEntPropFloat(i, Prop_Send, "m_flModelScale", g_Effect28_SizeMultiplier);
          }
     }

     PrintCenterTextAll("Small");
     ShowHintToAllClients("Small\n\nReduced size for everyone.");
}

public void Event_PlayerUpdate_28_Small(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     SetEntPropFloat(client, Prop_Send, "m_flModelScale", g_Effect28_SizeMultiplier);
}

public void Event_RoundEnd_28_Small(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               SetEntPropFloat(i, Prop_Send, "m_flModelScale", 1.0);
          }
     }
}