#pragma semicolon 1

public void Event_RoundStart_62_Grapple(Event event, const char[] name, bool dontBroadcast) {
     ConVar g_Cvar_GrapplingHook = FindConVar("tf_grapplinghook_enable");
     SetConVarBool(g_Cvar_GrapplingHook, true);

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_RegeneratePlayer(i);
          }
     }
}

public void Event_RoundEnd_62_Grapple(Event event, const char[] name, bool dontBroadcast) {
     ConVar g_Cvar_GrapplingHook = FindConVar("tf_grapplinghook_enable");
     SetConVarBool(g_Cvar_GrapplingHook, false);

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_RegeneratePlayer(i);
          }
     }
}