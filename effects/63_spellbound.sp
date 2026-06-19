#pragma semicolon 1

public void Event_RoundStart_63_Spellbound(Event event, const char[] name, bool dontBroadcast) {
     ConVar spells = FindConVar("tf_spells_enabled");
     int flags = spells.Flags;
     spells.Flags = flags & ~FCVAR_NOTIFY;
     SetConVarBool(spells, true);
     spells.Flags = flags;

     ConVar spellChance = FindConVar("tf_player_spell_drop_on_death_rate");

     if(IsRareEffectForced(EFFECT_SPELLBOUND) || GetRandomInt(0, 100) <= 3) {
          SetConVarFloat(spellChance, 1.0);
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Spell drops are guaranteed.");
     }
     else {
          SetConVarFloat(spellChance, 0.2);
     }

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_RegeneratePlayer(i);
          }
     }
}

public void Event_RoundEnd_63_Spellbound(Event event, const char[] name, bool dontBroadcast) {
     ConVar spells = FindConVar("tf_spells_enabled");
     int flags = spells.Flags;
     spells.Flags = flags & ~FCVAR_NOTIFY;
     SetConVarBool(spells, false);
     spells.Flags = flags;

     ConVar spellChance = FindConVar("tf_player_spell_drop_on_death_rate");
     SetConVarFloat(spellChance, 0.0);

     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && IsPlayerAlive(i)) {
               TF2_RegeneratePlayer(i);
          }
     }
}