#pragma semicolon 1

#define E46_BUFF_DURATION 8.0
#define E46_COOLDOWN 16.0

public void Event_RoundStart_46_BuffersGambit(Event event, const char[] name, bool dontBroadcast) {
     AddCommandListener(E46_OnBuffActivate, "voicemenu");
     g_Effect46_isCommandListenerRegistered = true;
     SignalCooldown(EFFECT_BUFFERSGAMBIT, 245, 207, 39);
}

public void Event_RoundEnd_46_BuffersGambit(Event event, const char[] name, bool dontBroadcast) {
     if(g_Effect46_isCommandListenerRegistered) {
          RemoveCommandListener(E46_OnBuffActivate, "voicemenu");
          g_Effect46_isCommandListenerRegistered = false;

          for(int i = 1; i <= MaxClients; i++) {
               if(g_Effect46_BuffTimer[i] != null) {
                    KillTimer(g_Effect46_BuffTimer[i]);
                    g_Effect46_BuffTimer[i] = null;
               }
          }
     }
}

public Action E46_OnBuffActivate(client, const String:command[], argc) {
     char arguments[4];
     GetCmdArgString(arguments, sizeof(arguments));

     if(StrEqual(arguments, "0 0") && IsEffectLive(EFFECT_BUFFERSGAMBIT) && g_Effect46_BuffTimer[client] == null && IsClientInGame(client) && IsPlayerAlive(client)) {
          int randVal = GetRandomInt(1, 100);

          if(randVal <= 2) {
               TF2_AddCondition(client, TFCond_Ubercharged, E46_BUFF_DURATION);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x0700EEFFUbercharged\x01");
          }
          else if(randVal <= 5) {
               TF2_AddCondition(client, TFCond_CritOnWin, E46_BUFF_DURATION);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07FF0000Crits\x01");
          }
          else if(randVal <= 10) {
               TF2_AddCondition(client, TFCond_HalloweenGhostMode, E46_BUFF_DURATION);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07CC53FFGhost\x01");
          }
          else if(randVal <= 20) {
               TF2_AddCondition(client, TFCond_DefenseBuffed, E46_BUFF_DURATION);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07797070Defense buff\x01");
          }
          else if(randVal <= 30) {
               TF2_AddCondition(client, TFCond_Buffed, E46_BUFF_DURATION);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07FFD600Mini-crits\x01");
          }
          else if(randVal <= 40) {
               TF2_AddCondition(client, TFCond_SpeedBuffAlly, E46_BUFF_DURATION);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x0700FFFFSpeed buff\x01");
          }
          else if(randVal <= 50) {
               int randResistance = GetRandomInt(1, 3);

               switch(randResistance) {
                    case 1: {
                         TF2_AddCondition(client, TFCond_BulletImmune, E46_BUFF_DURATION);
                         PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07AAAAAABullet Immunity\x01");
                    }
                    case 2: {
                         TF2_AddCondition(client, TFCond_BlastImmune, E46_BUFF_DURATION);
                         PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07FF8000Blast Immunity\x01");
                    }
                    case 3: {
                         TF2_AddCondition(client, TFCond_FireImmune, E46_BUFF_DURATION);
                         PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07FF4500Fire Immunity\x01");
                    }
               }
          }
          else if(randVal <= 63) {
               TF2_StunPlayer(client, E46_BUFF_DURATION, 0.6, TF_STUNFLAG_SLOWDOWN);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07CC53FFSlowed\x01");
          }
          else if(randVal <= 75) {
               TF2_AddCondition(client, TFCond_MarkedForDeath, E46_BUFF_DURATION);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07999999Marked for death\x01");
          }
          else if(randVal <= 85) {
               TF2_IgnitePlayer(client, client, E46_BUFF_DURATION);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07FF6B00Set on Fire\x01");
          }
          else if(randVal <= 91) {
               TF2_AddCondition(client, TFCond_Jarated, E46_BUFF_DURATION);
               TF2_AddCondition(client, TFCond_Bleeding, E46_BUFF_DURATION);
               TF2_AddCondition(client, TFCond_Milked, E46_BUFF_DURATION);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07A020F0Bad Sauce\x01");
          }
          else if(randVal <= 95) {
               TF2_StunPlayer(client, E46_BUFF_DURATION, 1.0, TF_STUNFLAGS_SMALLBONK);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07B7B966Stunned\x01");
          }
          else if(randVal <= 98) {
               SetEntityHealth(client, 1);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07C20000Health reduction to 1\x01");
          }
          else {
               ExplodePlayer(client);
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 Your effect: \x07FF4500Explosion\x01");
          }

          g_Effect46_BuffTimer[client] = CreateTimer(E46_COOLDOWN, E46_ResetCooldown, client);
          AddCooldown(EFFECT_BUFFERSGAMBIT, client, E46_COOLDOWN);

          return Plugin_Handled;
     }

     return Plugin_Continue;
}

public Action E46_ResetCooldown(Handle timer, int client) {
     g_Effect46_BuffTimer[client] = null;
     EmitSoundToClient(client, "player/recharged.wav");
     return Plugin_Handled;
}