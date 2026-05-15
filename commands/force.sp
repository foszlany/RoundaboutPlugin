#pragma semicolon 1

public Action Command_ForceRound(int client, int args) {
	bool isEnabled = g_CVAR_EnablePlugin.BoolValue;
	if(!isEnabled) {
		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Plugin effects are currently disabled.");
		return Plugin_Handled;
	}

	if(args <= 0) {
		g_CurrentEffects[0] = view_as<Effect>(GetRandomInt(0, EFFECT_MAXCOUNT - EFFECT_LOWGRAVITY));
		g_isForced = true;
		g_isForcedRandom = true;

		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect with id %d has been applied. Round is restarting.", g_CurrentEffects[0]);
		ServerCommand("mp_restartgame 1");
	}
	else {
		char arg[128];
		GetCmdArgString(arg, sizeof(arg));

		char parts[MAX_STACKED_EFFECTS + 1][16];
		int count = ExplodeString(arg, " ", parts, sizeof(parts), sizeof(parts[]));

		PrintToChatAll("Count: %d", count);

		if(count > MAX_STACKED_EFFECTS) {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 You must specify between 1 and %d effect IDs.", MAX_STACKED_EFFECTS);
			return Plugin_Handled;
		}

		int ids[MAX_STACKED_EFFECTS];

		for(int i = 0; i < count; i++) {
			int id;
			int parsed = StringToIntEx(parts[i], id);

			if(parsed <= 0 || parsed != strlen(parts[i])) {
				ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 '%s' is not a valid integer.", parts[i]);
				return Plugin_Handled;
			}

			if(id < 0 || id >= view_as<int>(EFFECT_MAXCOUNT)) {
				ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect ID %d must be between 0 and %d.", id, view_as<int>(EFFECT_MAXCOUNT) - 1);
				return Plugin_Handled;
			}

			ids[i] = id;
		}

		g_EffectCount = count;
		for(int i = 0; i < count; i++) {
			g_CurrentEffects[i] = view_as<Effect>(ids[i]);
		}

		if(g_EffectCount == 1) {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect with id %d has been applied. Restarting round.", g_CurrentEffects[0]);
		}
		else {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Applied %d effects. Restarting round.", g_EffectCount);
		}

		g_isForced = true;
		ServerCommand("mp_restartgame 1");
	}
	
	return Plugin_Handled;
}