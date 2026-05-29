#pragma semicolon 1

public Action Command_Blacklist(int client, int args) {
     if(args <= 0) {
          if(g_Blacklist.Size == 0) {
               PrintToChat(client, "\x07B143F1[Roundabout]\x01 No blacklist was loaded.");
          }

          StringMapSnapshot snap = g_Blacklist.Snapshot();
          char key[32];
          int value;

          char buffer[256];
          buffer[0] = '\0';

          for(int i = 0; i < snap.Length; i++) {
               snap.GetKey(i, key, sizeof(key));
               g_Blacklist.GetValue(key, value);

               if(i == 0) {
                    Format(buffer, sizeof(buffer), "%s", key);
               }
               else {
                    Format(buffer, sizeof(buffer), "%s, %s", buffer, key);
               }
                    
          }

          PrintToChat(client, "\x07B143F1[Roundabout]\x01 Blacklisted effects: %s", buffer);
     }

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
          char valueStr[8];
          int value;

          do {
               kv.GetSectionName(effect, sizeof(effect));
               kv.GetString(NULL_STRING, valueStr, sizeof(valueStr), "0");

               value = StringToInt(valueStr);

               if(value == 1) {
                    g_Blacklist.SetValue(effect, 1);
               }

          } while(kv.GotoNextKey(false));
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

void AddElementToConfig(bool isBlacklisted) {
     
}