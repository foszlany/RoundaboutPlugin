public void ForceClass(int client, TFClassType class) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          if(TF2_GetPlayerClass(client) != class) {
               TF2_SetPlayerClass(client, class);
               TF2_RegeneratePlayer(client);
          }
     }
}