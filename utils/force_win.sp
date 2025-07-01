public void ForceWin(TFTeam team) {
     if(team != TFTeam_Red && team != TFTeam_Blue) {
          LogError("[Roundabout] Incorrect team given, can't end round!");
          return;
     }

     int ent = CreateEntityByName("game_round_win");
     if(ent == -1) {
          LogError("[Roundabout] Can't create 'game_round_win', can't end round!");
          return;
     }

     DispatchKeyValue(ent, "force_map_reset", "1");
     DispatchSpawn(ent);

     SetVariantInt(team);
     AcceptEntityInput(ent, "SetTeam");

     AcceptEntityInput(ent, "RoundWin");
}
