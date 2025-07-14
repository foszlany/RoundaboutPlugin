bool IsGamemodeArena() {
     int gamerules = FindEntityByClassname(-1, "tf_logic_arena");
     if(gamerules != -1) {
          return true;
     }

     char map[64];
     GetCurrentMap(map, sizeof(map));
     return (StrContains(map, "arena_", false) == 0);
}