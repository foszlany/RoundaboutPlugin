#pragma semicolon 1

public Effect setEffect(Effect id) {
     bool isForced = id >= EFFECT_PURE && id < EFFECT_MAXCOUNT;
     int activePlayers = CountActivePlayers();

     if(!(id >= EFFECT_PURE && id < EFFECT_MAXCOUNT)) {
          id = view_as<Effect>(GetRandomInt(0, EFFECT_MAXCOUNT - EFFECT_LOWGRAVITY));
     }

     switch(id) {
          case EFFECT_PURE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_0_Pure;
               g_OnRoundEndFuncPtr = Event_RoundEnd_0_Pure;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_0_Pure;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_LOWGRAVITY: {
               ConVar gravity = FindConVar("sv_gravity");
               int currentGravity = GetConVarInt(gravity);

               if(currentGravity <= 400) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Low Gravity effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Low Gravity effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_1_LowGravity;
               g_OnRoundEndFuncPtr = Event_RoundEnd_1_LowGravity;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_MINICRIT: {
               g_OnRoundStartFuncPtr = Event_RoundStart_2_MiniCrit;
               g_OnRoundEndFuncPtr = Event_RoundEnd_2_MiniCrit;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_2_MiniCrit;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_CRIT: {
               g_OnRoundStartFuncPtr = Event_RoundStart_3_Crit;
               g_OnRoundEndFuncPtr = Event_RoundEnd_3_Crit;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_3_Crit;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_SPEEDBOOST: {
               g_OnRoundStartFuncPtr = Event_RoundStart_4_SpeedBoost;
               g_OnRoundEndFuncPtr = Event_RoundEnd_4_SpeedBoost;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_4_SpeedBoost;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_THIRDPERSON: {
               g_OnRoundStartFuncPtr = Event_RoundStart_5_ThirdPerson;
               g_OnRoundEndFuncPtr = Event_RoundEnd_5_ThirdPerson;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_5_ThirdPerson;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_VAMPIRE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_6_Vampire;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = Event_PlayerHit_6_Vampire;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_SWIM: {
               g_OnRoundStartFuncPtr = Event_RoundStart_7_Swim;
               g_OnRoundEndFuncPtr = Event_RoundEnd_7_Swim;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_7_Swim;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_STRONGSUIT: {
               g_OnRoundStartFuncPtr = Event_RoundStart_8_StrongSuit;
               g_OnRoundEndFuncPtr = Event_RoundEnd_8_StrongSuit;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_8_StrongSuit;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_8_StrongSuit;
          }

          case EFFECT_FORCEMELEE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_9_ForceMelee;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_9_ForceMelee;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_FIREMELEE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_10_FireMelee;
               g_OnRoundEndFuncPtr = Event_RoundEnd_10_FireMelee;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_10_FireMelee;
               g_OnPlayerHitFuncPtr = Event_PlayerHit_10_FireMelee;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_SCHADENFREUDE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_11_Schadenfreude;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_11_Schadenfreude;
          }

          case EFFECT_RNGDEATH: {
               g_OnRoundStartFuncPtr = Event_RoundStart_12_RNGDeath;
               g_OnRoundEndFuncPtr = Event_RoundEnd_12_RNGDeath;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_MATH: {
               g_OnRoundStartFuncPtr = Event_RoundStart_13_Math;
               g_OnRoundEndFuncPtr = Event_RoundEnd_13_Math;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_13_Math;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_13_Math;
          }

          case EFFECT_WEAKLINGS: {
               g_OnRoundStartFuncPtr = Event_RoundStart_14_Weaklings;
               g_OnRoundEndFuncPtr = Event_RoundEnd_14_Weaklings;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_14_Weaklings;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_BLEEDBUFFED: {
               g_OnRoundStartFuncPtr = Event_RoundStart_15_BleedBuff;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = Event_PlayerHit_15_BleedBuff;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_ROLEMODEL: {
               g_OnRoundStartFuncPtr = Event_RoundStart_16_Rolemodel;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_16_Rolemodel;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }
          
          case EFFECT_CLASSWARS: {
               g_OnRoundStartFuncPtr = Event_RoundStart_17_ClassWars;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_17_ClassWars;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_SNOWBALL: {
               if(activePlayers < 3) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Snowball effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Snowball effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_18_Snowball;
               g_OnRoundEndFuncPtr = Event_RoundEnd_18_Snowball;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_18_Snowball;
          }

          case EFFECT_JUSTICE: {
               if(IsGamemodeArena()) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Frontier Justice effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Frontier Justice effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_19_Justice;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_19_Justice;
          }

          case EFFECT_INFECTION: {
               if(activePlayers < 4 || IsGamemodeArena()) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Infection effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Infection effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_20_Infection;
               g_OnRoundEndFuncPtr = Event_RoundEnd_20_Infection;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_20_Infection;
          }

          case EFFECT_DUELIES: {
               if(activePlayers < 3) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Duelies effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Duelies effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_21_Duelies;
               g_OnRoundEndFuncPtr = Event_RoundEnd_21_Duelies;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_21_Duelies;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_21_Duelies;
          }

          case EFFECT_HEATWAVE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_22_Heatwave;
               g_OnRoundEndFuncPtr = Event_RoundEnd_22_Heatwave;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_HYPERHEAL: {
               if(activePlayers < 3) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Hyperheal effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Hyperheal effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_23_Hyperheal;
               g_OnRoundEndFuncPtr = Event_RoundEnd_23_Hyperheal;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_23_Hyperheal;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }
          
          case EFFECT_FORCEFUL: {
               g_OnRoundStartFuncPtr = Event_RoundStart_24_Forceful;
               g_OnRoundEndFuncPtr = Event_RoundEnd_24_Forceful;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_24_Forceful;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_ASSASSINS: {
               g_OnRoundStartFuncPtr = Event_RoundStart_25_Assassins;
               g_OnRoundEndFuncPtr = Event_RoundEnd_25_Assassins;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_25_Assassins;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_INCONTROL: {
               g_OnRoundStartFuncPtr = Event_RoundStart_26_InControl;
               g_OnRoundEndFuncPtr = Event_RoundEnd_26_InControl;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_26_InControl;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_BODYCOUNT: {
               if(activePlayers < 3 && IsGamemodeArena()) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Bodycount effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Bodycount effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_27_Bodycount;
               g_OnRoundEndFuncPtr = Event_RoundEnd_27_Bodycount;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_27_Bodycount;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_27_Bodycount;
          }

          case EFFECT_SMALL: {
               g_OnRoundStartFuncPtr = Event_RoundStart_28_Small;
               g_OnRoundEndFuncPtr = Event_RoundEnd_28_Small;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_28_Small;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_MOSQUITO: {
               g_OnRoundStartFuncPtr = Event_RoundStart_29_Mosquito;
               g_OnRoundEndFuncPtr = Event_RoundEnd_29_Mosquito;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_29_Mosquito;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_BALANCED: {
               if(activePlayers < 3 && IsGamemodeArena()) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Balanced effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Balanced effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_30_Balanced;
               g_OnRoundEndFuncPtr = Event_RoundEnd_30_Balanced;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_30_Balanced;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_30_Balanced;
          }

          case EFFECT_PPERFORM: {
               g_OnRoundStartFuncPtr = Event_RoundStart_31_PPerform;
               g_OnRoundEndFuncPtr = Event_RoundEnd_31_PPerform;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_31_PPerform;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_31_PPerform;
          }

          case EFFECT_SLOWMO: {
               g_OnRoundStartFuncPtr = Event_RoundStart_32_Slowmo;
               g_OnRoundEndFuncPtr = Event_RoundEnd_32_Slowmo;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_32_Slowmo;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_INVIS: {
               g_OnRoundStartFuncPtr = Event_RoundStart_33_Invis;
               g_OnRoundEndFuncPtr = Event_RoundEnd_33_Invis;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_33_Invis;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_SECONDARY: {
               g_OnRoundStartFuncPtr = Event_RoundStart_34_Secondary;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_34_Secondary;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_HELL: {
               g_OnRoundStartFuncPtr = Event_RoundStart_35_Hell;
               g_OnRoundEndFuncPtr = Event_RoundEnd_35_Hell;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_35_Hell;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_SOCIALDIST: {
               if(activePlayers < 3) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Social Distancing effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Social Distancing effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_36_SocialDistancing;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = Event_PlayerHit_36_SocialDistancing;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_DISADVANTAGED: {
               g_OnRoundStartFuncPtr = Event_RoundStart_37_Disadvantaged;
               g_OnRoundEndFuncPtr = Event_RoundEnd_37_Disadvantaged;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_37_Disadvantaged;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_NOSCRUBS: {
               g_OnRoundStartFuncPtr = Event_RoundStart_38_NoScrubs;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_38_NoScrubs;
               g_OnPlayerHitFuncPtr = Event_PlayerHit_38_NoScrubs;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_INFINITECLIP: {
               g_OnRoundStartFuncPtr = Event_RoundStart_39_InfiniteClip;
               g_OnRoundEndFuncPtr = Event_RoundEnd_39_InfiniteClip;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_39_InfiniteClip;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_RESTRICTION: {
               g_OnRoundStartFuncPtr = Event_RoundStart_40_Restriction;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_40_Restriction;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_NOHUD: {
               g_OnRoundStartFuncPtr = Event_RoundStart_41_NoHud;
               g_OnRoundEndFuncPtr = Event_RoundEnd_41_NoHud;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_41_NoHud;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_HORROR: {
               g_OnRoundStartFuncPtr = Event_RoundStart_42_HorrorFortress;
               g_OnRoundEndFuncPtr = Event_RoundEnd_42_HorrorFortress;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_42_HorrorFortress;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_SUPERJUMP: {
               g_OnRoundStartFuncPtr = Event_RoundStart_43_SuperJump;
               g_OnRoundEndFuncPtr = Event_RoundEnd_43_SuperJump;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_PULLEY: {
               g_OnRoundStartFuncPtr = Event_RoundStart_44_Pulley;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = Event_PlayerHit_44_Pulley;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_ODGLASSCANNON: {
               g_OnRoundStartFuncPtr = Event_RoundStart_45_OnDemandGlassCannon;
               g_OnRoundEndFuncPtr = Event_RoundEnd_45_OnDemandGlassCannon;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = Event_PlayerHit_45_OnDemandGlassCannon;
               g_OnPlayerDeathFuncPtr = Event_PlayerDeath_45_OnDemandGlassCannon;
          }

          case EFFECT_BUFFERSGAMBIT: {
               g_OnRoundStartFuncPtr = Event_RoundStart_46_BuffersGambit;
               g_OnRoundEndFuncPtr = Event_RoundEnd_46_BuffersGambit;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_SKATINGRINK: {
               g_OnRoundStartFuncPtr = Event_RoundStart_47_SkatingRink;
               g_OnRoundEndFuncPtr = Event_RoundEnd_47_SkatingRink;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_STUNNINGMETAL: {
               g_OnRoundStartFuncPtr = Event_RoundStart_48_StunningMetal;
               g_OnRoundEndFuncPtr = INVALID_FUNCTION;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = Event_PlayerHit_48_StunningMetal;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_DEATHSTARE: {
               g_OnRoundStartFuncPtr = Event_RoundStart_49_DeathStare;
               g_OnRoundEndFuncPtr = Event_RoundEnd_49_DeathStare;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_QUICKSWAP: {
               g_OnRoundStartFuncPtr = Event_RoundStart_50_Quickswap;
               g_OnRoundEndFuncPtr = Event_RoundEnd_50_Quickswap;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_MVM: {
               if(activePlayers >= MaxClients * 0.4 || !HasNavMesh()) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Mann vs. Machine effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Mann vs. Machine effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_51_Mvm;
               g_OnRoundEndFuncPtr = Event_RoundEnd_51_Mvm;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_51_Mvm;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_PMAYHEM: {
               if(MaxClients > 24) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Projectile Mayhem effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Projectile Mayhem effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_52_ProjectileMayhem;
               g_OnRoundEndFuncPtr = Event_RoundEnd_52_ProjectileMayhem;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_SHIELDINGMED: {
               if(activePlayers < 3) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Shielding Medicine effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Shielding Medicine effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_53_ShieldingMedicine;
               g_OnRoundEndFuncPtr = Event_RoundEnd_53_ShieldingMedicine;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_53_ShieldingMedicine;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_PIERCINGBULL: {
               if(activePlayers < 3) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Piercing Bullets effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Piercing Bullets effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_54_PiercingBullets;
               g_OnRoundEndFuncPtr = Event_RoundEnd_54_PiercingBullets;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_54_PiercingBullets;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_ACHIEVEMENT: {
               g_OnRoundStartFuncPtr = Event_RoundStart_55_AchievementHunter;
               g_OnRoundEndFuncPtr = Event_RoundEnd_55_AchievementHunter;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_BUFFHEAL: {
               g_OnRoundStartFuncPtr = Event_RoundStart_56_BuffingHeal;
               g_OnRoundEndFuncPtr = Event_RoundEnd_56_BuffingHeal;
               g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_56_BuffingHeal;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }

          case EFFECT_MEDICCALL: {
               if(activePlayers < 3) {
                    if(isForced && !g_WasForceRandom) {
                         PrintToChatAll("\x07B143F1[Roundabout]\x01 Called for me? effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                    }
                    else {
                         PrintToServer("[Roundabout] Called for me? effect condition not met, reshuffled.");
                         return setEffect(EFFECT_INVALID);
                    }
               }

               g_OnRoundStartFuncPtr = Event_RoundStart_57_MedicCall;
               g_OnRoundEndFuncPtr = Event_RoundEnd_57_MedicCall;
               g_OnPlayerUpdateFuncPtr = INVALID_FUNCTION;
               g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
               g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          }
     }
     return id;
}