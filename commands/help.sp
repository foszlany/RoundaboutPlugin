#pragma semicolon 1

public Action Command_Help(int client, int args) {
     PrintToConsole(client, "\n################# ROUNDABOUT COMMAND LIST #################");

     PrintToConsole(client, "[Roundabout ADMIN] roundabout_enable <arg> - Enables or disables the plugin effects.");
     PrintToConsole(client, "[Roundabout ADMIN] roundabout_force <id> - Forces a new round with a desired effect");
     PrintToConsole(client, "[Roundabout USER] roundabout_help - Returns the commands that can be used into the player's console.");
     PrintToConsole(client, "[Roundabout USER] roundabout_github - Returns the link to the GitHub repository.");
     PrintToConsole(client, "[Roundabout USER] roundabout_version - Returns the version of the plugin.");
     PrintToConsole(client, "[Roundabout USER] roundabout_effectlist - Returns the effect doc.");
     PrintToConsole(client, "[Roundabout USER] roundabout_effect <id> - Shows the effect details on the screen.");
     
     PrintToConsole(client, "################# ROUNDABOUT COMMAND LIST #################\n");

     ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Check console.");
     return Plugin_Handled;
}