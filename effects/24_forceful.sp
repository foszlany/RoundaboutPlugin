#pragma semicolon 1

public void Event_RoundStart_24_Forceful(Event event, const char[] name, bool dontBroadcast) {
     if(GetRandomInt(0, 100) <= 2) {
          g_Effect24_KnockbackBonus = 10.0;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Knockback multiplier is now way stronger!", name);
     }
     else {
          g_Effect24_KnockbackBonus = 3.0;
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2Attrib_SetByName(i, "damage force increase hidden", g_Effect24_KnockbackBonus);
               TF2Attrib_SetByName(i, "airblast pushback scale", g_Effect24_KnockbackBonus);
          }
     }

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_24_Forceful(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     TF2Attrib_SetByName(client, "damage force increase hidden", g_Effect24_KnockbackBonus);
     TF2Attrib_SetByName(client, "airblast pushback scale", g_Effect24_KnockbackBonus);
}


public void Event_RoundEnd_24_Forceful(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               TF2Attrib_RemoveByName(i, "damage force increase hidden");
               TF2Attrib_RemoveByName(i, "airblast pushback scale");
          }
     }
}