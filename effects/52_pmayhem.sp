#pragma semicolon 1

#define E52_PROJECTILE_ASSIGNMENT_TIMER 1.0

float g_SafeProjectiles[] = {0.0, 2.0, 5.0, 6.0, 13.0};
int g_SafeProjectilesSize = sizeof(g_SafeProjectiles) - 1;

public void Event_RoundStart_52_ProjectileMayhem(Event event, const char[] name, bool dontBroadcast) {
     CreateTimer(E52_PROJECTILE_ASSIGNMENT_TIMER, E52_AssignNewProjectiles);
}

public void Event_RoundEnd_52_ProjectileMayhem(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               int primaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Primary);
               if(primaryWeapon != -1 && IsValidEntity(primaryWeapon)) {
                    TF2Attrib_RemoveByName(primaryWeapon, "override projectile type");
               }

               int secondaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary);
               if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon)) {
                    TF2Attrib_RemoveByName(secondaryWeapon, "override projectile type");
               }
          }
     }
}

public Action E52_AssignNewProjectiles(Handle timer) {
     if(IsEffectLive(EFFECT_PMAYHEM)) {
          for(int i = 1; i <= MaxClients; i++) {
               if(IsClientInGame(i)) {
                    int primaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Primary);
                    if(primaryWeapon != -1 && IsValidEntity(primaryWeapon) && TF2_GetPlayerClass(i) != TFClass_Sniper) { // HUNTSMAN CRASH
                         TF2Attrib_SetByName(primaryWeapon, "override projectile type", g_SafeProjectiles[GetRandomInt(0, g_SafeProjectilesSize)]);
                    }

                    int secondaryWeapon = GetPlayerWeaponSlot(i, TFWeaponSlot_Secondary);
                    if(secondaryWeapon != -1 && IsValidEntity(secondaryWeapon) && TF2_GetPlayerClass(i) != TFClass_DemoMan) { // STICKYBOMB CRASH
                         TF2Attrib_SetByName(secondaryWeapon, "override projectile type", g_SafeProjectiles[GetRandomInt(0, g_SafeProjectilesSize)]);
                    }
               }
          }
          
          CreateTimer(E52_PROJECTILE_ASSIGNMENT_TIMER, E52_AssignNewProjectiles);
     }

     return Plugin_Handled;
}