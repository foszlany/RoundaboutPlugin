#pragma semicolon 1

public void Event_RoundStart_16_Rolemodel(Event event, const char[] name, bool dontBroadcast) {
     // ASSIGN INITIAL CLASSES (MAY CHANGE IF EFFECT IS COMPETITIVE)
     for(int i = 1; i <= MAXPLAYERS; i++) {
          // CONNECTING PLAYERS WILL RECEIVE THE SAME INDEX, BUT IT SHOULDN'T MATTER
          g_Effect16_AssignedClass[i] = GetRandomInt(1, 9);
     }


     int activePlayers = CountActivePlayers();

     if(GetRandomInt(1, 100) <= 33 && (activePlayers == 4 || activePlayers == 8 || activePlayers == 12 || activePlayers == 18)) {
          ArrayList bluClasses = new ArrayList();
          ArrayList redClasses = new ArrayList();

          // CHECK IF TEAMS ARE UNBALANCED
          int redCount = 0;
          int bluCount = 0;
          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i)) {
                    if(TF2_GetClientTeam(i) == TFTeam_Red) {
                         redCount++;
                    }
                    else if(TF2_GetClientTeam(i) == TFTeam_Blue) {
                         bluCount++;
                    }
               }
          }

          if(redCount < bluCount) {
               for(int i = 1; i <= MaxClients && bluCount != redCount; i++) {
                    if(IsClientInGame(i) && TF2_GetClientTeam(i) == TFTeam_Blue) {
                         TF2_ChangeClientTeam(i, TFTeam_Red);
                         redCount++;
                         bluCount--;
                    }
               }
          }

          if(bluCount < redCount) {
               for(int i = 1; i <= MaxClients && bluCount != redCount; i++) {
                    if(IsClientInGame(i) && TF2_GetClientTeam(i) == TFTeam_Red) {
                         TF2_ChangeClientTeam(i, TFTeam_Blue);
                         bluCount++;
                         redCount--;
                    }
               }
          }

          switch(activePlayers) {
               case 4: {
                    TFClassType classes[] = {TFClass_Soldier, TFClass_Medic};
                    for(int i = 0; i < sizeof(classes); i++) {
                         bluClasses.Push(classes[i]);
                         redClasses.Push(classes[i]);
                    }

                    PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Teams will follow the competitive format of Ultiduo.");
               }
               case 8: {
                    TFClassType classes[] = {TFClass_DemoMan, TFClass_Medic, TFClass_Soldier, TFClass_Scout};
                    for(int i = 0; i < sizeof(classes); i++) {
                         bluClasses.Push(classes[i]);
                         redClasses.Push(classes[i]);
                    }

                    PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Teams will follow the competitive format of 4v4.");
               }
               case 12: {
                    TFClassType classes[] = {TFClass_DemoMan, TFClass_Medic, TFClass_Scout, TFClass_Scout, TFClass_Soldier, TFClass_Soldier};
                    for(int i = 0; i < sizeof(classes); i++) {
                         bluClasses.Push(classes[i]);
                         redClasses.Push(classes[i]);
                    }

                    PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Teams will follow the competitive format of 6s.");
               }
               case 18: {
                    TFClassType classes[] = {TFClass_Scout, TFClass_Soldier, TFClass_Pyro, TFClass_DemoMan, TFClass_Heavy, TFClass_Engineer, TFClass_Medic, TFClass_Sniper, TFClass_Spy};
                    for(int i = 0; i < sizeof(classes); i++) {
                         bluClasses.Push(classes[i]);
                         redClasses.Push(classes[i]);
                    }

                    PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Teams will follow the competitive format of Highlander.");
               }
          }

          for(int i = 1; i <= MaxClients; i++) {
               if(!IsClientInGame(i)) {
                    continue;
               }

               if(TF2_GetClientTeam(i) == TFTeam_Blue && bluClasses.Length > 0) {
                    int randIndex = GetRandomInt(0, bluClasses.Length - 1);
                    g_Effect16_AssignedClass[i] = bluClasses.Get(randIndex);
                    bluClasses.Erase(randIndex);
               }
               else if(TF2_GetClientTeam(i) == TFTeam_Red && redClasses.Length > 0) {
                    int randIndex = GetRandomInt(0, redClasses.Length - 1);
                    g_Effect16_AssignedClass[i] = redClasses.Get(randIndex);
                    redClasses.Erase(randIndex);
               }

               TF2_SetPlayerClass(i, view_as<TFClassType>(g_Effect16_AssignedClass[i]), false);
               TF2_RegeneratePlayer(i);
          }

     }
     else {
          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i)) {
                    TF2_SetPlayerClass(i, view_as<TFClassType>(g_Effect16_AssignedClass[i]), false);
                    TF2_RegeneratePlayer(i);
               }
          }
     }

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_16_Rolemodel(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     if(IsClientInGame(client) && IsPlayerAlive(client) && view_as<TFClassType>(g_Effect16_AssignedClass[client]) != TF2_GetPlayerClass(client)) {
          TF2_SetPlayerClass(client, view_as<TFClassType>(g_Effect16_AssignedClass[client]), false);
          TF2_RegeneratePlayer(client);
     }
}