#pragma semicolon 1

#define E22_MIN_BURN_TIMER 36.0
#define E22_MAX_BURN_TIMER 72.0

public void Event_RoundStart_22_Heatwave(Event event, const char[] name, bool dontBroadcast) {
     float burnTime = GetRandomFloat(E22_MIN_BURN_TIMER, E22_MAX_BURN_TIMER);
     g_Effect22_HeatwaveTimer = CreateTimer(burnTime, E22_BurnAll);
}

public void Event_RoundEnd_22_Heatwave(Event event, const char[] name, bool dontBroadcast) {
     if(g_Effect22_HeatwaveTimer != null) {
          KillTimer(g_Effect22_HeatwaveTimer);
          g_Effect22_HeatwaveTimer = null;
     }
}

public Action E22_BurnAll(Handle timer) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_IgnitePlayer(i, i, 9999.9);
          }
     }

     PrintToChatAll("\x07B143F1[Roundabout]\x01 A \x07FFA500heatwave\x01 has occured.");
     float burnTime = GetRandomFloat(E22_MIN_BURN_TIMER, E22_MAX_BURN_TIMER);
     g_Effect22_HeatwaveTimer = CreateTimer(burnTime, E22_BurnAll);

     return Plugin_Handled;
}