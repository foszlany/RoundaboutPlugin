#pragma semicolon 1

public void Event_RoundStart_9_ForceMelee(Event event, const char[] name, bool dontBroadcast) {
     if(IsRareEffectForced(EFFECT_FORCEMELEE) || GetRandomInt(0, 100) <= 2) {
          g_Effect9_IsSpecialRound = true;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Melee hits instakill.");
     }
     else {
          g_Effect9_IsSpecialRound = false;
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               EquipPlayerWeapon(i, GetPlayerWeaponSlot(i, TFWeaponSlot_Melee));
               CreateTimer(0.12, ForceToMelee, i);

               if(g_Effect9_IsSpecialRound) {
                    TF2Attrib_SetByName(i, "damage bonus", 10.0);
               }
          }
     }
}

public void Event_RoundEnd_9_ForceMelee(Event event, const char[] name, bool dontBroadcast) {
     if(g_Effect9_IsSpecialRound) {
          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i)) {
                    TF2Attrib_RemoveByName(i, "damage bonus");
               }
          }
     }
}

public void Event_PlayerUpdate_9_ForceMelee(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     CreateTimer(0.12, ForceToMelee, client);
}

public Action ForceToMelee(Handle timer, int client) {
     TF2_RemoveWeaponSlot(client, TFWeaponSlot_Primary);
     TF2_RemoveWeaponSlot(client, TFWeaponSlot_Secondary);

     if(TF2_GetPlayerClass(client) != TFClass_Spy) {
          TF2_RemoveWeaponSlot(client, TFWeaponSlot_Grenade);
          TF2_RemoveWeaponSlot(client, TFWeaponSlot_Building);
          TF2_RemoveWeaponSlot(client, TFWeaponSlot_PDA);
     }

     int melee = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
     if(IsValidEntity(melee)) {
          EquipPlayerWeapon(client, melee);
     }

     if(g_Effect9_IsSpecialRound) {
          TF2Attrib_SetByName(client, "damage bonus", 10.0);
     }

     return Plugin_Handled;
}