#pragma semicolon 1

#define E63_RARE_CHANCE 3
#define E63_RARE_SPELL_DROP_RATE 1.0
#define E63_BASE_SPELL_DROP_RATE 0.2

public void Event_RoundStart_63_Spellbound(Event event, const char[] name, bool dontBroadcast) {
     ConVar spells = FindConVar("tf_spells_enabled");
     int flags = spells.Flags;
     spells.Flags = flags & ~FCVAR_NOTIFY;
     SetConVarBool(spells, true);
     spells.Flags = flags;

     ConVar spellChance = FindConVar("tf_player_spell_drop_on_death_rate");

     if(IsRareEffectForced(EFFECT_SPELLBOUND) || GetRandomInt(0, 100) <= E63_RARE_CHANCE) {
          SetConVarFloat(spellChance, E63_RARE_SPELL_DROP_RATE);
          PrintToChatAll("\x07B143F1[Roundabout]\x01 Special round! Spell drops are guaranteed.");
     }
     else {
          SetConVarFloat(spellChance, E63_BASE_SPELL_DROP_RATE);
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