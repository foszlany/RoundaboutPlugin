#pragma semicolon 1

public void Event_RoundStart_1_LowGravity(Event event, const char[] name, bool dontBroadcast) {
     int randGravity;
     if(GetRandomInt(0, 100) <= 2) {
          randGravity = 0;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Enjoy zero gravity.", name);
     }
     else {
          randGravity = GetRandomInt(100, 400);
     }

     ConVar gravity = FindConVar("sv_gravity");
     g_Effect1_OriginalGravity = GetConVarInt(gravity);

     if(gravity != null) {
          int originalFlags = GetConVarFlags(gravity);
          SetConVarFlags(gravity, originalFlags & ~(FCVAR_NOTIFY|FCVAR_REPLICATED));

          SetConVarInt(gravity, randGravity, true, false);
     }
     else {
          ServerCommand("sv_gravity %d", randGravity);
     }

     ShowCurrentEffectDescription(-1);
}

public void Event_RoundEnd_1_LowGravity(Event event, const char[] name, bool dontBroadcast) {
     ConVar gravity = FindConVar("sv_gravity");
     if(gravity != null) {
          SetConVarInt(gravity, g_Effect1_OriginalGravity, true, false);
     }
     else {
          ServerCommand("sv_gravity %d", g_Effect1_OriginalGravity);
     }
}