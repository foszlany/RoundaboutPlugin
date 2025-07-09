#pragma semicolon 1

public void Event_RoundStart_12_RNGDeath(Event event, const char[] name, bool dontBroadcast) {
     PrintCenterTextAll("Spontaneous Combustion");
     ShowHintToAllClients("Spontaneous Combustion\n\nYou have a 1 percent chance of dying each second and a rare 0.01 percent chance of everyone dying.");

     g_Util_OneSecondTimer = CreateTimer(1.0, Executioner, _, TIMER_REPEAT);
}

public void Executioner(Handle timer) {
     if(GetRandomInt(1, 10000) == 1) {
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
               if(IsClientInGame(i) && IsPlayerAlive(i) && GetRandomInt(1, 100) == 1) {
                    char name[33];
                    GetClientName(i, name, sizeof(name));

                    ExplodePlayer(i);

                    PrintToChatAll("\x07B143F1[Roundabout]\x01 %s has spontaneously combusted.", name);
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