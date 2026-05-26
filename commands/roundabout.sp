public Action Command_Roundabout(int client, int args) {
     if(args <= 0) {
          ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Available parameters: effect, effectlist, github, help, version, voteskip");
          return Plugin_Handled;
     }

     char arg1[32];
     GetCmdArg(1, arg1, sizeof(arg1));
     StringToLower(arg1);

     char newCommand[256];
     
     if(StrEqual(arg1, "help") || StrEqual(arg1, "h")) {
          Format(newCommand, sizeof(newCommand), "sm_roundabout_help");
     }
     else if(StrEqual(arg1, "force") || StrEqual(arg1, "f")) {
          Format(newCommand, sizeof(newCommand), "sm_roundabout_force");
     }
     else if(StrEqual(arg1, "effect") || StrEqual(arg1, "e")) {
          Format(newCommand, sizeof(newCommand), "sm_roundabout_effect");
     }
     else if(StrEqual(arg1, "effectlist") || StrEqual(arg1, "el")) {
          Format(newCommand, sizeof(newCommand), "sm_roundabout_effectlist");
     }
     else if(StrEqual(arg1, "github") || StrEqual(arg1, "gh")) {
          Format(newCommand, sizeof(newCommand), "sm_roundabout_github");
     }
     else if(StrEqual(arg1, "version") || StrEqual(arg1, "v")) {
          Format(newCommand, sizeof(newCommand), "sm_roundabout_version");
     }
     else if(StrEqual(arg1, "voteskip") || StrEqual(arg1, "vs")) {
          Format(newCommand, sizeof(newCommand), "sm_roundabout_voteskip");
     }
     else if(StrEqual(arg1, "enable")) {
          Format(newCommand, sizeof(newCommand), "sm_roundabout_enable");
     }
     else {
          ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Unknown parameter '%s'. Use 'help' for options.", arg1);
          return Plugin_Handled;
     }
     
     for(int i = 2; i <= args; i++) {
          char argPart[64];
          GetCmdArg(i, argPart, sizeof(argPart));
          StrCat(newCommand, sizeof(newCommand), " ");
          StrCat(newCommand, sizeof(newCommand), argPart);
     }

     FakeClientCommand(client, newCommand);
     return Plugin_Handled;
}