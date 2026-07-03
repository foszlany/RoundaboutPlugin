#pragma semicolon 1

#define FFADE_STAYOUT 0x0010

public void Event_RoundStart_42_HorrorFortress(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          E42_ApplyBlindEffects(i, 99999999, 251);
     }

     g_Effect42_HorrorTimer = CreateTimer(0.5, E42_BlindPlayer);
}

public void Event_PlayerUpdate_42_HorrorFortress(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     E42_ApplyBlindEffects(client, 99999999, 251);
}

public void Event_RoundEnd_42_HorrorFortress(Event event, const char[] name, bool dontBroadcast) {
     if(g_Effect42_HorrorTimer != null) {
          KillTimer(g_Effect42_HorrorTimer);
          g_Effect42_HorrorTimer = null;
     }

     for(int i = 1; i <= MaxClients; i++) {
          E42_ApplyBlindEffects(i, 1, 0);
     }
}

public Action E42_BlindPlayer(Handle timer) {
     for(int i = 1; i <= MaxClients; i++) {
          E42_ApplyBlindEffects(i, 99999999, 251);
     }

     g_Effect42_HorrorTimer = CreateTimer(3.0, E42_BlindPlayer);
     
     return Plugin_Handled;
}

public void E42_ApplyBlindEffects(int client, int hold_time, int alpha) {
     if(IsClientInGame(client) && !IsFakeClient(client)) {
          Handle message = StartMessageOne("Fade", client);
          BfWriteShort(message, 99999999);                       // FADE DURATION (MS)
          BfWriteShort(message, hold_time);                      // TIME TO HOLD (MS)
          BfWriteShort(message, FFADE_STAYOUT);                  // FFADE_STAYOUT
          BfWriteByte(message, 0);                               // R
          BfWriteByte(message, 0);                               // G
          BfWriteByte(message, 0);                               // B
          BfWriteByte(message, alpha);                           // A
          EndMessage();
     }
}