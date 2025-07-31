#pragma semicolon 1

public void Event_RoundStart_11_Schadenfreude(Event event, const char[] name, bool dontBroadcast) {
     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerDeath_11_Schadenfreude(Event event, const char[] name, bool dontBroadcast) {
     if(GetRandomInt(0, 100) <= 33) {
          int attacker = GetClientOfUserId(event.GetInt("attacker"));
          AttemptForceTaunt(attacker);
     }
}

public Action ForceTauntTimer(Handle timer, int client) {
     AttemptForceTaunt(client);

     return Plugin_Handled;
}

public void AttemptForceTaunt(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          int flags = GetEntityFlags(client);

          if((flags & FL_ONGROUND) == 0) {
               CreateTimer(0.08, ForceTauntTimer, client);
          }
          else {
               FakeClientCommand(client, "taunt");
          }
     }
}