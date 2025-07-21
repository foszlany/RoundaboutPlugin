#pragma semicolon 1

void ShowHintToClient(int client, const char[] message, float delay = 0.2) {
     DataPack pack = new DataPack();
     pack.WriteString(message);
     pack.WriteCell(client);
     
     CreateTimer(delay, Timer_HintBroadcast, pack, TIMER_FLAG_NO_MAPCHANGE);
}

public Action Timer_HintBroadcast(Handle timer, DataPack pack) {
     pack.Reset();
     char message[256];
     pack.ReadString(message, sizeof(message));

     int client = pack.ReadCell();
     delete pack;

     if(IsClientInGame(client)) {
          PrintHintText(client, message);
     }
     return Plugin_Handled;
}