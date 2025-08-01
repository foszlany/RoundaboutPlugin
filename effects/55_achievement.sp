#pragma semicolon 1

public void Event_RoundStart_55_AchievementHunter(Event event, const char[] name, bool dontBroadcast) {
     HookEvent("achievement_earned", AchievementHunted, EventHookMode_Post);

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_RoundEnd_55_AchievementHunter(Event event, const char[] name, bool dontBroadcast) {    
     UnhookEvent("achievement_earned", AchievementHunted, EventHookMode_Post);
}

public void AchievementHunted(Event event, const char[] name, bool dontBroadcast) {    
     int client = event.GetInt("player");

     PrintToChatAll("\x07B143F1[Roundabout]\x01 %N has obtained an achievement!", client);

     if(IsClientInGame(client) && IsClientInGame(client)) {
          TF2_AddCondition(client, TFCond_Ubercharged, 12.0);
          TF2_AddCondition(client, TFCond_CritOnWin, 12.0);
          TF2_AddCondition(client, TFCond_SpeedBuffAlly, 12.0);
     }
}