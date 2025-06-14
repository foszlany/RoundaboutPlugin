#pragma semicolon 1

public void Event_RoundStart_1_LowGravity(Event event, const char[] name, bool dontBroadcast) {
     int randGravity = GetRandomInt(100, 400);

     ConVar gravity = FindConVar("sv_gravity");

     if(gravity != null) {
          int originalFlags = GetConVarFlags(gravity);
          SetConVarFlags(gravity, originalFlags & ~(FCVAR_NOTIFY|FCVAR_REPLICATED));

          SetConVarInt(gravity, randGravity, true, false);
     }
     else {
          ServerCommand("sm_cvar sv_gravity %d", randGravity);
     }

     PrintCenterTextAll("Low Gravity");
     ShowHintToAllClients("Low Gravity\n\nEnjoy Moon gravity!");
}

public void Event_RoundEnd_1_LowGravity(Event event, const char[] name, bool dontBroadcast) {
     ConVar gravity = FindConVar("sv_gravity");
     if(gravity != null) {
          SetConVarInt(gravity, 800, true, false);
     }
     else {
          ServerCommand("sv_gravity 800");
     }
}