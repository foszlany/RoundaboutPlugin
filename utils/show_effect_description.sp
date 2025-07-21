#pragma semicolon 1

public void ShowCurrentEffectDescriptionToAll(int id) {
     for(int i = 1; i <= MaxClients; i++) {
          if(IsClientInGame(i) && !IsFakeClient(i)) {
               ShowCurrentEffectDescription(i, id);
          }
     }
}

public void ShowCurrentEffectDescription(int client, int id) {
     if(id == -1) {
          id = g_CurrentEffect;
     }

     switch(id) {
          case EFFECT_PURE: {
               char message[256];
               Format(message, sizeof(message), "Pure\n\nThe vanilla TF2 experience we all love%s", (g_Effect0_FakePure_Timer == null) ? "." : "?");

               PrintCenterText(client, "Pure");
               ShowHintToClient(client, message);
          }

          case EFFECT_LOWGRAVITY: {
               PrintCenterText(client, "Low Gravity");
               ShowHintToClient(client, "Low Gravity\n\nEnjoy Moon gravity!");
          }

          case EFFECT_MINICRIT: {
               PrintCenterText(client, "Mini-crits");
               ShowHintToClient(client, "Mini-crits\n\nMini-crits for all your heart's desires.");
          }

          case EFFECT_CRIT: {
               PrintCenterText(client, "Criticals");
               ShowHintToClient(client, "Criticals\n\nGuaranteed critical hits.");
          }

          case EFFECT_SPEEDBOOST: {
               PrintCenterText(client, "Speedboost");
               ShowHintToClient(client, "Speedboost\n\nMove faster.");
          }

          case EFFECT_THIRDPERSON: {
               PrintCenterText(client, "Thirdperson");
               ShowHintToClient(client, "Thirdperson\n\nView yourself from outside.");
          }

          case EFFECT_VAMPIRE: {
               PrintCenterText(client, "Vampire");
               ShowHintToClient(client, "Vampire\n\nHeal back 60 percent of all your damage dealt when not overhealed.");
          }

          case EFFECT_SWIM: {
               PrintCenterText(client, "Swim");
               ShowHintToClient(client, "Swim\n\nSwim like the whole map is underwater.");
          }

          case EFFECT_STRONGSUIT: {
               PrintCenterText(client, "Strong Suit");
               ShowHintToClient(client, "Strong Suit\n\nEvery respawn you get a random invulnerability (Bullet, blast or fire)");
          }

          case EFFECT_FORCEMELEE: {
               PrintCenterText(client, "Force Melee");
               ShowHintToClient(client, "Force Melee\n\nYou only have your melee to protect you!");
          }

          case EFFECT_FIREMELEE: {
               PrintCenterText(client, "Fire Aspect");
               ShowHintToClient(client, "Fire Aspect\n\nMelee hits set the enemy on fire for 8 seconds, burning players receive mini-crits.");
          }

          case EFFECT_SCHADENFREUDE: {
               PrintCenterText(client, "Schadenfreude");
               ShowHintToClient(client, "Schadenfreude\n\nAfter each kill, you have a 33 percent chance to taunt.");
          }

          case EFFECT_RNGDEATH: {
               PrintCenterText(client, "Spontaneous Combustion");
               ShowHintToClient(client, "Spontaneous Combustion\n\nYou have a 1 percent chance of dying each second and a rare 0.01 percent chance of everyone dying.");
          }

          case EFFECT_MATH: {
               PrintCenterText(client, "Perfect Math Class");
               ShowHintToClient(client, "Perfect Math Class\n\nYou will sometimes receive a math question. Answer within 8 seconds or die.");
          }

          case EFFECT_WEAKLINGS: {
               PrintCenterText(client, "Weaklings");
               ShowHintToClient(client, "Weaklings\n\nAll damage is reduced to 33 percent.");
          }

          case EFFECT_BLEEDBUFFED: {
               PrintCenterText(client, "Buffed");
               ShowHintToClient(client, "Buffed\n\nAll hits cause 8 seconds of bleed.");
          }

          case EFFECT_ROLEMODEL: {
               PrintCenterText(client, "Role Model");
               ShowHintToClient(client, "Role Model\n\nYou were assigned a class that you're now stuck with.");
          }
          
          case EFFECT_CLASSWARS: {
               PrintCenterText(client, "Class Wars");
               ShowHintToClient(client, "Class Wars\n\nOne class versus another.");
          }

          case EFFECT_SNOWBALL: {
               PrintCenterText(client, "Snowball");
               ShowHintToClient(client, "Snowball\n\nChain kills to receive better temporary effects.");
          }

          case EFFECT_JUSTICE: {
               PrintCenterText(client, "Frontier Justice");
               ShowHintToClient(client, "Frontier Justice\n\nKill the last player who killed you to get crits.");
          }

          case EFFECT_INFECTION: {
               PrintCenterText(client, "Infection Tag");
               ShowHintToClient(client, "Infection Tag\n\nBring killed players into your team and try to win.");
          }

          case EFFECT_DUELIES: {
               PrintCenterText(client, "Duelies");
               ShowHintToClient(client, "Duelies\n\nSometimes you'll receive a duel partner. Kill them or be killed.");
          }

          case EFFECT_HEATWAVE: {
               PrintCenterText(client, "Heatwave");
               ShowHintToClient(client, "Heatwave\n\nTo simulate global warming, you'll all be set on fire periodically.");
          }

          case EFFECT_HYPERHEAL: {
               PrintCenterText(client, "Hyperheal");
               ShowHintToClient(client, "Hyperheal\n\nOverheal infinitely.");
          }
          
          case EFFECT_FORCEFUL: {
               PrintCenterText(client, "Forceful");
               ShowHintToClient(client, "Forceful\n\nIncreased knockback.");
          }

          case EFFECT_ASSASSINS: {
               PrintCenterText(client, "Assassins Indeed");
               ShowHintToClient(client, "Assassins Indeed\n\nOne bullet, one kill.");
          }

          case EFFECT_INCONTROL: {
               PrintCenterText(client, "In Control");
               ShowHintToClient(client, "In Control\n\nIncreased Air Control. All Soldier melee weapons crit while airborne.");
          }

          case EFFECT_BODYCOUNT: {
               PrintCenterText(client, "Bodycount");
               ShowHintToClient(client, "Bodycount\n\nMaximum health is increased by 25 upon killing someone.");
          }

          case EFFECT_SMALL: {
               PrintCenterText(client, "Small");
               ShowHintToClient(client, "Small\n\nReduced size for everyone.");
          }

          case EFFECT_MOSQUITO: {
               PrintCenterText(client, "Mosquito Infestation");
               ShowHintToClient(client, "Mosquito Infestation\n\nYou are all extra annoying.");
          }

          case EFFECT_BALANCED: {
               PrintCenterText(client, "Balanced");
               ShowHintToClient(client, "Balanced\n\nMax health changes based on your team's killcount advantage.");
          }

          case EFFECT_PPERFORM: {
               PrintCenterText(client, "Perilous Performance");
               ShowHintToClient(client, "Perilous Performance\n\nTake increased damage for being good at the game.");
          }

          case EFFECT_SLOWMO: {
               PrintCenterText(client, "Slowmo");
               ShowHintToClient(client, "Slowmo\n\nYou're all in slow motion!");
          }

          case EFFECT_INVIS: {
               PrintCenterText(client, "Invis");
               ShowHintToClient(client, "Invis\n\nWhere's everyone?");
          }

          case EFFECT_SECONDARY: {
               PrintCenterText(client, "Secondary Combat");
               ShowHintToClient(client, "Secondary Combat\n\nYour primary weapons have been taken away.");
          }

          case EFFECT_HELL: {
               PrintCenterText(client, "Hell");
               ShowHintToClient(client, "Hell\n\nGreatly amplified Pyro abilties.");
          }

          case EFFECT_SOCIALDIST: {
               PrintCenterText(client, "Social Distancing");
               ShowHintToClient(client, "Social Distancing\n\nTeammates too close to each other also receive damage.");
          }

          case EFFECT_DISADVANTAGED: {
               PrintCenterText(client, "Disadvantaged");
               ShowHintToClient(client, "Disadvantaged\n\nSome special abilities have been taken away.");
          }

          case EFFECT_NOSCRUBS: {
               PrintCenterText(client, "No Scrubs Allowed");
               ShowHintToClient(client, "No Scrubs Allowed\n\nHeadshot or die.");
          }

          case EFFECT_INFINITECLIP: {
               PrintCenterText(client, "What's a Reload?");
               ShowHintToClient(client, "What's a Reload?\n\nMassively increased clip size.");
          }

          case EFFECT_RESTRICTION: {
               PrintCenterText(client, "Restriction");
               ShowHintToClient(client, "Restriction\n\nSome classes were banned.");
          }

          case EFFECT_NOHUD: {
               PrintCenterText(client, "Incognizance");
               ShowHintToClient(client, "Incognizance\n\nSome HUD elements have been removed.");
          }

          case EFFECT_HORROR: {
               PrintCenterText(client, "Horror Fortress");
               ShowHintToClient(client, "Horror Fortress\n\nEvery copy of Team Fortress 2 is personalized.");
          }

          case EFFECT_SUPERJUMP: {
               PrintCenterText(client, "Super Jump");
               ShowHintToClient(client, "Super Jump\n\nCrouch to perform a big jump! (4.0s delay)");
          }

          case EFFECT_PULLEY: {
               PrintCenterText(client, "Pulley");
               ShowHintToClient(client, "Pulley\n\nDamaging a player will pull them towards you.");
          }

          case EFFECT_ODGLASSCANNON: {
               PrintCenterText(client, "On Demand Glass Cannon");
               ShowHintToClient(client, "On Demand Glass Cannon\n\nThe lower your health, the more you damage!");
          }

          case EFFECT_BUFFERSGAMBIT: {
               PrintCenterText(client, "Buffer's Gambit");
               ShowHintToClient(client, "Buffer's Gambit\n\nCrouch to receive a random (de)buff! (16.0s delay)");
          }

          case EFFECT_SKATINGRINK: {
               PrintCenterText(client, "Skating Rink");
               ShowHintToClient(client, "Skating Rink\n\nSlide around like you're ice skating!");
          }

          case EFFECT_STUNNINGMETAL: {
               PrintCenterText(client, "Stunning Metal");
               ShowHintToClient(client, "Stunning Metal\n\nGreater instances of damage causes slowdown or stun.");
          }

          case EFFECT_DEATHSTARE: {
               PrintCenterText(client, "Death Stare");
               ShowHintToClient(client, "Death Stare\n\nLook each other in the eye and you'll both die.");
          }

          case EFFECT_QUICKSWAP: {
               PrintCenterText(client, "Quickswap");
               ShowHintToClient(client, "Quickswap\n\nYou may randomly swap places with other players.");
          }

          default: {
               return;
          }
     }
}