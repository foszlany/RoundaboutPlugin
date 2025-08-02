#pragma semicolon 1

public void Event_RoundStart_56_BuffingHeal(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               SDKHook(i, SDKHook_PreThink, HealedByMedicApplyMiniCrit);
          }
          
          SetHealPenalty(i);
     }

     HookEvent("crossbow_heal", ApplyCrossBowHeal, EventHookMode_Pre);

     ShowCurrentEffectDescriptionToAll(-1);
}

public void Event_PlayerUpdate_56_BuffingHeal(Event event, const char[] name, bool dontBroadcast) {    
     int client = GetClientOfUserId(event.GetInt("userid"));
     
     SetHealPenalty(client);
}

public void Event_RoundEnd_56_BuffingHeal(Event event, const char[] name, bool dontBroadcast) {    
     UnhookEvent("crossbow_heal", ApplyCrossBowHeal, EventHookMode_Pre);
     
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               SDKUnhook(i, SDKHook_PreThink, HealedByMedicApplyMiniCrit);

               if(TF2_GetPlayerClass(i) == TFClass_Medic) {
                    int secondaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary);
                    if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
                         TF2Attrib_RemoveByName(secondaryWeapon, "heal rate penalty");
                    }
               }
          }   

     }  
}

public void SetHealPenalty(int client) {
     if(IsClientInGame(client) && TF2_GetPlayerClass(client) == TFClass_Medic) {
          int secondaryWeapon = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
          if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
               TF2Attrib_SetByName(secondaryWeapon, "heal rate penalty", 0.33);
          }
     }
}

public void ApplyCrossBowHeal(Event event, const char[] name, bool dontBroadcast) {
     int target = GetClientOfUserId(event.GetInt("target"));
     int healer = GetClientOfUserId(event.GetInt("healer"));
     int amount = event.GetInt("amount");

     if(target > 0 && IsClientInGame(target) && !IsOpposingTeam(target, healer)) {
          TF2_AddCondition(target, TFCond_Buffed, 1.0 + float(amount) / 20.0);
     }
}

public void HealedByMedicApplyMiniCrit(int client) {    
     if(client > 0 && IsClientInGame(client) && TF2_GetPlayerClass(client) == TFClass_Medic) {
          int medigun = GetPlayerWeaponSlot(client, TFWeaponSlot_Secondary);
          if(medigun != -1) {
               int target = GetEntDataEnt2(medigun, FindSendPropInfo("CWeaponMedigun", "m_hHealingTarget"));
               if(target > 0 && IsClientInGame(target)) {
                    TF2_AddCondition(target, TFCond_Buffed, 0.33);
               }
          }
     }
}