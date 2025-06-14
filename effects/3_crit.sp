#pragma semicolon 1

public void Event_RoundStart_3_Crit(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_AddCondition(i, TFCond_CritOnWin);
          }
     }

     PrintCenterTextAll("Criticals");
     ShowHintToAllClients("Criticals\n\nGuaranteed critical hits.");
}

public void Event_PlayerUpdate_3_Crit(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          DataPack pack = new DataPack();
          pack.WriteCell(client);
          pack.WriteCell(TFCond_CritOnWin);

          CreateTimer(0.2, Timer_AddCondition, pack);
     }
}

public void Event_RoundEnd_3_Crit(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_RemoveCondition(i, TFCond_CritOnWin);
          }
     }
}