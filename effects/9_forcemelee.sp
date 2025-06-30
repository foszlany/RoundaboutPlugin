#pragma semicolon 1

public void Event_RoundStart_9_ForceMelee(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               EquipPlayerWeapon(i, GetPlayerWeaponSlot(i, 2));
               CreateTimer(0.12, ForceToMelee, i);
          }
     }

     PrintCenterTextAll("Force Melee");
     ShowHintToAllClients("Force Melee\n\nYou only have your melee to protect you!");
}

public void Event_PlayerUpdate_9_ForceMelee(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     CreateTimer(0.12, ForceToMelee, client);
}

public Action ForceToMelee(Handle timer, int client) {
     TF2_RemoveWeaponSlot(client, 0);
     TF2_RemoveWeaponSlot(client, 1);

     if(TF2_GetPlayerClass(client) != TFClass_Spy) {
          TF2_RemoveWeaponSlot(client, 3);
          TF2_RemoveWeaponSlot(client, 4);
          TF2_RemoveWeaponSlot(client, 5);
     }

     int melee = GetPlayerWeaponSlot(client, 2);
     if(IsValidEntity(melee)) {
          EquipPlayerWeapon(client, melee);
     }

     return Plugin_Handled;
}