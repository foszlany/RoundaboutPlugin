void CreateTeleportParticle(int client, const char[] particleName, float duration) {
     float pos[3], ang[3];

     GetClientAbsOrigin(client, pos);
     GetClientAbsAngles(client, ang);

     pos[2] += 2.0;

     int particle = CreateEntityByName("info_particle_system");

     if(IsValidEntity(particle)) {
          DispatchKeyValue(particle, "effect_name", particleName);
          DispatchSpawn(particle);
          
          TeleportEntity(particle, pos, ang, NULL_VECTOR);
          ActivateEntity(particle);
          AcceptEntityInput(particle, "Start");
          
          CreateTimer(duration, Timer_RemoveEntity, EntIndexToEntRef(particle));
     }
}

public Action Timer_RemoveEntity(Handle timer, any entref) {
     int entity = EntRefToEntIndex(entref);
     if (entity != INVALID_ENT_REFERENCE) {
          RemoveEntity(entity);
     }

     return Plugin_Handled;
}