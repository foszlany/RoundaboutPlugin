#pragma semicolon 1

public void Event_RoundStart_38_NoScrubs(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          SetNoScrubsAttributes(i);
     }
}

public void Event_PlayerUpdate_38_NoScrubs(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     SetNoScrubsAttributes(client);
}

public void Event_PlayerHit_38_NoScrubs(Event event, const char[] name, bool dontBroadcast) {
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(attacker <= 0 || !IsPlayerAlive(attacker)) {
          return;
     }

     if(GetEntPropEnt(attacker, Prop_Send, "m_hActiveWeapon") == GetPlayerWeaponSlot(attacker, TFWeaponSlot_Melee)) {
          return;
     }

     char weapon[64];
     event.GetString("weapon", weapon, sizeof(weapon));

     int custom = event.GetInt("custom");

     if(custom != TF_CUSTOM_HEADSHOT && custom != TF_CUSTOM_BLEEDING && custom != TF_CUSTOM_TAUNT_ARROW_STAB) {
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

public void SetNoScrubsAttributes(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          ForceClass(client, TFClass_Sniper);

          int secondaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
          if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
               TF2_RemoveWeaponSlot(client, TFWeaponSlot_Secondary);
          }
     }
}