#pragma semicolon 1

#define FFADE_STAYOUT 0x0010

public void Event_RoundStart_42_HorrorFortress(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          BlindPlayer(i, 99999999, 251);
     }

     g_Effect42_HorrorTimer = CreateTimer(0.5, BlindPlayerTimer);

     ShowCurrentEffectDescription(-1);
}

public void Event_PlayerUpdate_42_HorrorFortress(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     BlindPlayer(client, 99999999, 250);
}

public void Event_RoundEnd_42_HorrorFortress(Event event, const char[] name, bool dontBroadcast) {
     if(g_Effect42_HorrorTimer != null) {
          KillTimer(g_Effect42_HorrorTimer);
          g_Effect42_HorrorTimer = null;
     }

     for(int i = 1; i <= MaxClients; i++) {
          BlindPlayer(i, 1, 0);
     }
}

Action BlindPlayerTimer(Handle timer) {
     for(int i = 1; i <= MaxClients; i++) {
          BlindPlayer(i, 99999999, 251);
     }

     g_Effect42_HorrorTimer = CreateTimer(16.0, BlindPlayerTimer);
     
     return Plugin_Handled;
}

void BlindPlayer(int client, int hold_time, int alpha) {
     if(IsClientInGame(client) && IsPlayerAlive(client) && !IsFakeClient(client)) {
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