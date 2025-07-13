public float CalculateDistance(int client1, int client2) {
     if(!(IsClientConnected(client1) && IsClientConnected(client2) && IsPlayerAlive(client1) && IsPlayerAlive(client2) && client1 != client2)) {
          return -1.0;
     }

     float pos1[3], pos2[3];
     GetClientAbsOrigin(client1, pos1);
     GetClientAbsOrigin(client2, pos2);

     return GetVectorDistance(pos1, pos2);
}