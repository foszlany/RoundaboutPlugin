#pragma semicolon 1

public Action Command_ForceRound(int client, int args) {
	bool isEnabled = g_CVAR_EnablePlugin.BoolValue;
	if(!isEnabled) {
		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Plugin effects are currently disabled.");
		return Plugin_Handled;
	}

	char arg1[32];
	char arg2[32];
	if(args >= 2) {
		GetCmdArg(1, arg1, sizeof(arg1));
		GetCmdArg(2, arg2, sizeof(arg2));
	}

	// Force single random
	if(args <= 0) {
		g_CurrentEffects[0] = view_as<Effect>(GetRandomInt(0, EFFECT_MAXCOUNT - EFFECT_LOWGRAVITY));

		g_isForced = true;
		g_isForcedRandom = true;

		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect with id %d has been applied. Restarting round.", g_CurrentEffects[0]);
		ServerCommand("mp_restartgame 1");
	}

	// Force multiple random
	else if(args >= 2 && (StrEqual(arg1, "count", false) || StrEqual(arg1, "c", false))) {
		if(args > 2) {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Usage: !roundabout_force count <n>");
			return Plugin_Handled;
		}

		int n;
		int parsed = StringToIntEx(arg2, n);

		if(parsed <= 0 || parsed != strlen(arg2)) {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 '%s' is not a valid integer.", arg2);
			return Plugin_Handled;
		}

		if(n < 1 || n > MAX_MULTIEFFECT_COUNT) {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Count must be between 1 and %d.", MAX_MULTIEFFECT_COUNT);
			return Plugin_Handled;
		}

		// Generate random effects
		g_EffectCount = n;
		for(int i = 0; i < g_EffectCount; i++) {
			g_CurrentEffects[i] = view_as<Effect>(GetRandomInt(0, view_as<int>(EFFECT_MAXCOUNT) - 1));
		}

		g_isForced = true;
		g_isForcedRandom = true;

		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Generated %d random effects. Restarting round.", n);
		ServerCommand("mp_restartgame 1");
	}

	// Force multiple specific
	else {
		char arg[128];
		GetCmdArgString(arg, sizeof(arg));

		char parts[MAX_MULTIEFFECT_COUNT + 1][16];
		int count = ExplodeString(arg, " ", parts, sizeof(parts), sizeof(parts[]));

		if(count > MAX_MULTIEFFECT_COUNT) {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 You must specify between 1 and %d effect IDs.", MAX_MULTIEFFECT_COUNT);
			return Plugin_Handled;
		}

		ArrayList ids = new ArrayList();
		bool isMutuallyExclusivePresent = false;
		int mutuallyExclusiveEffect = -1;

		for(int i = 0; i < count; i++) {
			int id;
			int parsed = StringToIntEx(parts[i], id);

			if(parsed <= 0 || parsed != strlen(parts[i])) {
				ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 '%s' is not a valid integer.", parts[i]);
				return Plugin_Handled;
			}

			if(id < 0 || id >= view_as<int>(EFFECT_MAXCOUNT)) {
				ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect ID must be between 0 and %d.", id, view_as<int>(EFFECT_MAXCOUNT) - 1);
				return Plugin_Handled;
			}

			if(MULTIEFFECT_EXCLUDED.FindValue(id) != -1) {
				ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect ID %d cannot be forced with other effects.", id);
				return Plugin_Handled;
			}

			if(ids.FindValue(id) != -1) {
				ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect ID %d is duplicate.", id);
				return Plugin_Handled;
			}

			if(MULTIEFFECT_MUTUALLY_EXCLUSIVE.FindValue(id) != -1) {
				if(isMutuallyExclusivePresent) {
					ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Mutually exclusive effects %d and %d cannot be forced.", mutuallyExclusiveEffect, id);
					return Plugin_Handled;
				}
				else {
					isMutuallyExclusivePresent = true;
					mutuallyExclusiveEffect = id;
				}
			}

			ids.Push(id);
		}

		g_EffectCount = count;
		for(int i = 0; i < count; i++) {
			g_CurrentEffects[i] = view_as<Effect>(ids.Get(i));
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