void ShowHintToAllClients(const char[] message, float delay = 0.4) {
     DataPack pack = new DataPack();
     pack.WriteString(message);
     
     CreateTimer(delay, Timer_HintBroadcast, pack, TIMER_FLAG_NO_MAPCHANGE);
}

public Action Timer_HintBroadcast(Handle timer, DataPack pack) {
     pack.Reset();
     char message[256];
     pack.ReadString(message, sizeof(message));
     delete pack;

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && !IsFakeClient(i)) {
               PrintHintText(i, message);
          }
     }
     return Plugin_Handled;
}