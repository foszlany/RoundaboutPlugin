#pragma semicolon 1

public void Event_RoundStart_43_SuperJump(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               SDKHook(i, SDKHook_PreThink, Effect43_OnDuck);
          }
     }
    
     ShowCurrentEffectDescription(-1);
}

public void Event_RoundEnd_43_SuperJump(Event event, const char[] name, bool dontBroadcast) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i)) {
               SDKUnhook(i, SDKHook_PreThink, Effect43_OnDuck);
          }
     }
}

public void Effect43_OnDuck(int client) {
     if(g_CurrentEffect != 43) {
          SDKUnhook(client, SDKHook_PreThink, Effect43_OnDuck);
     }

     bool isDucked = view_as<bool>(GetEntProp(client, Prop_Send, "m_bDucked"));
     bool isDucking = view_as<bool>(GetEntProp(client, Prop_Send, "m_bDucking"));

     if((isDucked || isDucking) && (IsClientInGame(client) && IsPlayerAlive(client))) {
          CreateExplosionUnderPlayer(client);

          // APPLY DELAY
          SDKUnhook(client, SDKHook_PreThink, Effect43_OnDuck);
          CreateTimer(4.0, Effect43_ReapplyHook, client);
     }
}

public Action Effect43_ReapplyHook(Handle timer, int client) {
     if(IsClientInGame(client)) {
          SDKHook(client, SDKHook_PreThink, Effect43_OnDuck);
     }

     return Plugin_Handled;
}

void CreateExplosionUnderPlayer(int client) {
     if(IsClientInGame(client) && IsPlayerAlive(client)) {
          // PLAYER POS
          float pos[3];
          GetClientAbsOrigin(client, pos);
          pos[2] -= 30.0;

          EmitSoundToAll("weapons/explode3.wav", SOUND_FROM_WORLD, _, _, _, 1.0, _, _, pos);

          ApplyKnockbackToPlayer(client, pos);
     }
}

void ApplyKnockbackToPlayer(int client, const float explosionPos[3]) {
     float clientPos[3];
     GetClientAbsOrigin(client, clientPos);

     // DIRECTION FROM EXPLOSION TO PLAYER
     float dir[3];
     SubtractVectors(clientPos, explosionPos, dir);
     NormalizeVector(dir, dir);
     ScaleVector(dir, 800.0); // KNOCKBACK

     // APPLY VELOCITY
     float newVelocity[3];
     GetEntPropVector(client, Prop_Data, "m_vecVelocity", newVelocity);
     AddVectors(newVelocity, dir, newVelocity);
     TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, newVelocity);
}