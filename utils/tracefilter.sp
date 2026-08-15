public bool TraceFilter_WorldOnly(int entity, int contentsMask) {
     return (entity == 0);
}

public bool TraceFilter_EntityPlayers(int entity, int contentsMask) {
    return entity > MaxClients;
}

public bool TraceFilter_Players(int entity, int mask, any data) {
     if(entity == data) {
          return false;
     }
     
     return true;
}
