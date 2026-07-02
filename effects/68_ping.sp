#pragma semicolon 1

public void Event_RoundStart_68_Ping(Event event, const char[] name, bool dontBroadcast) {
     g_Effect68_PingTimer = CreateTimer(2.0, E68_ApplyPingDamageBonus, _, TIMER_REPEAT);
}

public void Event_RoundEnd_68_Ping(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               TF2Attrib_RemoveByName(i, "damage bonus");
          }
     }

     KillTimer(g_Effect68_PingTimer);
     g_Effect68_PingTimer = null;
}

public Action E68_ApplyPingDamageBonus(Handle timer) {
     if(timer == null) {
          return Plugin_Handled;
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               int ping = GetEntProp(GetPlayerResourceEntity(), Prop_Send, "m_iPing", _, i);
               float multiplier = E68_GetPingDamageMultiplier(ping);
               TF2Attrib_SetByName(i, "damage bonus", multiplier);
          }
     }

     return Plugin_Handled;
}

public float E68_GetPingDamageMultiplier(int ping) {
     if(ping <= 1) {
          ping = 1;
     }
     if(ping > 999) {
          ping = 999;
     }

     float t = float(ping - 1) / 998.0;
     return 0.5 + (t * 4.5);
}