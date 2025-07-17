#pragma semicolon 1

public void Event_RoundStart_47_SkatingRink(Event event, const char[] name, bool dontBroadcast) {
     ConVar friction = FindConVar("sv_friction");
     g_Effect47_OriginalFriction = GetConVarFloat(friction);

     if(friction != null) {
          int originalFlags = GetConVarFlags(friction);
          SetConVarFlags(friction, originalFlags & ~(FCVAR_NOTIFY|FCVAR_REPLICATED));

          SetConVarFloat(friction, 0.1, true, false);
     }
     else {
          ServerCommand("sv_friction 0.1");
     }

     PrintCenterTextAll("Skating Rink");
     ShowHintToAllClients("Skating Rink\n\nSlide around like you're ice skating!");
}

public void Event_RoundEnd_47_SkatingRink(Event event, const char[] name, bool dontBroadcast) {
     ConVar friction = FindConVar("sv_friction");
     if(friction != null) {
          SetConVarFloat(friction, g_Effect47_OriginalFriction, true, false);
     }
     else {
          ServerCommand("sv_gravity %f", g_Effect47_OriginalFriction);
     }
}