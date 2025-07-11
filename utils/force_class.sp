public void forceClass(int client, TFClass class) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          if(TF2_GetPlayerClass(client) != class) {
               TF2_SetPlayerClass(client, class, false);
               TF2_RegeneratePlayer(client);
          }
     }
}