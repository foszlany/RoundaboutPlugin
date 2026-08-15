#pragma semicolon 1

#define E12_PLAYER_MAX_ROLL 100
#define E12_SERVER_MAX_ROLL 10000

public void Event_RoundStart_12_RNGDeath(Event event, const char[] name, bool dontBroadcast) {
     g_Util_OneSecondTimer = CreateTimer(1.0, E12_Executioner, _, TIMER_REPEAT);
}

public void E12_Executioner(Handle timer) {
     if(GetRandomInt(1, E12_SERVER_MAX_ROLL) == 1) {
          PrintToChatAll("\x07FFE800[Roundabout]\x01 \x07B143F1Everyone\x01 has spontaneously combusted!");
          EmitSoundToAll("weapons/explode3.wav");

          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i) && IsPlayerAlive(i)) {
                    FakeClientCommand(i, "explode");
               }
          }
     }
     else {
          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i) && IsPlayerAlive(i) && GetRandomInt(1, E12_PLAYER_MAX_ROLL) == 1) {
                    ExplodePlayer(i);

                    PrintToChatAll("\x07B143F1[Roundabout]\x01 %N has spontaneously combusted.", i);
               }
          }
     }
}

public void Event_RoundEnd_12_RNGDeath(Event event, const char[] name, bool dontBroadcast) {
     if(g_Util_OneSecondTimer != null) {
          KillTimer(g_Util_OneSecondTimer);
          g_Util_OneSecondTimer = null;
     }
}