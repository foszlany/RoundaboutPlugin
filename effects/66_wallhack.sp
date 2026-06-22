#pragma semicolon 1

public void Event_RoundStart_66_Wallhack(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               ApplyWallhack(i, true);
          }
     }

     PrintToChatAll("\x07B143F1[Roundabout]\x01 If you can't see the outlines, type this into console: \x072EFFCBglow_outline_effect_enable 1\x01");
}

public void Event_PlayerUpdate_66_Wallhack(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     ApplyWallhack(client, true);
}

public void Event_RoundEnd_66_Wallhack(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               ApplyWallhack(i, false);
          }
     }
}

public void ApplyWallhack(int client, bool on) {
     if(!IsClientInGame(client) || !IsPlayerAlive(client)) {
          return;
     }
          
     SetEntProp(client, Prop_Send, "m_bGlowEnabled", on);
}