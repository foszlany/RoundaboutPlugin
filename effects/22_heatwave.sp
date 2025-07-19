#pragma semicolon 1

public void Event_RoundStart_22_Heatwave(Event event, const char[] name, bool dontBroadcast) {
     g_Effect22_HeatwaveTimer = CreateTimer(float(GetRandomInt(36, 72)), BurnAll);

     ShowCurrentEffectDescription(-1);
}

public void Event_RoundEnd_22_Heatwave(Event event, const char[] name, bool dontBroadcast) {
     if(g_Effect22_HeatwaveTimer != null) {
          KillTimer(g_Effect22_HeatwaveTimer);
          g_Effect22_HeatwaveTimer = null;
     }
}

public Action BurnAll(Handle timer) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_IgnitePlayer(i, i, 9999.9);
          }
     }

     PrintToChatAll("\x07B143F1[Roundabout]\x01 A \x07FFA500heatwave\x01 has occured.");
     g_Effect22_HeatwaveTimer = CreateTimer(float(GetRandomInt(36, 72)), BurnAll);

     return Plugin_Handled;
}