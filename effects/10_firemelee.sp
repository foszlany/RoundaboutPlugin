#pragma semicolon 1

public void Event_RoundStart_10_FireMelee(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          applyMiniCritVsBurning(i);
     }
}

public void Event_PlayerUpdate_10_FireMelee(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     applyMiniCritVsBurning(client);
}

public void Event_PlayerHit_10_FireMelee(Event event, const char[] name, bool dontBroadcast) {
     int attacker = GetClientOfUserId(event.GetInt("attacker"));
     int victim = GetClientOfUserId(event.GetInt("userid"));

     if(attacker <= 0 || attacker == victim || !IsPlayerAlive(attacker)) {
          return;
     }
     
     if(GetEntPropEnt(attacker, Prop_Send, "m_hActiveWeapon") == GetPlayerWeaponSlot(attacker, TFWeaponSlot_Melee)) {
          TF2_IgnitePlayer(victim, attacker, 8.0);
     }
}

public void Event_RoundEnd_10_FireMelee(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               int meleeWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Melee);
               if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
                    TF2Attrib_RemoveByName(meleeWeapon, "minicrit vs burning player");
               }
          }
     }
}

public void applyMiniCritVsBurning(int client) {
     if(IsClientInGame(client)) {
          int meleeWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
          if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
               TF2Attrib_SetByName(meleeWeapon, "minicrit vs burning player", 1.0);
          }
     }
}