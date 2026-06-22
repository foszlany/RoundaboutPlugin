#pragma semicolon 1

public void Event_RoundStart_62_Grapple(Event event, const char[] name, bool dontBroadcast) {
     ConVar grapplingHook = FindConVar("tf_grapplinghook_enable");
     SetConVarBool(grapplingHook, true);

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_RegeneratePlayer(i);
          }
     }
}

public void Event_RoundEnd_62_Grapple(Event event, const char[] name, bool dontBroadcast) {
     ConVar grapplingHook = FindConVar("tf_grapplinghook_enable");
     SetConVarBool(grapplingHook, false);

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_RegeneratePlayer(i);
          }
     }
}