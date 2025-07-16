#pragma semicolon 1

#define FFADE_IN 0x0001
#define FFADE_STAYOUT 0x0010

public void Event_RoundStart_42_HorrorFortress(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          BlindPlayer(i, 99999999, 251);
     }

     g_Effect42_HorrorTimer = CreateTimer(40.0, BlindPlayerTimer);

     PrintCenterTextAll("Horror Fortress");
     ShowHintToAllClients("Horror Fortress\n\nEvery copy of Team Fortress 2 is personalized.");
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
          BlindPlayer(i, 99999999, 250);
     }

     g_Effect42_HorrorTimer = CreateTimer(40.0, BlindPlayerTimer);
     
     return Plugin_Handled;
}

void BlindPlayer(int client, int hold_time, int alpha) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          Handle message = StartMessageOne("Fade", client);
          BfWriteShort(message, 1500);                           // FADE DURATION (MS)
          BfWriteShort(message, hold_time);                      // TIME TO HOLD (MS)
          BfWriteShort(message, (FFADE_IN | FFADE_STAYOUT));     // FFADE_IN | FFADE_STAYOUT
          BfWriteByte(message, 0);                               // Red
          BfWriteByte(message, 0);                               // Green
          BfWriteByte(message, 0);                               // Blue
          BfWriteByte(message, alpha);                           // Alpha (0-255)
          EndMessage();
     }
}