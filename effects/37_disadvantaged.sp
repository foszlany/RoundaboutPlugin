#pragma semicolon 1

public void Event_RoundStart_37_Disadvantaged(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          g_Effect37_PreviousClass[i] = TFClass_Unknown;
          HandleSpecialAbilityRemoval(i);
     }

     PrintCenterTextAll("Disadvantaged");
     ShowHintToAllClients("Disadvantaged\n\nSome special abilities have been taken away.");
}

public void Event_PlayerUpdate_37_Disadvantaged(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     HandleSpecialAbilityRemoval(client);
}

public void Event_RoundEnd_37_Disadvantaged(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               RemoveDisadvantagePerClass(i);
          }
     }
}

public void HandleSpecialAbilityRemoval(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          bool isNewClass = false;

          if(g_Effect37_PreviousClass[client] == TFClass_Unknown) {
               g_Effect37_PreviousClass[client] = TF2_GetPlayerClass(client);

               isNewClass = true;
          }
          else if(g_Effect37_PreviousClass[client] != TF2_GetPlayerClass(client)) {
               RemoveDisadvantagePerClass(client);
               g_Effect37_PreviousClass[client] = TF2_GetPlayerClass(client);

               isNewClass = true;
          }

          AddDisadvantagePerClass(client, isNewClass);
     }
}

public void AddDisadvantagePerClass(int client, bool isNewClass) {
     switch(g_Effect37_PreviousClass[client]) {
          case TFClass_Scout: {
               TF2Attrib_SetByName(client, "no double jump", 1.0);

               if(isNewClass) {
                    PrintToChat(client, "\x07B143F1[Roundabout] \x07D5D5D5Scout\x01: Double jumping has been disabled.");
               }
          }
          case TFClass_Soldier: {
               TF2Attrib_SetByName(client, "self dmg push force decreased", 0.0);

               if(isNewClass) {
                    PrintToChat(client, "\x07B143F1[Roundabout] \x07D5D5D5Soldier\x01: Rocket jumping has been disabled.");
               }
          }
          case TFClass_Pyro: {
               int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
               if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_SetByName(client, "airblast disabled", 1.0);
               }

               if(isNewClass) {
                    PrintToChat(client, "\x07B143F1[Roundabout] \x07D5D5D5Pyro\x01: Airblasting has been disabled.");
               }
          }
          case TFClass_DemoMan: {
               TF2_RemoveWeaponSlot(client, TFWeaponSlot_Secondary);

               if(isNewClass) {
                    PrintToChat(client, "\x07B143F1[Roundabout] \x07D5D5D5Demoman\x01: Secondary weapon has been removed.");
               }
          }
          case TFClass_Heavy: {
               if(isNewClass) {
                    PrintToChat(client, "\x07B143F1[Roundabout] \x07D5D5D5Heavy\x01: No special effect. Play something less boring.");
               }
          }
          case TFClass_Engineer: {
               TF2_RemoveWeaponSlot(client, TFWeaponSlot_Grenade);
               TF2_RemoveWeaponSlot(client, TFWeaponSlot_Building);

               if(isNewClass) {
                    PrintToChat(client, "\x07B143F1[Roundabout] \x07D5D5D5Engineer\x01: Building has been disabled.");
               }
          }
          case TFClass_Medic: {
               TF2_RemoveWeaponSlot(client, TFWeaponSlot_Secondary);

               if(isNewClass) {
                    PrintToChat(client, "\x07B143F1[Roundabout] \x07D5D5D5Medic\x01: Medigun usage has been disabled.");
               }
          }
          case TFClass_Sniper: {
               int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
               if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_SetByName(client, "sniper no headshots", 1.0);
               }

               if (isNewClass) {
                    PrintToChat(client, "\x07B143F1[Roundabout] \x07D5D5D5Sniper\x01: Rifle headshots have been disabled.");
               }
          }
          case TFClass_Spy: {
               TF2_RemoveWeaponSlot(client, TFWeaponSlot_Grenade);
               
               if(isNewClass) {
                    PrintToChat(client, "\x07B143F1[Roundabout] \x07D5D5D5Spy\x01: Disguising has been disabled.");
               }
          }
     }
}

public void RemoveDisadvantagePerClass(int client) {
     switch(g_Effect37_PreviousClass[client]) {
          case TFClass_Scout: {
               TF2Attrib_RemoveByName(client, "no double jump");
          }
          case TFClass_Soldier: {
               TF2Attrib_RemoveByName(client, "self dmg push force decreased");
          }
          case TFClass_Pyro: {
               int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
               if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_RemoveByName(client, "airblast disabled");
               }
          }
          case TFClass_Sniper: {
               int primaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Primary);
               if (primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_RemoveByName(client, "sniper no headshots");
               }
          }
     }
}