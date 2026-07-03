#pragma semicolon 1

char g_ClassModels[][] = {
     "",
     "models/player/scout.mdl",
     "models/player/soldier.mdl",
     "models/player/pyro.mdl",
     "models/player/demo.mdl",
     "models/player/heavy.mdl",
     "models/player/engineer.mdl",
     "models/player/medic.mdl",
     "models/player/sniper.mdl",
     "models/player/spy.mdl"
};

public void Event_RoundStart_65_Cosplay(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               E65_ChangeModel(i);
          }
     }
}

public void Event_PlayerUpdate_65_Cosplay(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     if(client && IsClientInGame(client) && IsPlayerAlive(client)) {
          if(!g_Effect65_IsChangingClasses[client]) {
               E65_ChangeModel(client);
          }
     }
}

public void E65_ChangeModel(int client) {
     if(!IsClientInGame(client) || !IsPlayerAlive(client)) {
          return;
     }
     
     g_Effect65_IsChangingClasses[client] = true;
     
     TFClassType current = TF2_GetPlayerClass(client);
     TFClassType newClass;

     do {
          newClass = view_as<TFClassType>(GetRandomInt(1, 9));
     } while(newClass == current);

     SetEntityModel(client, g_ClassModels[newClass]);
     TF2_RespawnPlayer(client);
     SetEntProp(client, Prop_Send, "m_iClass", newClass);
     
     g_Effect65_IsChangingClasses[client] = false;
}