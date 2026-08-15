#pragma semicolon 1

#define E21_BUFF_DURATION 8.0
#define E21_MIN_ASSIGNMENT_TIMER 20.0
#define E21_MAX_ASSIGNMENT_TIMER 50.0
#define E21_DUEL_TIME 30.0
#define E21_MIN_ASSIGNMENT_REATTEMPT_TIMER 6.0
#define E21_MAX_ASSIGNMENT_REATTEMPT_TIMER 12.0

public void Event_RoundStart_21_Duelies(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MAXPLAYERS; i++) {
          g_Effect21_Duelee[i] = 0;
          g_Effect21_EffectTimer[i] = null;

          if(i <= MaxClients && IsClientInGame(i) && IsPlayerAlive(i)) {
               float duelTime = GetRandomFloat(E21_MIN_ASSIGNMENT_TIMER, E21_MAX_ASSIGNMENT_TIMER);
               g_Effect21_EffectTimer[i] = CreateTimer(duelTime, E21_AssignDuel, i);
          }
     }
}

public void Event_PlayerUpdate_21_Duelies(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(client <= MaxClients && IsClientInGame(client) && IsPlayerAlive(client) && g_Effect21_EffectTimer[client] == null) {
          float duelTime = GetRandomFloat(E21_MIN_ASSIGNMENT_TIMER, E21_MAX_ASSIGNMENT_TIMER);
          g_Effect21_EffectTimer[client] = CreateTimer(duelTime, E21_AssignDuel, client);
     }
}

public void Event_PlayerDeath_21_Duelies(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(attacker != 0 && g_Effect21_Duelee[client] != 0) {
          // DUEL COMPLETED
          if(g_Effect21_Duelee[client] == attacker) {
               ShowSyncHudText(attacker, g_HudSync, "");
               PrintToChatAll("\x07B143F1[Roundabout]\x01 %N duelled %N to the death!", attacker, client);
               TF2_AddCondition(attacker, TFCond_Buffed, E21_BUFF_DURATION);

               float duelTime = GetRandomFloat(E21_MIN_ASSIGNMENT_TIMER, E21_MAX_ASSIGNMENT_TIMER);
               g_Effect21_EffectTimer[attacker] = CreateTimer(duelTime, E21_AssignDuel, attacker);
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
               ShowSyncHudText(g_Effect21_Duelee[client], g_HudSync, "Your duelee has been killed.");
          }

          E21_NullifyClientDuelData(client);
          E21_NullifyClientDuelData(g_Effect21_Duelee[client]);
     }
}

public void Event_RoundEnd_21_Duelies(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          E21_NullifyClientDuelData(i);
     }
}

// ASSIGN DUEL
public Action E21_AssignDuel(Handle timer, int client) {
     int playerCount = CountActivePlayers();

     if(playerCount <= 1) {
          float duelTime = GetRandomFloat(E21_MIN_ASSIGNMENT_TIMER, E21_MAX_ASSIGNMENT_TIMER);
          g_Effect21_EffectTimer[client] = CreateTimer(duelTime, E21_AssignDuel, client);
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
               g_Effect21_EffectTimer[client] = CreateTimer(E21_DUEL_TIME, E21_ExplodeDuelingPlayers, client);

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
               ShowSyncHudText(client, g_HudSync, "You have %d seconds to kill %N!", E21_DUEL_TIME, candidate);
               ShowSyncHudText(candidate, g_HudSync, "You have %d seconds to kill %N!", E21_DUEL_TIME, client);

               char classClient[9];
               GetClassString(TF2_GetPlayerClass(client), classClient, sizeof(classClient));
               char classCandidate[9];
               GetClassString(TF2_GetPlayerClass(candidate), classCandidate, sizeof(classCandidate));

               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your opponent is a(n) \x07FF0000%s\x01.", classCandidate);
               PrintToChat(candidate, "\x07B143F1[Roundabout]\x01 Your opponent is a(n) \x07FF0000%s\x01.", classClient);
               
               return Plugin_Handled;
          }
     }

     float duelReattemptTime = GetRandomFloat(E21_MIN_ASSIGNMENT_REATTEMPT_TIMER, E21_MAX_ASSIGNMENT_REATTEMPT_TIMER);
     g_Effect21_EffectTimer[client] = CreateTimer(duelReattemptTime, E21_AssignDuel, client);
     return Plugin_Handled;
}

// KILL USERS
public Action E21_ExplodeDuelingPlayers(Handle timer, int client1) {
     int client2 = g_Effect21_Duelee[client1];

     if(client2 != 0 && IsClientInGame(client1) && IsPlayerAlive(client1) && IsClientInGame(client2) && IsPlayerAlive(client2)) {
          ExplodePlayer(client1);
          ExplodePlayer(client2);

          PrintToChatAll("\x07B143F1[Roundabout]\x01 %N and %N couldn't find each other!", client1, client2);
     }
     else {
          E21_NullifyClientDuelData(client1);
     }

     return Plugin_Handled;
}

public void E21_NullifyClientDuelData(int client) {
     if(g_Effect21_EffectTimer[client] != null) {
          KillTimer(g_Effect21_EffectTimer[client]);
          g_Effect21_EffectTimer[client] = null;
     }

     int duelee = g_Effect21_Duelee[client];
     g_Effect21_Duelee[client] = 0;
     g_Effect21_Duelee[duelee] = 0;

     if(duelee != 0 && IsClientInGame(duelee)) {
          ShowSyncHudText(client, g_HudSync, "");
     }
     if(client != 0 && IsClientInGame(client)) {
          ShowSyncHudText(client, g_HudSync, "");
     }
}