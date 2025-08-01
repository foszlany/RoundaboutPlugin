#pragma semicolon 1

public Action Command_ForceRound(int client, int args) {
	bool isEnabled = g_CVAR_EnablePlugin.BoolValue;
	if(!isEnabled) {
		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Plugin effects are currently disabled.");
		return Plugin_Handled;
	}

	if(args <= 0) {
		g_ForceRoundEffect = view_as<Effect>(GetRandomInt(0, EFFECT_MAXCOUNT - EFFECT_LOWGRAVITY));
		g_WasForceRandom = true;

		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect with id %d has been applied. Round is restarting.", g_ForceRoundEffect);
		ServerCommand("mp_restartgame 1");
	}
	else if(args >= 2) {
		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Usage: !roundabout_force <id>");
	}
	else {
		char arg[128];
		GetCmdArgString(arg, sizeof(arg));

		int id;
		int parseCount = StringToIntEx(arg, id);
		if(parseCount <= 0 || parseCount != strlen(arg)) {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect ID must be an integer");
			return Plugin_Handled;
		}
		else if(id < 0 || id >= view_as<int>(EFFECT_MAXCOUNT)) {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect ID must be between 0 and %d", EFFECT_MAXCOUNT - EFFECT_LOWGRAVITY);
			return Plugin_Handled;
		}

		g_ForceRoundEffect = view_as<Effect>(id);

		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect with id %d has been applied. Round is restarting.", id);
		ServerCommand("mp_restartgame 1");
	}
	return Plugin_Handled;
}