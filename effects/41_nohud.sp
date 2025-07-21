#pragma semicolon 1

#define HIDEHUD_HEALTH ( 1 << 3 )
#define HIDEHUD_MISCSTATUS ( 1 << 6 )
#define HIDEHUD_CROSSHAIR ( 1 << 8 )

#define HIDEHUD_EFFECT (HIDEHUD_HEALTH | HIDEHUD_MISCSTATUS | HIDEHUD_CROSSHAIR)

public void Event_RoundStart_41_NoHud(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          HideHUD(i);
     }

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_41_NoHud(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     HideHUD(client);
}

public void Event_RoundEnd_41_NoHud(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          RestoreHUD(i);
     }
}

void HideHUD(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          int hudFlags = GetEntProp(client, Prop_Send, "m_iHideHUD");
          SetEntProp(client, Prop_Send, "m_iHideHUD", hudFlags | HIDEHUD_EFFECT);
     }
}

void RestoreHUD(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          int hudFlags = GetEntProp(client, Prop_Send, "m_iHideHUD");
          SetEntProp(client, Prop_Send, "m_iHideHUD", hudFlags & ~HIDEHUD_EFFECT);
     }
}