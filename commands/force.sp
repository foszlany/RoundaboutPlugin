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

	// FORCE RANDOM
	if(args <= 0) {
		g_IsForced = true;
		g_IsForcedRandom = true;

		g_EffectCount = RollEffectCount();

		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Generated %d random effects. Restarting round.", g_EffectCount);
		ServerCommand("mp_restartgame 1");
	}

	// FORCE MULTIPLE RANDOM
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

		if(n < 1 || n > MULTIEFFECT_MAX_COUNT) {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Count must be between 1 and %d.", MULTIEFFECT_MAX_COUNT);
			return Plugin_Handled;
		}

		// GENERATE RANDOM EFFECTS
		g_EffectCount = n;
		for(int i = 0; i < g_EffectCount; i++) {
			g_CurrentEffects[i] = view_as<Effect>(GetRandomInt(0, view_as<int>(EFFECT_MAXCOUNT) - 1));
		}

		g_IsForced = true;
		g_IsForcedRandom = true;

		if(g_EffectCount > 5) {
			PrintToChatAll("\x07B143F1[Roundabout]\x01 \x07FB524FHigh effect counts can be unstable. You have been warned.\x01", client, n);
		}
		ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Generated %d random effects. Restarting round.", n);
		ServerCommand("mp_restartgame 1");
	}

	// FORCE MULTIPLE SPECIFIC
	else {
		char arg[128];
		GetCmdArgString(arg, sizeof(arg));

		char parts[MULTIEFFECT_MAX_COUNT + 1][16];
		int count = ExplodeString(arg, " ", parts, sizeof(parts), sizeof(parts[]));

		if(count > MULTIEFFECT_MAX_COUNT) {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 You must specify between 1 and %d effect IDs.", MULTIEFFECT_MAX_COUNT);
			return Plugin_Handled;
		}

		ArrayList ids = new ArrayList();
		ArrayList isRare = new ArrayList();
		bool isMutuallyExclusivePresent = false;
		int mutuallyExclusiveEffect = -1;

		for(int i = 0; i < count; i++) {
			char base[32];
			bool rare = false;

			int len = strlen(parts[i]);

			// RARE SUFFIX
			if(len > 1 && CharToLower(parts[i][len - 1]) == 'r') {
				rare = true;
				strcopy(base, sizeof(base), parts[i]);
				base[len - 1] = '\0';
			}
			else {
				strcopy(base, sizeof(base), parts[i]);
			}

			int id;
			int parsed = StringToIntEx(base, id);

			bool isInteger = (parsed > 0 && parsed == strlen(base));
			bool isToken = EFFECT_TOKENS.ContainsKey(base);

			if(!isInteger && !isToken) {
				ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 '%s' is not a valid integer or token.", parts[i]);
				return Plugin_Handled;
			}

			if(!isInteger) {
				EFFECT_TOKENS.GetValue(base, id);
			}

			isRare.Push(rare);

			if(id < 0 || id >= view_as<int>(EFFECT_MAXCOUNT)) {
				ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect ID must be between 0 and %d.", view_as<int>(EFFECT_MAXCOUNT) - 1);
				return Plugin_Handled;
			}

			if(count > 1 && MULTIEFFECT_EXCLUDED.FindValue(id) != -1) {
				ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect ID %d cannot be forced with other effects.", id);
				return Plugin_Handled;
			}

			if(ids.FindValue(id) != -1) {
				ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect ID %d is duplicate.", id);
				return Plugin_Handled;
			}

			if(count > 1 && MULTIEFFECT_MUTUALLY_EXCLUSIVE.FindValue(id) != -1) {
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
			g_IsForcedRare[i] = isRare.Get(i);
			g_CurrentEffects[i] = view_as<Effect>(ids.Get(i));
		}

		if(g_EffectCount > 5) {
			PrintToChatAll("\x07B143F1[Roundabout]\x01 \x07FB524FHigh effect counts can be unstable. You have been warned.\x01", client, g_EffectCount);
		}

		if(g_EffectCount == 1) {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect with id %d has been applied. Restarting round.", g_CurrentEffects[0]);
		}
		else {
			ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Applied %d effects. Restarting round.", g_EffectCount);
		}

		g_IsForced = true;
		ServerCommand("mp_restartgame 1");
	}
	
	return Plugin_Handled;
}