#pragma semicolon 1

public void ShowCurrentEffectDescriptionToAll() {
    ShowCurrentEffectDescription(-1);
}

public void ShowCurrentEffectDescription(int client) {
     if(g_EffectCount > 1) {
          for(int i = 0; i < g_EffectCount; i++) {
               Effect id = g_CurrentEffects[i];
               PrintEffectChat(client, id);
          }
          return;
     }

     Effect id = g_CurrentEffects[0];
     PrintEffectChat(client, id);
}

public void ShowEffectDescription(int client, Effect id) {
     PrintEffectChat(client, id);
}

public void PrintEffectChat(int client, Effect id) {
     if(id == EFFECT_INVALID) {
          return;
     }

     EffectInfo info;
     char idString[8];
     IntToString(id, idString, sizeof(idString));
     if(!g_EffectInfo.GetArray(idString, info, sizeof(info))) {
          return;
     }

     if(id == EFFECT_PURE) {
          char desc[64];
          Format(desc, sizeof(desc), info.description, (g_Effect0_FakePure_Timer == null) ? "." : "?");

          PrintEffectLine(client, info.name, desc);
          return;
     }

     PrintEffectLine(client, info.name, info.description);
}

public void PrintEffectLine(int client, const char[] name, const char[] desc) {
     if(client <= 0) {
          PrintToChatAll("\x07B143F1[Roundabout]\x01 \x07F5BB27%s:\x01 %s", name, desc);

          if(g_EffectCount == 1) {
               PrintCenterTextAll("%s", name);
          }
          else {
               PrintCenterTextAll("Multieffect");
          }
     }
     else {
          PrintToChat(client, "\x07B143F1[Roundabout]\x01 \x07F5BB27%s:\x01 %s", name, desc);
          
          if(g_EffectCount == 1) {
               PrintCenterText(client, "%s", name);
          }
          else {
               PrintCenterText(client, "Multieffect");
          }
     }
}
