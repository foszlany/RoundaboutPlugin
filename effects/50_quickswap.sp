#pragma semicolon 1

#define E50_MINTIME 3.0
#define E50_MAXTIME 7.0
#define E50_ROUNDSTARTGRACEPERIOD 25.0
#define E50_PLAYERGRACEPERIOD 15.0

public void Event_RoundStart_50_Quickswap(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MAXPLAYERS; i++) {
          g_Effect50_PlayersReadyToBeSwapped[i] = true;
     }

     g_Effect50_SwapTimer = CreateTimer(E50_PLAYERGRACEPERIOD, SwapPlayers);

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_RoundEnd_50_Quickswap(Event event, const char[] name, bool dontBroadcast) {
     if(g_Effect50_SwapTimer != null) {
          KillTimer(g_Effect50_SwapTimer);
          g_Effect50_SwapTimer = null;
     }
}

public Action SwapPlayers(Handle timer, int client) {
     int playerCount = CountActivePlayers();

     if(playerCount <= 1) {
          g_Effect50_SwapTimer = CreateTimer(GetRandomFloat(E50_MINTIME, E50_MAXTIME), SwapPlayers, client);
     }

     int client1 = FindSwapCandidate(playerCount);
     int client2 = FindSwapCandidate(playerCount);

     if(client1 == 0 || client2 == 0 || client1 == client2) {
          g_Effect50_SwapTimer = CreateTimer(GetRandomFloat(E50_MINTIME, E50_MAXTIME), SwapPlayers, client);
          return Plugin_Handled;
     }

     // FOUND CANDIDATE
     float origin1[3];
     float angles1[3];
     GetClientAbsOrigin(client1, origin1);
     GetClientEyeAngles(client1, angles1);

     float origin2[3];
     float angles2[3];
     GetClientAbsOrigin(client2, origin2);
     GetClientEyeAngles(client2, angles2);

     TeleportEntity(client1, origin2, angles2, NULL_VECTOR);
     TeleportEntity(client2, origin1, angles1, NULL_VECTOR);

     g_Effect50_PlayersReadyToBeSwapped[client1] = false;
     g_Effect50_PlayersReadyToBeSwapped[client2] = false;
     CreateTimer(E50_PLAYERGRACEPERIOD, ReadyPlayerForSwap, client1);
     CreateTimer(E50_PLAYERGRACEPERIOD, ReadyPlayerForSwap, client2);

     g_Effect50_SwapTimer = CreateTimer(GetRandomFloat(E50_MINTIME, E50_MAXTIME), SwapPlayers, client);

     EmitAmbientSound("misc/halloween/spell_teleport.wav", origin1);
     EmitAmbientSound("misc/halloween/spell_teleport.wav", origin2);
     CreateTeleportParticle(client1, TF2_GetClientTeam(client1) == TFTeam_Red ? "spell_cast_wheel_red" : "spell_cast_wheel_blue", 0.5);
     CreateTeleportParticle(client2, TF2_GetClientTeam(client2) == TFTeam_Red ? "spell_cast_wheel_red" : "spell_cast_wheel_blue", 0.5);

     return Plugin_Handled;
}

public int FindSwapCandidate(int playerCount) {
     int client = 0;

     for(int i = 1; i <= (playerCount <= 10 ? (playerCount + 2) : 10); i++) {
          client = GetRandomInt(1, MaxClients);

          if(IsClientInGame(client) && IsPlayerAlive(client) && g_Effect50_PlayersReadyToBeSwapped[client]) {
               return client;
          }
          else {
               client = 0;
          }
     }

     return 0;
}

public Action ReadyPlayerForSwap(Handle timer, int client) {
     g_Effect50_PlayersReadyToBeSwapped[client] = true;

     return Plugin_Handled;
}