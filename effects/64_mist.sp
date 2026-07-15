#pragma semicolon 1

#define E64_RARE_CHANCE 6
#define E64_FOG_START 0.0
#define E64_FOG_BLEND 1
#define E64_FOG_MIN_END 400.0
#define E64_FOG_MAX_END 800.0
#define E64_FOG_MIN_MAXDENSITY 0.4
#define E64_FOG_MAX_MAXDENSITY 0.7

public void Event_RoundStart_64_Mist(Event event, const char[] name, bool dontBroadcast) {
     g_Effect64_Fog = E64_CreateFog();

     for(int i = 1; i <= MaxClients; i++) {
		if(IsClientInGame(i) && IsPlayerAlive(i)) {
               SetVariantString("mist");
			AcceptEntityInput(i, "SetFogController");
          }
     }
}

public void Event_PlayerUpdate_64_Mist(Event event, const char[] name, bool dontBroadcast) {
     int client = GetClientOfUserId(event.GetInt("userid"));

     SetVariantString("mist");
     AcceptEntityInput(client, "SetFogController");
}

public void Event_RoundEnd_64_Mist(Event event, const char[] name, bool dontBroadcast) {
     AcceptEntityInput(g_Effect64_Fog, "kill");
}

public int E64_CreateFog() {
	new fog = CreateEntityByName("env_fog_controller");

	if(fog != -1) {
          DispatchKeyValue(fog, "targetname", "mist");
		DispatchKeyValueInt(fog, "fogenable", 1);
		DispatchKeyValueInt(fog, "fogblend", E64_FOG_BLEND);
          DispatchKeyValueFloat(fog, "fogstart", E64_FOG_START);
		DispatchKeyValueFloat(fog, "fogend", GetRandomFloat(E64_FOG_MIN_END, E64_FOG_MAX_END));
          DispatchKeyValueFloat(fog, "fogmaxdensity", GetRandomFloat(E64_FOG_MIN_MAXDENSITY, E64_FOG_MAX_MAXDENSITY));

          if(IsRareEffectForced(EFFECT_MIST) || GetRandomInt(0, 100) <= E64_RARE_CHANCE) {
               int r = GetRandomInt(0, 255);
               int g = GetRandomInt(0, 255);
               int b = GetRandomInt(0, 255);

               char randomColor[20];
               Format(randomColor, sizeof(randomColor), "%d %d %d", r, g, b);
               DispatchKeyValue(fog, "fogcolor", randomColor);
               DispatchKeyValue(fog, "fogcolor2", randomColor);

               PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Fog has received a random color.");
          }
          else {
               DispatchKeyValue(fog, "fogcolor", "216 207 194");
               DispatchKeyValue(fog, "fogcolor2", "216 207 194");
          }

		DispatchSpawn(fog);
		AcceptEntityInput(fog, "TurnOn");
	}

	return fog;
}