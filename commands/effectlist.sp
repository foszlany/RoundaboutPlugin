#pragma semicolon 1

public Action Command_EffectList(int client, int args) {     
     Menu menu = new Menu(MenuHandler);
     menu.SetTitle("Effects");
     menu.ExitButton = true;

     for(int i = 0; i < view_as<int>(EFFECT_MAXCOUNT); i++) {
          EffectInfo info;
          char idString[8];
          IntToString(i, idString, sizeof(idString));
          g_EffectInfo.GetArray(idString, info, sizeof(info));

          menu.AddItem(idString, info.name);
     }

     menu.Display(client, MENU_TIME_FOREVER);
     return Plugin_Handled;
}

public int MenuHandler(Menu menu, MenuAction action, int client, int item) {
     if(action == MenuAction_Select) {
          char idString[8];
          menu.GetItem(item, idString, sizeof(idString));

          ShowEffectDetailsMenu(client, idString);
     }
     else if(action == MenuAction_End) {
          delete menu;
     }

     return 0;
}

public void ShowEffectDetailsMenu(int client, const char[] idString) {
     EffectInfo info;
     g_EffectInfo.GetArray(idString, info, sizeof(info));

     Menu menu = new Menu(EffectDetailsHandler);
     menu.ExitButton = false;

     char token[32];
     EFFECT_TOKENS.GetKey(idString, token, sizeof(token));

     char title[128];
     Format(title, sizeof(title), "%s\n \n%s\n \nToken: %s\n ", info.name, info.description, token);
     menu.SetTitle(title);

     menu.AddItem("back", "Back");
     menu.Display(client, MENU_TIME_FOREVER);
}

public int EffectDetailsHandler(Menu menu, MenuAction action, int client, int item) {
     if(action == MenuAction_Select) {
          char info[32];
          menu.GetItem(item, info, sizeof(info));

          if(StrEqual(info, "back")) {
               Command_EffectList(client, 0);
          }
          else {
               ShowEffectDetailsMenu(client, info);
          }
     }
     else if(action == MenuAction_End) {
          delete menu;
     }

     return 0;
}
