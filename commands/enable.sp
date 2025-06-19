public Action Command_EnablePlugin(int client, int args)
{
     if(args < 1) {
          ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Usage: sm_roundabout_enable <1|0>");
          return Plugin_Handled;
     }

     char arg[128];
     GetCmdArg(1, arg, sizeof(arg));

     int val = StringToInt(arg);
     if(val != 0 && val != 1) {
          ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Argument must be 0 or 1");
          return Plugin_Handled;
     }

     SetConVarInt(g_EnablePlugin, val, true);
     ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Plugin %s", val ? "enabled" : "disabled");

     return Plugin_Handled;
}