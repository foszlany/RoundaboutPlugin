#pragma semicolon 1

public void ShowCurrentEffectDescription(int id) {
     if(id == -1) {
          id = g_CurrentEffect;
     }

     switch(id) {
          case EFFECT_PURE: {
               char message[256];
               Format(message, sizeof(message), "Pure\n\nThe vanilla TF2 experience we all love%s", (g_Effect0_FakePure_Timer == null) ? "." : "?");

               PrintCenterTextAll("Pure");
               ShowHintToAllClients(message);
          }

          case EFFECT_LOWGRAVITY: {
               PrintCenterTextAll("Low Gravity");
               ShowHintToAllClients("Low Gravity\n\nEnjoy Moon gravity!");
          }

          case EFFECT_MINICRIT: {
               PrintCenterTextAll("Mini-crits");
               ShowHintToAllClients("Mini-crits\n\nMini-crits for all your heart's desires.");
          }

          case EFFECT_CRIT: {
               PrintCenterTextAll("Criticals");
               ShowHintToAllClients("Criticals\n\nGuaranteed critical hits.");
          }

          case EFFECT_SPEEDBOOST: {
               PrintCenterTextAll("Speedboost");
               ShowHintToAllClients("Speedboost\n\nMove faster.");
          }

          case EFFECT_THIRDPERSON: {
               PrintCenterTextAll("Thirdperson");
               ShowHintToAllClients("Thirdperson\n\nView yourself from outside.");
          }

          case EFFECT_VAMPIRE: {
               PrintCenterTextAll("Vampire");
               ShowHintToAllClients("Vampire\n\nHeal back 60 percent of all your damage dealt when not overhealed.");
          }

          case EFFECT_SWIM: {
               PrintCenterTextAll("Swim");
               ShowHintToAllClients("Swim\n\nSwim like the whole map is underwater.");
          }

          case EFFECT_STRONGSUIT: {
               PrintCenterTextAll("Strong Suit");
               ShowHintToAllClients("Strong Suit\n\nEvery respawn you get a random invulnerability (Bullet, blast or fire)");
          }

          case EFFECT_FORCEMELEE: {
               PrintCenterTextAll("Force Melee");
               ShowHintToAllClients("Force Melee\n\nYou only have your melee to protect you!");
          }

          case EFFECT_FIREMELEE: {
               PrintCenterTextAll("Fire Aspect");
               ShowHintToAllClients("Fire Aspect\n\nMelee hits set the enemy on fire for 8 seconds, burning players receive mini-crits.");
          }

          case EFFECT_SCHADENFREUDE: {
               PrintCenterTextAll("Schadenfreude");
               ShowHintToAllClients("Schadenfreude\n\nAfter each kill, you have a 33 percent chance to taunt.");
          }

          case EFFECT_RNGDEATH: {
               PrintCenterTextAll("Spontaneous Combustion");
               ShowHintToAllClients("Spontaneous Combustion\n\nYou have a 1 percent chance of dying each second and a rare 0.01 percent chance of everyone dying.");
          }

          case EFFECT_MATH: {
               PrintCenterTextAll("Perfect Math Class");
               ShowHintToAllClients("Perfect Math Class\n\nYou will sometimes receive a math question. Answer within 8 seconds or die.");
          }

          case EFFECT_WEAKLINGS: {
               PrintCenterTextAll("Weaklings");
               ShowHintToAllClients("Weaklings\n\nAll damage is reduced to 33 percent.");
          }

          case EFFECT_BLEEDBUFFED: {
               PrintCenterTextAll("Buffed");
               ShowHintToAllClients("Buffed\n\nAll hits cause 8 seconds of bleed.");
          }

          case EFFECT_ROLEMODEL: {
               PrintCenterTextAll("Role Model");
               ShowHintToAllClients("Role Model\n\nYou were assigned a class that you're now stuck with.");
          }
          
          case EFFECT_CLASSWARS: {
               PrintCenterTextAll("Class Wars");
               ShowHintToAllClients("Class Wars\n\nOne class versus another.");
          }

          case EFFECT_SNOWBALL: {
               PrintCenterTextAll("Snowball");
               ShowHintToAllClients("Snowball\n\nChain kills to receive better temporary effects.");
          }

          case EFFECT_JUSTICE: {
               PrintCenterTextAll("Frontier Justice");
               ShowHintToAllClients("Frontier Justice\n\nKill the last player who killed you to get crits.");
          }

          case EFFECT_INFECTION: {
               PrintCenterTextAll("Infection Tag");
               ShowHintToAllClients("Infection Tag\n\nBring killed players into your team and try to win.");
          }

          case EFFECT_DUELIES: {
               PrintCenterTextAll("Duelies");
               ShowHintToAllClients("Duelies\n\nSometimes you'll receive a duel partner. Kill them or be killed.");
          }

          case EFFECT_HEATWAVE: {
               PrintCenterTextAll("Heatwave");
               ShowHintToAllClients("Heatwave\n\nTo simulate global warming, you'll all be set on fire periodically.");
          }

          case EFFECT_HYPERHEAL: {
               PrintCenterTextAll("Hyperheal");
               ShowHintToAllClients("Hyperheal\n\nOverheal infinitely.");
          }
          
          case EFFECT_FORCEFUL: {
               PrintCenterTextAll("Forceful");
               ShowHintToAllClients("Forceful\n\nIncreased knockback.");
          }

          case EFFECT_ASSASSINS: {
               PrintCenterTextAll("Assassins Indeed");
               ShowHintToAllClients("Assassins Indeed\n\nOne bullet, one kill.");
          }

          case EFFECT_INCONTROL: {
               PrintCenterTextAll("In Control");
               ShowHintToAllClients("In Control\n\nIncreased Air Control. All Soldier melee weapons crit while airborne.");
          }

          case EFFECT_BODYCOUNT: {
               PrintCenterTextAll("Bodycount");
               ShowHintToAllClients("Bodycount\n\nMaximum health is increased by 25 upon killing someone.");
          }

          case EFFECT_SMALL: {
               PrintCenterTextAll("Small");
               ShowHintToAllClients("Small\n\nReduced size for everyone.");
          }

          case EFFECT_MOSQUITO: {
               PrintCenterTextAll("Mosquito Infestation");
               ShowHintToAllClients("Mosquito Infestation\n\nYou are all extra annoying.");
          }

          case EFFECT_BALANCED: {
               PrintCenterTextAll("Balanced");
               ShowHintToAllClients("Balanced\n\nMax health changes based on your team's killcount advantage.");
          }

          case EFFECT_PPERFORM: {
               PrintCenterTextAll("Perilous Performance");
               ShowHintToAllClients("Perilous Performance\n\nTake increased damage for being good at the game.");
          }

          case EFFECT_SLOWMO: {
               PrintCenterTextAll("Slowmo");
               ShowHintToAllClients("Slowmo\n\nYou're all in slow motion!");
          }

          case EFFECT_INVIS: {
               PrintCenterTextAll("Invis");
               ShowHintToAllClients("Invis\n\nWhere's everyone?");
          }

          case EFFECT_SECONDARY: {
               PrintCenterTextAll("Secondary Combat");
               ShowHintToAllClients("Secondary Combat\n\nYour primary weapons have been taken away.");
          }

          case EFFECT_HELL: {
               PrintCenterTextAll("Hell");
               ShowHintToAllClients("Hell\n\nGreatly amplified Pyro abilties.");
          }

          case EFFECT_SOCIALDIST: {
               PrintCenterTextAll("Social Distancing");
               ShowHintToAllClients("Social Distancing\n\nTeammates too close to each other also receive damage.");
          }

          case EFFECT_DISADVANTAGED: {
               PrintCenterTextAll("Disadvantaged");
               ShowHintToAllClients("Disadvantaged\n\nSome special abilities have been taken away.");
          }

          case EFFECT_NOSCRUBS: {
               PrintCenterTextAll("No Scrubs Allowed");
               ShowHintToAllClients("No Scrubs Allowed\n\nHeadshot or die.");
          }

          case EFFECT_INFINITECLIP: {
               PrintCenterTextAll("What's a Reload?");
               ShowHintToAllClients("What's a Reload?\n\nMassively increased clip size.");
          }

          case EFFECT_RESTRICTION: {
               PrintCenterTextAll("Restriction");
               ShowHintToAllClients("Restriction\n\nSome classes were banned.");
          }

          case EFFECT_NOHUD: {
               PrintCenterTextAll("Incognizance");
               ShowHintToAllClients("Incognizance\n\nSome HUD elements have been removed.");
          }

          case EFFECT_HORROR: {
               PrintCenterTextAll("Horror Fortress");
               ShowHintToAllClients("Horror Fortress\n\nEvery copy of Team Fortress 2 is personalized.");
          }

          case EFFECT_SUPERJUMP: {
               PrintCenterTextAll("Super Jump");
               ShowHintToAllClients("Super Jump\n\nCrouch to perform a big jump! (4.0s delay)");
          }

          case EFFECT_PULLEY: {
               PrintCenterTextAll("Pulley");
               ShowHintToAllClients("Pulley\n\nDamaging a player will pull them towards you.");
          }

          case EFFECT_ODGLASSCANNON: {
               PrintCenterTextAll("On Demand Glass Cannon");
               ShowHintToAllClients("On Demand Glass Cannon\n\nThe lower your health, the more you damage!");
          }

          case EFFECT_BUFFERSGAMBIT: {
               PrintCenterTextAll("Buffer's Gambit");
               ShowHintToAllClients("Buffer's Gambit\n\nCrouch to receive a random (de)buff! (16.0s delay)");
          }

          case EFFECT_SKATINGRINK: {
               PrintCenterTextAll("Skating Rink");
               ShowHintToAllClients("Skating Rink\n\nSlide around like you're ice skating!");
          }

          case EFFECT_STUNNINGMETAL: {
               PrintCenterTextAll("Stunning Metal");
               ShowHintToAllClients("Stunning Metal\n\nGreater instances of damage causes slowdown or stun.");
          }

          case EFFECT_DEATHSTARE: {
               PrintCenterTextAll("Death Stare");
               ShowHintToAllClients("Death Stare\n\nLook each other in the eye and you'll both die.");
          }

          case EFFECT_QUICKSWAP: {
               PrintCenterTextAll("Quickswap");
               ShowHintToAllClients("Quickswap\n\nYou may randomly swap places with other players.");
          }

          default: {
               return;
          }
     }
}