#pragma semicolon 1

public void Event_RoundStart_11_Schadenfreude(Event event, const char[] name, bool dontBroadcast) {
     ShowCurrentEffectDescription(-1);
}

public void Event_PlayerDeath_11_Schadenfreude(Event event, const char[] name, bool dontBroadcast) {
     if(GetRandomInt(0, 100) <= 33) {
          int attacker = GetClientOfUserId(event.GetInt("attacker"));
          if(IsClientInGame(attacker) && IsPlayerAlive(attacker)) {
               FakeClientCommand(attacker, "taunt");
          }
     }
}