#pragma semicolon 1

public void Event_RoundStart_7_Swim(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_AddCondition(i, TFCond_SwimmingNoEffects);
          }
     }

     PrintCenterTextAll("Swim");
     ShowHintToAllClients("Swim\n\nSwim like the whole map is underwater.");
}

public void Event_PlayerUpdate_7_Swim(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          DataPack pack = new DataPack();
          pack.WriteCell(client);
          pack.WriteCell(TFCond_SwimmingNoEffects);

          CreateTimer(0.2, Timer_AddCondition, pack);
     }
}

public void Event_RoundEnd_7_Swim(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_RemoveCondition(i, TFCond_SwimmingNoEffects);
          }
     }
}