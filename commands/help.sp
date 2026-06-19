#pragma semicolon 1

public Action Command_Help(int client, int args) {
     PrintToConsole(client, "\n################# ROUNDABOUT COMMAND LIST #################");

     if(CheckCommandAccess(client, "roundabout_enable", ADMFLAG_ROOT | ADMFLAG_CHEATS)) {
          PrintToConsole(client, "[ROOT] roundabout_enable <arg> - Enables or disables the plugin effects.");
     }
     if(CheckCommandAccess(client, "roundabout_blacklist", ADMFLAG_ROOT | ADMFLAG_CHEATS)) {
          PrintToConsole(client, "[ROOT] roundabout_blacklist [<on|off> || <add|remove> <id>] - Manage the blacklist.");
     }
     if(CheckCommandAccess(client, "roundabout_force", ADMFLAG_GENERIC)) {
          PrintToConsole(client, "[ADMIN] roundabout_force [c|count <n> || <token...>[r]] - Forces a new round with a desired effect.");
     }

     PrintToConsole(client, "[USER] roundabout - Universal command that can invoke every other command and supports shorthand form.");
     PrintToConsole(client, "[USER] roundabout_help - Returns the commands that can be used into the player's console.");
     PrintToConsole(client, "[USER] roundabout_github - Returns the link to the GitHub repository.");
     PrintToConsole(client, "[USER] roundabout_version - Returns the version of the plugin.");
     PrintToConsole(client, "[USER] roundabout_effectlist - Returns the effect documentation.");
     PrintToConsole(client, "[USER] roundabout_voteskip - Initiates a vote to skip the current effect.");
     PrintToConsole(client, "[USER] roundabout_effect <id> - Shows the effect details on the screen.");
     
     PrintToConsole(client, "################# ROUNDABOUT COMMAND LIST #################\n");

     ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Check console.");
     return Plugin_Handled;
}