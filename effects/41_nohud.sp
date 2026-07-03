#pragma semicolon 1

#define HIDEHUD_HEALTH ( 1 << 3 )
#define HIDEHUD_MISCSTATUS ( 1 << 6 )
#define HIDEHUD_CROSSHAIR ( 1 << 8 )

#define HIDEHUD_EFFECT (HIDEHUD_HEALTH | HIDEHUD_MISCSTATUS | HIDEHUD_CROSSHAIR)

public void Event_RoundStart_41_NoHud(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          E41_HideHUD(i);
     }
}

public void Event_PlayerUpdate_41_NoHud(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     E41_HideHUD(client);
}

public void Event_RoundEnd_41_NoHud(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          E41_RestoreHUD(i);
     }
}

public void E41_HideHUD(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          int hudFlags = GetEntProp(client, Prop_Send, "m_iE41_HideHUD");
          SetEntProp(client, Prop_Send, "m_iE41_HideHUD", hudFlags | HIDEHUD_EFFECT);
     }
}

public void E41_RestoreHUD(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          int hudFlags = GetEntProp(client, Prop_Send, "m_iE41_HideHUD");
          SetEntProp(client, Prop_Send, "m_iE41_HideHUD", hudFlags & ~HIDEHUD_EFFECT);
     }
}