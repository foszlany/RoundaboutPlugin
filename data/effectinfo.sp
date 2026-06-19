enum struct EffectInfo {
    char name[32];
    char description[128];
}

EffectInfo CreateEffectInfo(const char name[32], const char desc[128]) {
    EffectInfo info;
    strcopy(info.name, sizeof(info.name), name);
    strcopy(info.description, sizeof(info.description), desc);
    return info;
}

void ADD_EFFECT(id, char name[32], char desc[128]) {
    EffectInfo info;
    info = CreateEffectInfo(name, desc);

    char idString[8];
    IntToString(id, idString, sizeof(idString));

    g_EffectInfo.SetArray(idString, info, sizeof(info));
}

void InitializeEffectInfo() {
    g_EffectInfo = new StringMap();

    ADD_EFFECT(EFFECT_PURE,              "Pure",                     "The vanilla TF2 experience we all love");
    ADD_EFFECT(EFFECT_LOWGRAVITY,        "Low Gravity",              "Enjoy Moon gravity!");
    ADD_EFFECT(EFFECT_MEDIEVAL,          "Medieval",                 "Enjoy ye old times. Good sire!");
    ADD_EFFECT(EFFECT_CRIT,              "Criticals",                "Guaranteed critical hits.");
    ADD_EFFECT(EFFECT_SPEEDBOOST,        "Speedboost",               "Move faster.");
    ADD_EFFECT(EFFECT_THIRDPERSON,       "Thirdperson",              "View yourself from outside.");
    ADD_EFFECT(EFFECT_VAMPIRE,           "Vampire",                  "Heal back 60% of all your damage dealt when not overhealed.");
    ADD_EFFECT(EFFECT_SWIM,              "Swim",                     "Swim like the whole map is underwater.");
    ADD_EFFECT(EFFECT_STRONGSUIT,        "Strong Suit",              "Every respawn you get a random invulnerability (Bullet, blast or fire)");
    ADD_EFFECT(EFFECT_FORCEMELEE,        "Force Melee",              "You only have your melee to protect you!");
    ADD_EFFECT(EFFECT_FIREMELEE,         "Fire Aspect",              "Melee hits set the enemy on fire for 8 seconds, burning players receive mini-crits.");
    ADD_EFFECT(EFFECT_SCHADENFREUDE,     "Schadenfreude",            "After each kill, you have a 33% chance to taunt.");
    ADD_EFFECT(EFFECT_RNGDEATH,          "Spontaneous Combustion",   "You have a 1% chance of dying each second and a rare 0.01% chance of everyone dying.");
    ADD_EFFECT(EFFECT_MATH,              "Perfect Math Class",       "You will sometimes receive a math question. Answer within 8 seconds or die.");
    ADD_EFFECT(EFFECT_WEAKLINGS,         "Weaklings",                "All damage is reduced to 33%.");
    ADD_EFFECT(EFFECT_BLEEDBUFFED,       "Buffed",                   "All hits cause 8 seconds of bleed.");
    ADD_EFFECT(EFFECT_ROLEMODEL,         "Role Model",               "You were assigned a class that you're now stuck with.");
    ADD_EFFECT(EFFECT_CLASSWARS,         "Class Wars",               "One class versus another.");
    ADD_EFFECT(EFFECT_SNOWBALL,          "Snowball",                 "Chain kills to receive better temporary effects.");
    ADD_EFFECT(EFFECT_JUSTICE,           "Frontier Justice",         "Kill the last player who killed you to get crits.");
    ADD_EFFECT(EFFECT_INFECTION,         "Infection Tag",            "Bring killed players into your team and try to win.");
    ADD_EFFECT(EFFECT_DUELIES,           "Duelies",                  "Sometimes you'll receive a duel partner. Kill them or be killed.");
    ADD_EFFECT(EFFECT_HEATWAVE,          "Heatwave",                 "To simulate global warming, you'll all be set on fire periodically.");
    ADD_EFFECT(EFFECT_HYPERHEAL,         "Hyperheal",                "Overheal infinitely.");
    ADD_EFFECT(EFFECT_FORCEFUL,          "Forceful",                 "Increased knockback.");
    ADD_EFFECT(EFFECT_ASSASSINS,         "Assassins Indeed",         "One bullet, one kill.");
    ADD_EFFECT(EFFECT_INCONTROL,         "In Control",               "Increased Air Control. All Soldier melee weapons crit while airborne.");
    ADD_EFFECT(EFFECT_BODYCOUNT,         "Bodycount",                "Maximum health is increased by 25 upon killing someone.");
    ADD_EFFECT(EFFECT_SMALL,             "Small",                    "Reduced size for everyone.");
    ADD_EFFECT(EFFECT_MOSQUITO,          "Mosquito Infestation",     "You are all extra annoying.");
    ADD_EFFECT(EFFECT_BALANCED,          "Balanced",                 "Max health changes based on your team's killcount advantage.");
    ADD_EFFECT(EFFECT_PPERFORM,          "Perilous Performance",     "Take increased damage for being good at the game.");
    ADD_EFFECT(EFFECT_SLOWMO,            "Slowmo",                   "You're all in slow motion!");
    ADD_EFFECT(EFFECT_INVIS,             "Invis",                    "Where's everyone?");
    ADD_EFFECT(EFFECT_SECONDARY,         "Secondary Combat",         "Your primary weapons have been taken away.");
    ADD_EFFECT(EFFECT_HELL,              "Hell",                     "Greatly amplified Pyro abilties.");
    ADD_EFFECT(EFFECT_SOCIALDIST,        "Social Distancing",        "Teammates too close to each other also receive damage.");
    ADD_EFFECT(EFFECT_DISADVANTAGED,     "Disadvantaged",            "Some special abilities have been taken away.");
    ADD_EFFECT(EFFECT_NOSCRUBS,          "No Scrubs Allowed",        "Headshot or die.");
    ADD_EFFECT(EFFECT_INFINITECLIP,      "What's a Reload?",         "Massively increased clip size.");
    ADD_EFFECT(EFFECT_RESTRICTION,       "Restriction",              "Some classes were banned.");
    ADD_EFFECT(EFFECT_NOHUD,             "Incognizance",             "Some HUD elements have been removed.");
    ADD_EFFECT(EFFECT_HORROR,            "Horror Fortress",          "Every copy of Team Fortress 2 is personalized.");
    ADD_EFFECT(EFFECT_SUPERJUMP,         "Super Jump",               "Crouch to perform a big jump! (4.0s cooldown)");
    ADD_EFFECT(EFFECT_PULLEY,            "Pulley",                   "Damaging a player will pull them towards you.");
    ADD_EFFECT(EFFECT_ODGLASSCANNON,     "On Demand Glass Cannon",   "The lower your health, the more you damage!");
    ADD_EFFECT(EFFECT_BUFFERSGAMBIT,     "Buffer's Gambit",          "Call for medic to receive a random (de)buff! (16.0s cooldown)");
    ADD_EFFECT(EFFECT_SKATINGRINK,       "Skating Rink",             "Slide around like you're ice skating!");
    ADD_EFFECT(EFFECT_STUNNINGMETAL,     "Stunning Metal",           "Greater instances of damage causes slowdown or stun.");
    ADD_EFFECT(EFFECT_DEATHSTARE,        "Death Stare",              "Look each other in the eye and you'll both die.");
    ADD_EFFECT(EFFECT_QUICKSWAP,         "Quickswap",                "You may randomly swap places with other players.");
    ADD_EFFECT(EFFECT_MVM,               "Mann vs. Machine",         "Defeat the bots.");
    ADD_EFFECT(EFFECT_PMAYHEM,           "Projectile Mayhem",        "Shoot random projectiles!");
    ADD_EFFECT(EFFECT_SHIELDINGMED,      "Shielding Medicine",       "Medics can now use the shields from MvM.");
    ADD_EFFECT(EFFECT_PIERCINGBULL,      "Piercing Bullets",         "Bullets go through enemies.");
    ADD_EFFECT(EFFECT_ACHIEVEMENT,       "Achievement Hunter",       "Obtaining an achievement grants Powerplay.");
    ADD_EFFECT(EFFECT_BUFFHEAL,          "Buffing Heal",             "Medigun healing is reduced, but they grant Mini-crits.");
    ADD_EFFECT(EFFECT_MEDICCALL,         "Called for me?",           "Call for a medic to aid you.");
    ADD_EFFECT(EFFECT_KING,              "King",                     "One player becomes especially powerful. Fight for the title.");
    ADD_EFFECT(EFFECT_IDENTITYTHEFT,     "Identity Theft",           "You are what you kill.");
    ADD_EFFECT(EFFECT_TIMETRAVEL,        "Time Travel",              "You may occasionally go back in time.");
    ADD_EFFECT(EFFECT_PARRY,             "Parry it!",                "You can now attempt to parry damage by calling for a medic.");
    ADD_EFFECT(EFFECT_GRAPPLINGHOOK,     "Grappling Hook",           "You can now equip the grappling hook.");
    ADD_EFFECT(EFFECT_SPELLBOUND,        "Spellbound",               "The fallen occasionally drop spells.");
}