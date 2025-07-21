#pragma semicolon 1

public void Event_RoundStart_34_Secondary(Event event, const char[] name, bool dontBroadcast) {
     g_Effect34_IsSpecialRound = false;

     if(GetRandomInt(0, 100) <= 5) {
          g_Effect34_IsSpecialRound = true;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Melee weapons have been taken away too.", name);
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               CreateTimer(0.12, RemovePrimaryWeapon, i);
          }
     }

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_34_Secondary(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     CreateTimer(0.12, RemovePrimaryWeapon, client);
}

public Action RemovePrimaryWeapon(Handle timer, int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          if(TF2_GetPlayerClass(client) != TFClass_Spy) {
               TF2_RemoveWeaponSlot(client, TFWeaponSlot_Primary);
          }

          if(g_Effect34_IsSpecialRound) {
               TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
          }

          int secondary = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
          if(IsValidEntity(secondary)) {
               EquipPlayerWeapon(client, secondary);
          }
     }

     return Plugin_Handled;
}