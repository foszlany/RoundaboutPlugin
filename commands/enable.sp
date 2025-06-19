public Action Command_EnablePlugin(int client, int args) {
     if(args <= 0) {
          ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Usage: !roundabout_enable <1 | 0>")
          return Plugin_Handled;
     }

     char arg[128];
     GetCmdArgString(arg, sizeof(arg));

     int val;
     int parseCount = StringToIntEx(arg, val);
     if(parseCount <= 0 || parseCount != strlen(arg)) {
          ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Argument must be an integer");
          return Plugin_Handled;
     }
     else if(val < 0 || val > 1) {
          ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Argument must be between 0 and 1");
          return Plugin_Handled;
     }

     g_EnablePlugin.SetInt(val);

     return Plugin_Handled;
}