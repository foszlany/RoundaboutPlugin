#pragma semicolon 1

public void Event_RoundStart_9_ForceMelee(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               EquipPlayerWeapon(i, GetPlayerWeaponSlot(i, TFWeaponSlot_Melee));
               CreateTimer(0.12, ForceToMelee, i);
          }
     }

     ShowCurrentEffectDescriptionToAll(-1);
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

     return Plugin_Handled;
}