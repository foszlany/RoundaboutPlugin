#pragma semicolon 1

public void Event_RoundStart_13_Math(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MAXPLAYERS; i++) {
          g_Effect13_MathAnswer[i] = -1;
          g_Effect13_MathQuestionTimers[i] = null;

          if(i <= MaxClients && IsClientInGame(i) && IsPlayerAlive(i) && !IsFakeClient(i)) {
               g_Effect13_MathQuestionTimers[i] = CreateTimer(float(GetRandomInt(12, 36)), GiveMathProblem, i);
          }
     }
     
	AddCommandListener(Event_ChatMessage, "say");
	AddCommandListener(Event_ChatMessage, "say_team");
     
     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_13_Math(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(client <= MaxClients && IsClientInGame(client) && IsPlayerAlive(client) && !IsFakeClient(client) && g_Effect13_MathQuestionTimers[client] == null) {
          g_Effect13_MathQuestionTimers[client] = CreateTimer(float(GetRandomInt(12, 36)), GiveMathProblem, client);
     }
}

public void Event_PlayerDeath_13_Math(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     NullifyClientMathData(client);
}

public void Event_RoundEnd_13_Math(Event event, const char[] name, bool dontBroadcast) {
	RemoveCommandListener(Event_ChatMessage, "say");
	RemoveCommandListener(Event_ChatMessage, "say_team");

     for(int i = 1; i <= MAXPLAYERS; i++) {
          NullifyClientMathData(i);
     }
}

// CHAT MESSAGE EVENT
public Action Event_ChatMessage(int client, const char[] command, int argc) {
     if(g_CurrentEffect == EFFECT_MATH) {
          if(g_Effect13_MathQuestionTimers[client] != null && g_Effect13_MathAnswer[client] != -1) {
               checkMathResponse(client, command, argc);
               return Plugin_Handled;
          }
     }

    return Plugin_Continue;
}

// GIVE A CUSTOM MATH PROBLEM
public void GiveMathProblem(Handle timer, int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          float kills = float(GetClientFrags(client));
          float deaths = GetClientDeaths(client) == 0 ? 1.0 : float(GetClientDeaths(client));
          int extra = RoundToNearest(200.0 * kills / deaths);

          int randomA = GetRandomInt(1, 50 + extra);
          int randomB = GetRandomInt(1, 50 + extra);

          SetHudTextParams(
               -1.0,
               0.2,
               8.0,
               255,
               GetRandomInt(0, 255),
               GetRandomInt(0, 255),
               GetRandomInt(0, 255),
               0,
               2.0
          );
          ShowSyncHudText(client, g_hudSync, "%d + %d = ?", randomA, randomB);

          g_Effect13_MathAnswer[client] = randomA + randomB;

          g_Effect13_MathQuestionTimers[client] = CreateTimer(8.0, MathExplode, client);
     }
     else {
          NullifyClientMathData(client);
     }
}

// HANDLE CHAT MESSAGES
public void checkMathResponse(int client, const char[] command, int argc) {
     if(g_Effect13_MathQuestionTimers[client] != null && g_Effect13_MathAnswer[client] != -1) {
          char message[128];
          GetCmdArg(1, message, sizeof(message));

          int providedAnswer;
          int parseCount = StringToIntEx(message, providedAnswer);
		if(parseCount <= 0 || parseCount != strlen(message)) {
			return;
		}

          if(providedAnswer != g_Effect13_MathAnswer[client]) {
               ExplodePlayer(client);

               PrintToChatAll("\x07B143F1[Roundabout]\x01 %N can't add two numbers together.", client);
               NullifyClientMathData(client);
          }
          else {
               ShowSyncHudText(client, g_hudSync, "");

               int randomReassuranceTextIndex = GetRandomInt(0, 6);
               switch(randomReassuranceTextIndex) {
                    case 0: {
                         PrintCenterText(client, "Good job!");
                    }
                    case 1: {
                         PrintCenterText(client, "Splendid!");
                    }
                    case 2: {
                         PrintCenterText(client, "Well done!");
                    }
                    case 3: {
                         PrintCenterText(client, "You're slayin' it!");
                    }
                    case 4: {
                         PrintCenterText(client, "Phenomenal!");
                    }
                    case 5: {
                         PrintCenterText(client, "Beautifully done!");
                    }
                    case 6: {
                         if(g_Effect13_MathAnswer[client] >= 1750) {
                              PrintCenterText(client, "Are you using a calculator?");
                         }
                         else {
                              PrintCenterText(client, "You nailed it!");
                         }
                    }
               }
               NullifyClientMathData(client);

               g_Effect13_MathQuestionTimers[client] = CreateTimer(float(GetRandomInt(12, 36)), GiveMathProblem, client);
          }
     }
}

// KILL USER
public void MathExplode(Handle timer, int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          ExplodePlayer(client);

          PrintToChatAll("\x07B143F1[Roundabout]\x01 %N skipped their math class.", client);
     }
     else {
          NullifyClientMathData(client);
     }
}

public void NullifyClientMathData(int client) {
     if(g_Effect13_MathQuestionTimers[client] != null) {
          KillTimer(g_Effect13_MathQuestionTimers[client]);
          g_Effect13_MathQuestionTimers[client] = null;

          if(g_Effect13_MathAnswer[client] != -1) {
               g_Effect13_MathAnswer[client] = -1;
               ShowSyncHudText(client, g_hudSync, "");
          }
     }
}