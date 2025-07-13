#pragma semicolon 1

public void Event_RoundStart_33_Invis(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               CreateTimer(0.1, Timer_ApplyInvisibility, i);
          }
     }

     PrintCenterTextAll("Invis");
     ShowHintToAllClients("Invis\n\nWhere's everyone?");
}

public void Event_PlayerUpdate_33_Invis(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     CreateTimer(0.1, Timer_ApplyInvisibility, client);
}

public void Event_RoundEnd_33_Invis(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               ApplyInvisibility(i, false);
          }
     }
}

public Action Timer_ApplyInvisibility(Handle timer, int client) {
     if(client > 0 && IsClientInGame(client) && IsPlayerAlive(client)) {
          ApplyInvisibility(client, true);
     }

     return Plugin_Handled;
}

void ApplyInvisibility(int client, bool mode) {
     int alpha = mode ? 0 : 255;

     // PLAYER
     SetEntityRenderMode(client, RENDER_TRANSCOLOR);
     SetEntityRenderColor(client, 255, 255, 255, alpha);

     // WEAPONS
     for(int slot = 0; slot < 6; slot++) {
          int weapon = GetPlayerWeaponSlot(client, slot);
          if(IsValidEntity(weapon)) {
               SetEntityRenderMode(weapon, RENDER_TRANSCOLOR);
               SetEntityRenderColor(weapon, 255, 255, 255, alpha);
          }
     }

     // WEARABLES
     int entity = -1;
     while((entity = FindEntityByClassname(entity, "tf_wearable*")) != -1) {
          if(GetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity") == client) {
               SetEntityRenderMode(entity, RENDER_TRANSCOLOR);
               SetEntityRenderColor(entity, 255, 255, 255, alpha);
          }
     }

     // POWERUPS
     entity = -1;
     while((entity = FindEntityByClassname(entity, "tf_powerup_bottle")) != -1) {
          if(GetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity") == client) {
               SetEntityRenderMode(entity, RENDER_TRANSCOLOR);
               SetEntityRenderColor(entity, 255, 255, 255, alpha);
          }
     }
}