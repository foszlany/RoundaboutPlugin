public void ApplyPowerplay(int client, float duration) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          TF2_AddCondition(client, TFCond_Ubercharged, duration);
          TF2_AddCondition(client, TFCond_CritOnWin, duration);
          TF2_AddCondition(client, TFCond_SpeedBuffAlly, duration);
     }
}