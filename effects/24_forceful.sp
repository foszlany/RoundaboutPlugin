#pragma semicolon 1

#define E24_RARE_CHANCE 2
#define E24_RARE_KNOCKBACK_BONUS 10.0
#define E24_KNOCKBACK_BONUS 3.0

public void Event_RoundStart_24_Forceful(Event event, const char[] name, bool dontBroadcast) {
     if(IsRareEffectForced(EFFECT_FORCEFUL) || GetRandomInt(0, 100) <= E24_RARE_CHANCE) {
          g_Effect24_KnockbackBonus = E24_RARE_KNOCKBACK_BONUS;
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Knockback multiplier is now way stronger!");
     }
     else {
          g_Effect24_KnockbackBonus = E24_KNOCKBACK_BONUS;
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2Attrib_SetByName(i, "damage force increase hidden", g_Effect24_KnockbackBonus);
               TF2Attrib_SetByName(i, "airblast pushback scale", g_Effect24_KnockbackBonus);
          }
     }
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