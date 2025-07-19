#pragma semicolon 1

public void Event_RoundStart_21_Duelies(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MAXPLAYERS; i++) {
          g_Effect21_Duelee[i] = 0;
          g_Effect21_EffectTimer[i] = null;

          if(i <= MaxClients && IsClientInGame(i) && IsPlayerAlive(i)) {
               g_Effect21_EffectTimer[i] = CreateTimer(float(GetRandomInt(20, 50)), AssignDuel, i);
          }
     }
     
     ShowCurrentEffectDescription(-1);
}

public void Event_PlayerUpdate_21_Duelies(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(client <= MaxClients && IsClientInGame(client) && IsPlayerAlive(client) && g_Effect21_EffectTimer[client] == null) {
          g_Effect21_EffectTimer[client] = CreateTimer(float(GetRandomInt(20, 50)), AssignDuel, client);
     }
}

public void Event_PlayerDeath_21_Duelies(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(attacker != 0 && g_Effect21_Duelee[client] != 0) {
          // DUEL COMPLETED
          if(g_Effect21_Duelee[client] == attacker) {
               ShowSyncHudText(attacker, g_hudSync, "");
               PrintToChatAll("\x07B143F1[Roundabout]\x01 %N duelled %N to the death!", attacker, client);
               TF2_AddCondition(attacker, TFCond_Buffed, 8.0);

               g_Effect21_EffectTimer[attacker] = CreateTimer(float(GetRandomInt(20, 46)), AssignDuel, attacker);
          }
          else {
               SetHudTextParams(
                    -1.0,
                    0.2,
                    4.0,
                    255,
                    0,
                    0,
                    1,
                    0,
                    2.0
               );
               ShowSyncHudText(g_Effect21_Duelee[client], g_hudSync, "Your duelee has been killed.");
          }

          NullifyClientDuelData(client);
          NullifyClientDuelData(g_Effect21_Duelee[client]);
     }
}

public void Event_RoundEnd_21_Duelies(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          NullifyClientDuelData(i);
     }
}

// ASSIGN DUEL
public Action AssignDuel(Handle timer, int client) {
     int playerCount = CountActivePlayers();

     if(playerCount <= 1) {
          g_Effect21_EffectTimer[client] = CreateTimer(GetRandomFloat(20.0, 50.0), AssignDuel, client);
          return Plugin_Handled;
     }

     // ATTEMPT TO FIND A DUEL PARTNER MAX 10 TIMES
     // REATTEMPT AFTER 10 TRIES
     for(int i = 1; i <= (playerCount <= 10 ? (playerCount + 2) : 10); i++) {
          int candidate = GetRandomInt(1, MaxClients);

          if(candidate != client && g_Effect21_EffectTimer[candidate] != null && g_Effect21_Duelee[candidate] == 0 && IsClientInGame(candidate) && IsPlayerAlive(candidate) && IsOpposingTeam(client, candidate)) {
               g_Effect21_Duelee[client] = candidate;
               g_Effect21_Duelee[candidate] = client;

               // USE ONE TIMER
               g_Effect21_EffectTimer[client] = CreateTimer(30.0, ExplodeDuelingPlayers, client);

               if(g_Effect21_EffectTimer[candidate] != null) {
                    KillTimer(g_Effect21_EffectTimer[candidate]);
                    g_Effect21_EffectTimer[candidate] = null;
               }
               
               SetHudTextParams(
                    -1.0,
                    0.2,
                    30.0,
                    255,
                    255,
                    255,
                    1,
                    0,
                    2.0
               );
               ShowSyncHudText(client, g_hudSync, "You have 30 seconds to kill %N!", candidate);
               ShowSyncHudText(candidate, g_hudSync, "You have 30 seconds to kill %N!", client);

               char classClient[9];
               GetClassString(TF2_GetPlayerClass(client), classClient, sizeof(classClient));
               char classCandidate[9];
               GetClassString(TF2_GetPlayerClass(candidate), classCandidate, sizeof(classCandidate));

               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your opponent is a(n) \x07FF0000%s\x01.", classCandidate);
               PrintToChat(candidate, "\x07B143F1[Roundabout]\x01 Your opponent is a(n) \x07FF0000%s\x01.", classClient);
               
               return Plugin_Handled;
          }
     }

     g_Effect21_EffectTimer[client] = CreateTimer(float(GetRandomInt(6, 12)), AssignDuel, client);
     return Plugin_Handled;
}

// KILL USERS
public Action ExplodeDuelingPlayers(Handle timer, int client1) {
     int client2 = g_Effect21_Duelee[client1];

     if(client2 != 0 && IsClientInGame(client1) && IsPlayerAlive(client1) && IsClientInGame(client2) && IsPlayerAlive(client2)) {
          ExplodePlayer(client1);
          ExplodePlayer(client2);

          PrintToChatAll("\x07B143F1[Roundabout]\x01 %N and %N couldn't find each other!", client1, client2);
     }
     else {
          NullifyClientDuelData(client1);
     }

     return Plugin_Handled;
}

public void NullifyClientDuelData(int client) {
     if(g_Effect21_EffectTimer[client] != null) {
          KillTimer(g_Effect21_EffectTimer[client]);
          g_Effect21_EffectTimer[client] = null;
     }

     int duelee = g_Effect21_Duelee[client];
     g_Effect21_Duelee[client] = 0;
     g_Effect21_Duelee[duelee] = 0;

     if(duelee != 0 && IsClientInGame(duelee)) {
          ShowSyncHudText(client, g_hudSync, "");
     }
     if(client != 0 && IsClientInGame(client)) {
          ShowSyncHudText(client, g_hudSync, "");
     }
}