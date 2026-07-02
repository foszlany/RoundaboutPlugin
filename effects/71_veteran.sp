#pragma semicolon 1

public void Event_RoundStart_71_Veteran(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          E72_KillWearables(i);
     }
}

public void Event_PlayerUpdate_71_Veteran(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     E72_KillWearables(client);
}

public void E72_KillWearables(int client) {
     if(!IsClientInGame(client) || !IsPlayerAlive(client)) {
          return;    
     }

     int ent = -1;
     while((ent = FindEntityByClassname(ent, "tf_wearable")) != -1) {
          if(GetEntPropEnt(ent, Prop_Send, "m_hOwnerEntity") == client) {
               TF2_RemoveWearable(client, ent);
          }
     }

     ent = -1;
     while((ent = FindEntityByClassname(ent, "tf_wearable_particle")) != -1) {
          if (GetEntPropEnt(ent, Prop_Send, "m_hOwnerEntity") == client) {
               TF2_RemoveWearable(client, ent);
          }
     }

     ent = -1;
     while((ent = FindEntityByClassname(ent, "tf_wearable_particle")) != -1) {
          if(GetEntPropEnt(ent, Prop_Send, "m_hOwnerEntity") == client) {
               AcceptEntityInput(ent, "Kill");
          }
     }
}