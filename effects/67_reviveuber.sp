#pragma semicolon 1

#define E67_UBER_PERCENT 0.25

public void Event_RoundStart_67_ReviveUber(Event event, const char[] name, bool dontBroadcast) {
	HookEvent("player_chargedeployed", E67_RevivePlayers, EventHookMode_Pre);
}

public void Event_RoundEnd_67_ReviveUber(Event event, const char[] name, bool dontBroadcast) {
     UnhookEvent("player_chargedeployed", E67_RevivePlayers, EventHookMode_Pre);
}

public void E67_RevivePlayers(Event event, const char[] name, bool dontBroadcast) {
     int medic = GetClientOfUserId(event.GetInt("userid"));

     float pos[3];
     float angles[3];
     GetClientAbsOrigin(medic, pos);
     GetClientEyeAngles(medic, angles);

     if(IsClientInGame(medic) && IsPlayerAlive(medic)) {
          TFTeam medicTeam = TF2_GetClientTeam(medic);
          int playersRevived = 0;

          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i) && !IsPlayerAlive(i) && medicTeam == TF2_GetClientTeam(i)) {
                    TF2_RespawnPlayer(i);
                    TeleportEntity(i, pos, angles, NULL_VECTOR);
                    playersRevived++;
               }

               if(playersRevived * E67_UBER_PERCENT >= 1) {
                    break;
               }
          }

          E67_SubtractUber(medic, playersRevived * E67_UBER_PERCENT);
     }
}

void E67_SubtractUber(int medic, float amount) {
     if(!IsClientInGame(medic) || !IsPlayerAlive(medic)) {
          return;
     }

     int weapon = GetPlayerWeaponSlot(medic, TFWeaponSlot_Secondary);
     if(weapon <= MaxClients || !IsValidEntity(weapon)) {
          return;
     }
          
     char classname[64];
     GetEntityClassname(weapon, classname, sizeof(classname));

     if(!StrEqual(classname, "tf_weapon_medigun")) {
          return;
     }

     float uber = GetEntPropFloat(weapon, Prop_Send, "m_flChargeLevel");

     uber -= amount;

     if(uber < 0.0) {
          uber = 0.0;
     }

     SetEntPropFloat(weapon, Prop_Send, "m_flChargeLevel", uber);
}
