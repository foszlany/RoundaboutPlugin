#pragma semicolon 1

public Action Timer_AddCondition(Handle timer, DataPack pack) {
     pack.Reset();
     int client = pack.ReadCell();
     TFCond condition = pack.ReadCell();
     delete pack;

     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          TF2_AddCondition(client, condition);
     }

     return Plugin_Handled;
}