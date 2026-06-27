#pragma semicolon 1

public void Event_RoundStart_11_Schadenfreude(Event event, const char[] name, bool dontBroadcast) {
     if(IsRareEffectForced(EFFECT_SCHADENFREUDE) || GetRandomInt(0, 100) <= 2) {
          g_Effect11_IsSpecialRound = true;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Melee hits instakill.");
     }
     else {
          g_Effect11_IsSpecialRound = false;
     }
}

public void Event_PlayerDeath_11_Schadenfreude(Event event, const char[] name, bool dontBroadcast) {
     if(GetRandomInt(0, 100) <= (g_Effect11_IsSpecialRound ? 100 : 33)) {
          int attacker = GetClientOfUserId(event.GetInt("attacker"));
          if(attacker != 0) {
               AttemptForceTaunt(attacker);
          }
     }
}

public Action ForceTauntTimer(Handle timer, int client) {
     AttemptForceTaunt(client);

     return Plugin_Handled;
}

public void AttemptForceTaunt(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client) && client != 0) {
          int flags = GetEntityFlags(client);

          if((flags & FL_ONGROUND) == 0) {
               CreateTimer(0.08, ForceTauntTimer, client);
          }
          else {
               FakeClientCommand(client, "taunt");
          }
     }
}