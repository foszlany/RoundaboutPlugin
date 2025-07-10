# Creating an Effect
## **Step 1:** Registering the effect
- Create the effect file inside the `effects` folder.
     - I recommend using the `EFFECTID_EFFECTNAME.sp` format (with the effect ID following the last effect's), such as `256_COOLEFFECT`.
- Inside the `header.inc` file, create any global variables and include the libraries or files that you may need.
     - Include the effect file you just created.
     - Declare your desired effect inside the `Effect` enum just before `EFFECT_MAXCOUNT`.
          - You don't need to write the ID next to the effect, but it can help with readability.

## **Step 2:** Adding the necessary functions to `set_effect`
- Go inside `utils` and find the file `set_effect.sp`.
- After the last effect, create a case matching yours.
     - You will need to set all function pointers (see all in `header.sp: RoundEventFunc`). If you don't need one (e.g. for hitting a player), set it to `INVALID_FUNCTION`.
          - Naming convention for the methods: `Event_EventName_ID_EffectName;`
          - If you don't yet know what you'll need, set everything to `INVALID_FUNCTION` and add it later.
               - `RoundStart` should always be present.
     - You can add conditions to your effects. Example code:
          ```cpp
          if(activePlayers < 3) { // Effect condition
               if(isForced && !g_WasForceRandom) { // Do not change
                    PrintToChatAll("\x07B143F1[Roundabout]\x01 Hyperheal effect was forced, but its conditions were not met. \x07FB524FUnwanted effects may occur.\x01");
               }
               else {
                    PrintToServer("[Roundabout] Hyperheal effect condition not met, reshuffled.");
                    return setEffect(-1);
               }
          }

          // Function pointers
          g_OnRoundStartFuncPtr = Event_RoundStart_23_Hyperheal;
          g_OnRoundEndFuncPtr = Event_RoundEnd_23_Hyperheal;
          g_OnPlayerUpdateFuncPtr = Event_PlayerUpdate_23_Hyperheal;
          g_OnPlayerHitFuncPtr = INVALID_FUNCTION;
          g_OnPlayerDeathFuncPtr = INVALID_FUNCTION;
          ```

## **Step 3:** Creating the effect
- You can copy-paste code from one of the already existing effects to get a headstart.<br><br>
- `RoundStart` is the only necessary component for an effect.
     - It presents the effect details to the players, as well as initialize any variables.
     - Example code:
          ```cpp
          PrintCenterTextAll("Pure");
          ShowHintToAllClients("Pure\n\nThe vanilla TF2 experience we all love.");
          ```
- `RoundEnd` should do the opposite of `RoundStart`, which means it may unset any variables, remove the effects from the players, as well as kill any ongoing Timers.

- `PlayerUpdate` occurs when a player changes its loadout in spawn or changes classes. The player may be able to bypass an effect by doing these actions, so this is sometimes needed.

- `PlayerHit` occurs when a player hits another.

- `PlayerDeath` occurs when a player kills another.

- You can add other listeners either directly as a function pointer or as a HookEvent that would get unhooked at the end of the round. If you only need the hook for 1 effect, the latter is better.

## **Step 4:** Testing
- Use `!roundabout_force <effect_id>` to test your effect.
     - Make sure to watch out for errors in the server console.