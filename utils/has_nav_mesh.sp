public bool HasNavMesh() {
     char mapName[PLATFORM_MAX_PATH];
     GetCurrentMap(mapName, sizeof(mapName));

     char navFile[PLATFORM_MAX_PATH];
     Format(navFile, sizeof(navFile), "maps/%s.nav", mapName);

     return FileExists(navFile);
}