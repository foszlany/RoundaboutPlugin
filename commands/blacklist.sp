#pragma semicolon 1

public Action Command_Blacklist(int client, int args) {

     return Plugin_Handled;
}

public void LoadBlacklist() {
     g_Blacklist = new StringMap();

     KeyValues kv = new KeyValues("Blacklist");

     if(!kv.ImportFromFile("addons/sourcemod/configs/roundabout_blacklist.cfg")) {
          PrintToServer("Blacklist config not found, creating a new one...");

          CreateDefaultBlacklistConfig();

          if(!kv.ImportFromFile("addons/sourcemod/configs/roundabout_blacklist.cfg")) {
               PrintToServer("Failed to create blacklist config!");
               delete kv;
               return;
          }
     }

     if(kv.GotoFirstSubKey(false)) {
          char effect[32];
          do {
               kv.GetSectionName(effect, sizeof(effect));
               g_Blacklist.SetValue(effect, 1);
          } while (kv.GotoNextKey(false));
     }

     delete kv;
}

void CreateDefaultBlacklistConfig() {
     KeyValues kv = new KeyValues("Blacklist");

     StringMapSnapshot snap = EFFECT_TOKENS.Snapshot();
     int count = snap.Length;

     char key[32];
     for(int i = 0; i < count; i++) {
          snap.GetKey(i, key, sizeof(key));

          kv.JumpToKey(key, true);
          kv.SetString(NULL_STRING, "0");
          kv.GoBack();
     }

     delete snap;

     kv.ExportToFile("addons/sourcemod/configs/roundabout_blacklist.cfg");

     delete kv;
}