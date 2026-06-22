#pragma semicolon 1

public void setEffect() {
     int activePlayers = CountActivePlayers();
     int effectIndex = 0;

     while(effectIndex < g_EffectCount) {
          Effect id = (g_IsForced && !g_IsForcedRandom) ? g_CurrentEffects[effectIndex] : view_as<Effect>(GetRandomInt(0, EFFECT_MAXCOUNT - EFFECT_LOWGRAVITY));

          // CHECK BLACKLIST
          char token[32];
          EFFECT_TOKENS.GetKeyFromInt(id, token, sizeof(token));
          if(g_CVAR_EnableBlacklist.BoolValue && (!g_IsForced || g_IsForcedRandom) && g_Blacklist.ContainsKey(token)) {
               continue;
          }
          
          // MULTIEFFECT RESTRICTIONS
          if(g_EffectCount > 1 && g_IsForcedRandom) {
               bool doReroll = false;

               // EXCLUDED
               if(MULTIEFFECT_EXCLUDED.FindValue(id) != -1) {
                    continue;
               }

               // MUTEX
               if(MULTIEFFECT_MUTUALLY_EXCLUSIVE.FindValue(id) != -1) {
                    if(!g_IsMutuallyExclusiveEffectChosen) {
                         g_IsMutuallyExclusiveEffectChosen = true;
                    }
                    else {
                         doReroll = true;
                    }
               }

               // DUPLICATE
               for(int i = 0; i < effectIndex; i++) {
                    if(g_CurrentEffects[i] == id) {
                         doReroll = true;
                    }
               }

               if(doReroll) {
                    continue;
               }
          }

          // EFFECT ROLLED
          g_CurrentEffects[effectIndex] = id;

          switch(id) {
               case EFFECT_PURE: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_0_Pure;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_0_Pure;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_0_Pure;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_LOWGRAVITY: {
                    ConVar gravity = FindConVar("sv_gravity");
                    int currentGravity = GetConVarInt(gravity);

                    if(currentGravity <= 400) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Low Gravity effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Low Gravity effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_1_LowGravity;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_1_LowGravity;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_MEDIEVAL: {
                    int isMedieval = GameRules_GetProp("m_bPlayingMedieval", 1);

                    if(isMedieval) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Medieval effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Medieval effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_2_Medieval;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_2_Medieval;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_CRIT: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_3_Crit;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_3_Crit;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_3_Crit;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_SPEEDBOOST: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_4_SpeedBoost;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_4_SpeedBoost;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_4_SpeedBoost;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_THIRDPERSON: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_5_ThirdPerson;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_5_ThirdPerson;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_5_ThirdPerson;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_VAMPIRE: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_6_Vampire;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = Event_PlayerHit_6_Vampire;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_SWIM: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_7_Swim;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_7_Swim;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_7_Swim;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_STRONGSUIT: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_8_StrongSuit;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_8_StrongSuit;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_8_StrongSuit;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_8_StrongSuit;
               }

               case EFFECT_FORCEMELEE: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_9_ForceMelee;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_9_ForceMelee;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_9_ForceMelee;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_FIREMELEE: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_10_FireMelee;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_10_FireMelee;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_10_FireMelee;
                    g_OnPlayerHitFuncPtr[effectIndex] = Event_PlayerHit_10_FireMelee;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_SCHADENFREUDE: {
                    g_OnRoundStartFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_11_Schadenfreude;
               }

               case EFFECT_RNGDEATH: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_12_RNGDeath;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_12_RNGDeath;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_MATH: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_13_Math;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_13_Math;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_13_Math;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_13_Math;
               }

               case EFFECT_WEAKLINGS: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_14_Weaklings;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_14_Weaklings;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_14_Weaklings;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_BLEEDBUFFED: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_15_BleedBuff;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = Event_PlayerHit_15_BleedBuff;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_ROLEMODEL: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_16_Rolemodel;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_16_Rolemodel;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }
               
               case EFFECT_CLASSWARS: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_17_ClassWars;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_17_ClassWars;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_SNOWBALL: {
                    if(activePlayers < 3) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Snowball effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Snowball effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_18_Snowball;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_18_Snowball;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_18_Snowball;
               }

               case EFFECT_JUSTICE: {
                    if(IsGamemodeArena()) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Frontier Justice effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Frontier Justice effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_19_Justice;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_19_Justice;
               }

               case EFFECT_INFECTION: {
                    if(activePlayers < 4 || IsGamemodeArena()) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Infection effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Infection effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_20_Infection;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_20_Infection;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_20_Infection;
               }

               case EFFECT_DUELIES: {
                    if(activePlayers < 3) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Duelies effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Duelies effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_21_Duelies;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_21_Duelies;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_21_Duelies;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_21_Duelies;
               }

               case EFFECT_HEATWAVE: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_22_Heatwave;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_22_Heatwave;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_HYPERHEAL: {
                    if(activePlayers < 3) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Hyperheal effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Hyperheal effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_23_Hyperheal;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_23_Hyperheal;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_23_Hyperheal;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }
               
               case EFFECT_FORCEFUL: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_24_Forceful;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_24_Forceful;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_24_Forceful;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_ASSASSINS: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_25_Assassins;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_25_Assassins;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_25_Assassins;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_INCONTROL: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_26_InControl;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_26_InControl;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_26_InControl;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_BODYCOUNT: {
                    if(activePlayers < 3 && IsGamemodeArena()) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Bodycount effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Bodycount effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_27_Bodycount;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_27_Bodycount;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_27_Bodycount;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_27_Bodycount;
               }

               case EFFECT_SMALL: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_28_Small;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_28_Small;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_28_Small;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_MOSQUITO: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_29_Mosquito;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_29_Mosquito;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_29_Mosquito;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_BALANCED: {
                    if(activePlayers < 3 && IsGamemodeArena()) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Balanced effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Balanced effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_30_Balanced;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_30_Balanced;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_30_Balanced;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_30_Balanced;
               }

               case EFFECT_PPERFORM: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_31_PPerform;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_31_PPerform;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_31_PPerform;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_31_PPerform;
               }

               case EFFECT_SLOWMO: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_32_Slowmo;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_32_Slowmo;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_32_Slowmo;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_INVIS: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_33_Invis;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_33_Invis;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_33_Invis;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_SECONDARY: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_34_Secondary;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_34_Secondary;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_HELL: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_35_Hell;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_35_Hell;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_35_Hell;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_SOCIALDIST: {
                    if(activePlayers < 3) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Social Distancing effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Social Distancing effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = Event_PlayerHit_36_SocialDistancing;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_DISADVANTAGED: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_37_Disadvantaged;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_37_Disadvantaged;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_37_Disadvantaged;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_NOSCRUBS: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_38_NoScrubs;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_38_NoScrubs;
                    g_OnPlayerHitFuncPtr[effectIndex] = Event_PlayerHit_38_NoScrubs;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_INFINITECLIP: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_39_InfiniteClip;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_39_InfiniteClip;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_39_InfiniteClip;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_RESTRICTION: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_40_Restriction;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_40_Restriction;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_NOHUD: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_41_NoHud;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_41_NoHud;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_41_NoHud;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_HORROR: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_42_HorrorFortress;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_42_HorrorFortress;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_42_HorrorFortress;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_SUPERJUMP: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_43_SuperJump;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_43_SuperJump;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_PULLEY: {
                    g_OnRoundStartFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = Event_PlayerHit_44_Pulley;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_ODGLASSCANNON: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_45_OnDemandGlassCannon;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_45_OnDemandGlassCannon;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = Event_PlayerHit_45_OnDemandGlassCannon;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_45_OnDemandGlassCannon;
               }

               case EFFECT_BUFFERSGAMBIT: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_46_BuffersGambit;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_46_BuffersGambit;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_SKATINGRINK: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_47_SkatingRink;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_47_SkatingRink;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_STUNNINGMETAL: {
                    g_OnRoundStartFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = Event_PlayerHit_48_StunningMetal;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_DEATHSTARE: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_49_DeathStare;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_49_DeathStare;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_QUICKSWAP: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_50_Quickswap;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_50_Quickswap;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_MVM: {
                    if(activePlayers >= MaxClients * 0.4 || !HasNavMesh()) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Mann vs. Machine effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Mann vs. Machine effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_51_Mvm;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_51_Mvm;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_51_Mvm;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_PMAYHEM: {
                    if(MaxClients > 24) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Projectile Mayhem effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Projectile Mayhem effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_52_ProjectileMayhem;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_52_ProjectileMayhem;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_SHIELDINGMED: {
                    if(activePlayers < 3) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Shielding Medicine effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Shielding Medicine effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_53_ShieldingMedicine;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_53_ShieldingMedicine;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_53_ShieldingMedicine;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_PIERCINGBULL: {
                    if(activePlayers < 3) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Piercing Bullets effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Piercing Bullets effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_54_PiercingBullets;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_54_PiercingBullets;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_54_PiercingBullets;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_ACHIEVEMENT: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_55_AchievementHunter;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_55_AchievementHunter;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_BUFFHEAL: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_56_BuffingHeal;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_56_BuffingHeal;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_56_BuffingHeal;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_MEDICCALL: {
                    if(activePlayers < 3) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Called for me? effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Called for me? effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_57_MedicCall;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_57_MedicCall;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_KING: {
                    if(IsGamemodeArena()) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 King effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] King effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_58_King;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_58_King;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_58_King;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_58_King;
               }

               case EFFECT_IDENTITYTHEFT: {
                    if(activePlayers < 3 && IsGamemodeArena()) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Identity Theft effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Identity Theft effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_59_IdentityTheft;
               }
               
               case EFFECT_TIMETRAVEL: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_60_TimeTravel;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_PARRY: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_61_ParryIt;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_61_ParryIt;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_61_ParryIt;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_GRAPPLINGHOOK: {
                    ConVar grapplingHook = FindConVar("tf_grapplinghook_enable");
                    bool isGrapplingHookEnabled = GetConVarBool(grapplingHook);

                    ConVar spells = FindConVar("tf_spells_enabled");
                    bool isSpellsEnabled = GetConVarBool(spells);

                    if(isGrapplingHookEnabled || isSpellsEnabled) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Grappling Hook effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Grappling Hook effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_62_Grapple;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_62_Grapple;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_SPELLBOUND: {
                    ConVar grapplingHook = FindConVar("tf_grapplinghook_enable");
                    bool isGrapplingHookEnabled = GetConVarBool(grapplingHook);

                    ConVar spells = FindConVar("tf_spells_enabled");
                    bool isSpellsEnabled = GetConVarBool(spells);

                    if((activePlayers < 3 && IsGamemodeArena()) || isGrapplingHookEnabled || isSpellsEnabled) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Spellbound effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Spellbound effect condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_63_Spellbound;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_63_Spellbound;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_MIST: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_64_Mist;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_64_Mist;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_64_Mist;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_COSPLAY: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_65_Cosplay;
                    g_OnRoundEndFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_65_Cosplay;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_WALLHACK: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_66_Wallhack;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_66_Wallhack;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = Event_PlayerUpdate_66_Wallhack;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_REVIVEUBER: {
                    if(activePlayers < 3) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Reviving Uber was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Reviving Uber condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_67_ReviveUber;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_67_ReviveUber;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_PING: {
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_68_Ping;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_68_Ping;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_AIRDROP: {
                    if(IsGamemodeArena() || activePlayers < 3) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Mercenary Airdrop was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Mercenary Airdrop condition not met, reshuffled.");
                              continue;
                         }
                    }

                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_69_Airdrop;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_69_Airdrop;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = INVALID_FUNCTION;
               }

               case EFFECT_BOUNTY: {
                    if(IsGamemodeArena()) {
                         if(g_IsForced && !g_IsForcedRandom) {
                              PrintToChatAll("\x07B143F1[Roundabout]\x01 Bounty was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
                         }
                         else {
                              PrintToServer("[Roundabout] Bounty condition not met, reshuffled.");
                              continue;
                         }
                    }
                    
                    g_OnRoundStartFuncPtr[effectIndex] = Event_RoundStart_70_Bounty;
                    g_OnRoundEndFuncPtr[effectIndex] = Event_RoundEnd_70_Bounty;
                    g_OnPlayerUpdateFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerHitFuncPtr[effectIndex] = INVALID_FUNCTION;
                    g_OnPlayerDeathFuncPtr[effectIndex] = Event_PlayerDeath_70_Bounty;
               }
          }

          effectIndex++;
     }    
}