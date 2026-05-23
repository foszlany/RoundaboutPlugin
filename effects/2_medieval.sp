#pragma semicolon 1

public void Event_RoundStart_2_Medieval(Event event, const char[] name, bool dontBroadcast) {
     GameRules_SetProp("m_bPlayingMedieval", 1);

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_RegeneratePlayer(i);
          }
     }
}

public void Event_RoundEnd_2_Medieval(Event event, const char[] name, bool dontBroadcast) {
     GameRules_SetProp("m_bPlayingMedieval", 0);
}