#pragma semicolon 1

public void Event_RoundStart_13_Math(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MAXPLAYERS; i++) {
          g_Effect13_MathAnswer[i] = -1;
          g_Effect13_MathTimers[i] = null;
     }
     PrintCenterTextAll("Perfect Math Class");
     ShowHintToAllClients("Perfect Math Class\n\nYou sometimes receive a math question. Answer within 8 seconds or die.");
}

public void Event_PlayerUpdate_13_Math(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i) && g_Effect13_MathAnswer[i] == -1) {
               float kills = float(GetClientFrags(i));
               float deaths = GetClientDeaths(i) == 0 ? 1.0 : float(GetClientDeaths(i));
               int extra = RoundToNearest(200.0 * kills / deaths);

               int randomA = GetRandomInt(1, 50 + extra);
               int randomB = GetRandomInt(1, 50 + extra);

               PrintCenterText(i, "%d + %d = ?", randomA, randomB);

               g_Effect13_MathAnswer[i] = randomA + randomB;

               g_Effect13_MathTimers[i] = CreateTimer(float(GetRandomInt(16, 42)), MathExplode, i);
          }
     }
}

public void Event_PlayerDeath_13_Math(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     g_Effect13_MathAnswer[client] = -1;

     if(g_Effect13_MathTimers[client] != null) {
          KillTimer(g_Effect13_MathTimers[client]);
          g_Effect13_MathTimers[client] = null;
     }
}

public void MathExplode(Handle timer, int client) {
     if(IsClientInGame(i) && IsPlayerAlive(i)) {
          char name[33];
          GetClientName(client, name, sizeof(name));

          FakeClientCommand(client, "explode");
          EmitSoundToClient(client, "weapons/explode3.wav");

          PrintToChatAll("\x07B143F1[Roundabout]\x01 %s skipped their math class.", name);
     }
     else {
          KillTimer(g_Effect13_MathTimers[client]);
          g_Effect13_MathTimers[client] = null;
     }
}