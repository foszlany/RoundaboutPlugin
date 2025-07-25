#pragma semicolon 1

public void Event_RoundStart_38_NoScrubs(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          forceClass(i, TFClass_Sniper);

          int secondaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary);
          if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
               TF2_RemoveWeaponSlot(i, TFWeaponSlot_Secondary);
          }
          
          TF2_RemoveWeaponSlot(i, TFWeaponSlot_Melee);
     }

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_38_NoScrubs(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     forceClass(client, TFClass_Sniper);

     TF2_RemoveWeaponSlot(client, TFWeaponSlot_Secondary);
     TF2_RemoveWeaponSlot(client, TFWeaponSlot_Melee);
}

public void Event_PlayerHit_38_NoScrubs(Event event, const char[] name, bool dontBroadcast) {
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(attacker <= 0) {
          return;
     }

     char weapon[64];
     event.GetString("weapon", weapon, sizeof(weapon));

     int custom = event.GetInt("custom");

     if(custom != TF_CUSTOM_HEADSHOT) {
          SDKHooks_TakeDamage(
               attacker,
               attacker,
               attacker,
               99999.0,
               DMG_GENERIC,
               -1,
               NULL_VECTOR,
               NULL_VECTOR
          );

          PrintToChatAll("\x07B143F1[Roundabout]\x01 %N is a scrub.", attacker);
     }
}