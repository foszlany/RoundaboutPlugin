#pragma semicolon 1

public void Event_RoundStart_10_FireMelee(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          applyMiniCritVsBurning(i);
     }
     
     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_10_FireMelee(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));
     applyMiniCritVsBurning(client);
}

public void Event_RoundEnd_10_FireMelee(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               int meleeWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Melee);
               if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
                    TF2Attrib_RemoveByName(meleeWeapon, "minicrit vs burning player");
                    TF2Attrib_RemoveByName(meleeWeapon, "Set DamageType Ignite");
               }
          }
     }
}

public void applyMiniCritVsBurning(int client) {
     if(IsClientInGame(client)) {
          int meleeWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Melee);
          if(meleeWeapon != -1 && IsValidEntity(meleeWeapon)) {
               TF2Attrib_SetByName(meleeWeapon, "minicrit vs burning player", 1.0);
               TF2Attrib_SetByName(meleeWeapon, "Set DamageType Ignite", 1.0);
          }
     }
}

/*
public int GetSentryTarget(int engineer) {
     int sentry = FindEngineerSentry(engineer);
     if(sentry != -1) {
          return GetEntPropEnt(sentry, Prop_Send, "m_hEnemy");
     }
     return -1;
}

public int FindEngineerSentry(int engineer) {
     int entity = -1;
     while((entity = FindEntityByClassname(entity, "obj_sentrygun")) != -1) {
          if(GetEntPropEnt(entity, Prop_Send, "m_hBuilder") == engineer) {
               return entity;
          }
     }
     return -1;
}
*/