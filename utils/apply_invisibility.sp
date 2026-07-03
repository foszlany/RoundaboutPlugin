public void ApplyInvisibility(int client, bool mode) {
     int alpha = mode ? 0 : 255;

     // PLAYER
     SetEntityRenderMode(client, RENDER_TRANSCOLOR);
     SetEntityRenderColor(client, 255, 255, 255, alpha);

     // WEAPONS
     for(int slot = 0; slot < 6; slot++) {
          int weapon = GetPlayerWeaponSlot(client, slot);
          if(IsValidEntity(weapon)) {
               SetEntityRenderMode(weapon, RENDER_TRANSCOLOR);
               SetEntityRenderColor(weapon, 255, 255, 255, alpha);
          }
     }

     // WEARABLES
     int entity = -1;
     while((entity = FindEntityByClassname(entity, "tf_wearable*")) != -1) {
          if(GetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity") == client) {
               SetEntityRenderMode(entity, RENDER_TRANSCOLOR);
               SetEntityRenderColor(entity, 255, 255, 255, alpha);
          }
     }

     // POWERUPS
     entity = -1;
     while((entity = FindEntityByClassname(entity, "tf_powerup_bottle")) != -1) {
          if(GetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity") == client) {
               SetEntityRenderMode(entity, RENDER_TRANSCOLOR);
               SetEntityRenderColor(entity, 255, 255, 255, alpha);
          }
     }
}