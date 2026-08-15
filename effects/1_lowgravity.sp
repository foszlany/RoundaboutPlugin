#pragma semicolon 1

#define E1_BASE_MIN_GRAVITY 100
#define E1_BASE_MAX_GRAVITY 400
#define E1_RARE_CHANCE 2
#define E1_RARE_GRAVITY 5

public void Event_RoundStart_1_LowGravity(Event event, const char[] name, bool dontBroadcast) {
     int randGravity;
     if(IsRareEffectForced(EFFECT_LOWGRAVITY) || GetRandomInt(0, 100) <= E1_RARE_CHANCE) {
          randGravity = E1_RARE_GRAVITY;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Enjoy zero gravity.");
     }
     else {
          randGravity = GetRandomInt(E1_BASE_MIN_GRAVITY, E1_BASE_MAX_GRAVITY);
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