public int CountActivePlayers() {
     int count = 0;

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               count++;
          }
     }

     return count;
}