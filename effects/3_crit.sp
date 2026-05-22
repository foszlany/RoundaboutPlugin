#pragma semicolon 1

public void Event_RoundStart_3_Crit(Event event, const char[] name, bool dontBroadcast) {
     g_Effect3_CritType = GetRandomInt(0, 1) ? TFCond_CritCola : TFCond_CritOnWin;

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_AddCondition(i, g_Effect3_CritType);
          }
     }

     if(g_Effect3_CritType == TFCond_CritCola) {
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Variant: Crit type is \x07FFE65BMini-crits\x01.");
     }
     else {
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Variant: Crit type is \x07CC2300Crits\x01.");
     }
     
     
     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_3_Crit(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          DataPack pack = new DataPack();
          pack.WriteCell(client);
          pack.WriteCell(g_Effect3_CritType);

          CreateTimer(0.2, Timer_AddCondition, pack);
     }
}

public void Event_RoundEnd_3_Crit(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_RemoveCondition(i, g_Effect3_CritType);
          }
     }
}