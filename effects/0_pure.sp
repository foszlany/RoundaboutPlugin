#pragma semicolon 1

public void Event_RoundStart_0_Pure(Event event, const char[] name, bool dontBroadcast) {
     g_Effect0_FakePure_Timer = null;

     if(GetRandomInt(1, 10) <= 10) { // change
          g_Effect0_FakePure_Timer = CreateTimer(GetRandomFloat(10.0, 25.0), FakePureEvent);
     }

     g_Effect0_FakePure_IsActive = false;

     PrintCenterTextAll("Pure");
     ShowHintToAllClients("Pure\n\nThe vanilla TF2 experience we all love.");
     return;
}

public void Event_PlayerUpdate_0_Pure(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(g_Effect0_FakePure_IsActive) {
          CreateTimer(0.2, StunPlayerTimer, client);
     }
}

public void Event_RoundEnd_0_Pure(Event event, const char[] name, bool dontBroadcast) {
     if(g_Effect0_FakePure_Timer != null) {
          KillTimer(g_Effect0_FakePure_Timer);
          g_Effect0_FakePure_Timer = null;
     }
}

public void StunPlayerTimer(Handle timer, int client) {
     if(g_Effect0_FakePure_IsActive && IsClientInGame(client) && IsPlayerAlive(client)) {
          TF2_StunPlayer(client, 13.0, 1.0, TF_STUNFLAG_LIMITMOVEMENT | TF_STUNFLAG_SLOWDOWN);
          TF2_RemoveAllWeapons(client);
     }
}

public void FakePureEvent(Handle timer) {
     g_Effect0_FakePure_IsActive = true;

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_StunPlayer(i, 13.0, 1.0, TF_STUNFLAG_LIMITMOVEMENT | TF_STUNFLAG_SLOWDOWN);
               TF2_RemoveAllWeapons(i);
          }
     }

     for(int i = 0; i < 3; i++) {
          PrintToChatAll("\x078D8D8Dthe fog is coming...\x01");
          EmitSoundToAll("player/taunt_scorchers_solo2.wav");
     }

     CreateTimer(12.0, ExplodeAll);
}

public void ExplodeAll(Handle timer) {
     EmitSoundToAll("weapons/explode3.wav");

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               FakeClientCommand(i, "explode");
          }
     }

     g_Effect0_FakePure_IsActive = false;
}
