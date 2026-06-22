#pragma semicolon 1

public void Event_RoundStart_70_Bounty(Event event, const char[] name, bool dontBroadcast) {
     g_Effect70_BountyWeaponIndex = -1;
     g_Effect70_BountyTimer = CreateTimer(45.0, GenerateBounty, _, TIMER_REPEAT);
}

public void Event_RoundEnd_70_Bounty(Event event, const char[] name, bool dontBroadcast) {
     KillTimer(g_Effect70_BountyTimer);
     g_Effect70_BountyTimer = null;
}

public void Event_PlayerDeath_70_Bounty(Event event, const char[] name, bool dontBroadcast) {    
     int victim = GetClientOfUserId(event.GetInt("userid"));
     int attacker = GetClientOfUserId(event.GetInt("attacker"));

     if(g_Effect70_BountyWeaponIndex == -1 || victim == attacker || !IsClientInGame(attacker) || !IsPlayerAlive(attacker)) {
          return;
     }

     int weaponIndex = event.GetInt("weapon_def_index");

     char weaponIndexString[8];
     IntToString(weaponIndex, weaponIndexString, sizeof(weaponIndexString));

     char reskinIndexString[8];
     bool isReskin = g_ReskinInfo.GetString(weaponIndexString, reskinIndexString, sizeof(reskinIndexString));
     int reskinIndex = StringToInt(reskinIndexString);

     if(g_Effect70_BountyWeaponIndex == weaponIndex || (isReskin && g_Effect70_BountyWeaponIndex == reskinIndex)) {
          ApplyPowerplay(attacker, 8.0);
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Bounty has been claimed by %N!", attacker);
          g_Effect70_BountyWeaponIndex = -1;
     }
}

public Action GenerateBounty(Handle timer) {
     if(timer == null) {
          return Plugin_Handled;
     }

     char id[8], name[64];
     if(!GetRandomWeapon(id, sizeof(id), name, sizeof(name))) {
          PrintToServer("Someone went very wrong while generating a bounty weapon!");
          return Plugin_Handled;
     }

     g_Effect70_BountyWeaponIndex = StringToInt(id);

     PrintToChatAll("\x07B143F1[Roundabout]\x01 New bounty! Kill someone using \x07FFA126%s\x01", name);

     return Plugin_Handled;
}

bool GetRandomWeapon(char[] key, int keyLen, char[] value, int valueLen) {
     StringMapSnapshot snap = g_WeaponInfo.Snapshot();
     int count = snap.Length;

     if(count == 0) {
          return false;
     }

     int index = GetRandomInt(0, count - 1);

     snap.GetKey(index, key, keyLen);
     g_WeaponInfo.GetString(key, value, valueLen);

     return true;
}
