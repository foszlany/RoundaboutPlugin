#pragma semicolon 1

public Action Command_Version(int client, int args) {
     ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Version: %s", PLUGIN_VERSION);
     return Plugin_Handled;
}