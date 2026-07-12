#pragma semicolon 1

#define E28_RARE_CHANCE 5
#define E28_RARE_SIZE_MULTIPLIER 0.15
#define E28_MIN_SIZE_MULTIPLIER 0.35
#define E28_MAX_SIZE_MULTIPLIER 0.7
#define E28_VOICE_PITCH_MULTIPLIER 1.4

public void Event_RoundStart_28_Small(Event event, const char[] name, bool dontBroadcast) {
     if(IsRareEffectForced(EFFECT_SMALL) || GetRandomInt(0, 100) <= E28_RARE_CHANCE) {
          g_Effect28_SizeMultiplier = E28_RARE_SIZE_MULTIPLIER;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Size multiplier is only %.2f!", E28_RARE_SIZE_MULTIPLIER);
     }
     else {
          g_Effect28_SizeMultiplier = GetRandomFloat(E28_MIN_SIZE_MULTIPLIER, E28_MAX_SIZE_MULTIPLIER);
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               SetEntPropFloat(i, Prop_Send, "m_flModelScale", g_Effect28_SizeMultiplier);
               TF2Attrib_SetByName(i, "voice pitch scale", E28_VOICE_PITCH_MULTIPLIER);
          }
     }
}

public void Event_PlayerUpdate_28_Small(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     SetEntPropFloat(client, Prop_Send, "m_flModelScale", g_Effect28_SizeMultiplier);
     TF2Attrib_SetByName(client, "voice pitch scale", E28_VOICE_PITCH_MULTIPLIER);
}

public void Event_RoundEnd_28_Small(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               SetEntPropFloat(i, Prop_Send, "m_flModelScale", 1.0);
               TF2Attrib_RemoveByName(i, "voice pitch scale");
          }
     }
}