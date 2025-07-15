#pragma semicolon 1

public void Event_RoundStart_40_Restriction(Event event, const char[] name, bool dontBroadcast) {
     int bannedClassCount = GetRandomInt(3, 7);

     for(int i = 0; i < 7; i++) {
          g_Effect40_DisabledClasses[i] = TFClass_Unknown;
     }

     for(int i = 0; i < bannedClassCount; i++) {
          int bannedClassCandidate;
          bool duplicate;

          do {
               duplicate = false;
               bannedClassCandidate = GetRandomInt(1, 9);
               // Check existing slots
               for (int j = 0; j < i; j++) {
                    if (g_Effect40_DisabledClasses[j] == view_as<TFClassType>(bannedClassCandidate)) {
                         duplicate = true;
                         break;
                    }
               }
          } while(duplicate);

          g_Effect40_DisabledClasses[i] = view_as<TFClassType>(bannedClassCandidate);
     }
     
     for(int i = 1; i <= MaxClients; i++) {
          ForceUnrestrictedClass(i);
     }

     PrintCenterTextAll("Restriction");
     ShowHintToAllClients("Restriction\n\nSome classes were banned.");
}

public void Event_PlayerUpdate_40_Restriction(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     ForceUnrestrictedClass(client);
}
 
public void ForceUnrestrictedClass(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          TFClassType clientClass = TF2_GetPlayerClass(client);

          for(int i = 0; i < 7; i++) {
               if(clientClass == g_Effect40_DisabledClasses[i]) {
                    PrintToChat(client, "\x07B143F1[Roundabout]\x01 This class has been banned for this round!");
                    
                    // SEARCH FOR FIRST ALLOWED CLASS
                    for(int newClass = 1; newClass <= 9; newClass++) {
                         bool isBanned = false;
                         
                         // CHECK IF NEW CLASS IS BANNED
                         for(int j = 0; j < 7 && g_Effect40_DisabledClasses[j] != TFClass_Unknown; j++) {
                              if(view_as<TFClassType>(newClass) == g_Effect40_DisabledClasses[j]) {
                                   isBanned = true;
                                   break;
                              }
                         }
                         
                         // FORCE THEN EXIT
                         if(!isBanned) {
                              forceClass(client, view_as<TFClassType>(newClass));
                              return;
                         }
                    }
               }
               
               // NO MORE BANNED CLASSES DEFINED
               if(g_Effect40_DisabledClasses[i] == TFClass_Unknown) {
                    return;
               }
          }
     }
}