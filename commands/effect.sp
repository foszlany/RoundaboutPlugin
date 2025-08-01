#pragma semicolon 1

public Action Command_Effect(int client, int args) {
    	bool isEnabled = g_CVAR_EnablePlugin.BoolValue;
	if(!isEnabled) {
		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Plugin effects are currently disabled.");
		return Plugin_Handled;
	}

	if(args <= 0) {
		ShowCurrentEffectDescription(client, g_CurrentEffect);
	}
	else if(args >= 2) {
		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Usage: !roundabout_effect <id>");
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

		ShowCurrentEffectDescription(client, id);
	}

	return Plugin_Handled;
}