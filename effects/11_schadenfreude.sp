#pragma semicolon 1

#define E11_BASE_LAUGH_CHANCE 33
#define E11_RARE_CHANCE 2
#define E11_RARE_LAUGH_CHANCE 100

public void Event_RoundStart_11_Schadenfreude(Event event, const char[] name, bool dontBroadcast) {
     if(IsRareEffectForced(EFFECT_SCHADENFREUDE) || GetRandomInt(0, 100) <= E11_RARE_CHANCE) {
          g_Effect11_IsSpecialRound = true;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Laughter is guaranteed.");
     }
     else {
          g_Effect11_IsSpecialRound = false;
     }
}

public void Event_PlayerDeath_11_Schadenfreude(Event event, const char[] name, bool dontBroadcast) {
     if(GetRandomInt(0, 100) <= (g_Effect11_IsSpecialRound ? E11_RARE_LAUGH_CHANCE : E11_BASE_LAUGH_CHANCE)) {
          int attacker = GetClientOfUserId(event.GetInt("attacker"));
          if(attacker != 0) {
               E11_AttemptForceTaunt(attacker);
          }
     }
}

public Action E11_ForceTauntTimer(Handle timer, int client) {
     E11_AttemptForceTaunt(client);

     return Plugin_Handled;
}

public void E11_AttemptForceTaunt(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client) && client != 0) {
          int flags = GetEntityFlags(client);

          if((flags & FL_ONGROUND) == 0) {
               CreateTimer(0.08, E11_ForceTauntTimer, client);
          }
          else {
               FakeClientCommand(client, "taunt");
          }
     }
}