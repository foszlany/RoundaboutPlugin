# Roundabout Effects

* **Pure**<br>
     - ID: `0`
     - Vanilla TF2 experience, doesn't change anything.
     - <details><summary>SPOILER</summary>There's a 4% chance of a one-time event occurring sometime between 60 and 160 seconds where everyone will be forced to A-pose without the ability to move or use weapons. This lasts 12 seconds, after which users will explode.</details>

* **Low Gravity**<br>
     - ID: `1`
     - **CONDITIONAL EFFECT:** Gravity must be higher than `400`.
     - Lowers the gravity to a random value between `100` and `400`.
          - Additionally, there's a `2%` chance of the gravity being `0`.

* **Mini-crits**<br>
     - ID: `2`
     - Gives guaranteed `Mini-crits`.

* **Criticals**<br>
     - ID: `3`
     - Gives guaranteed `Crits`.

* **Speedboost**<br>
     - ID: `4`
     - Gives faster movement speed.

* **Thirdperson**<br>
     - ID: `5`
     - Turns on third person view for everyone.

* **Vampire**<br>
     - ID: `6`
     - Heals back `60%` of the damage dealt when not overhealed.

* **Swim**<br>
     - ID: `7`
     - Allows players to swim in the air.

* **Strong Suit**<br>
     - ID: `8`
     - Receive `Bullet`, `Explosion` or `Fire` invulnerability when spawning.
          - Player will not receive a different effect when changing weapons or classes in the spawn room.
          - Players will not be able to perform specific actions (e.g. rocket jumps) using damage types that they are immune to.

* **Force Melee**<br>
     - ID: `9`
     - Every Players is stripped to melee.

* **Fire Aspect**<br>
     - ID: `10`
     - Melee hits set the target on fire for `8` seconds.
     - Players already on fire will receive `Mini-crits`.

* **Schadenfreude**<br>
     - ID: `11`
     - Players have a `33%` chance each kill to forcibly taunt.

* **Spontaneous Combustion**<br>
     - ID: `12`
     - Players have a `1%` chance of dying each second.
     - There's also a `0.01%` chance of everyone dying!

* **Perfect Math Class**<br>
     - ID: `13`
     - Gives a random unique math problem every `12 - 36` seconds that must be answered in chat.
          - Not answering the problem correctly or within `8` seconds results in the player's death.
          - Better performing players generally receive harder math problems.
               - Upper bound for the answer is `400 x (Kills / Deaths)` rounded appropriately.

* **Weaklings**<br>
     - ID: `14`
     - All damage is reduced to a mere `33%`.

* **Buffed**<br>
     - ID: `15`
     - All damage causes `8` seconds of bleed.
          - Effect does not stack.
          - Effect is associated with whoever dealt damage to a player last.

 * **Rolemodel**<br>
     - ID: `16`
     - Users are randomly assigned a class that they cannot swap from.

 * **Class Wars**<br>
     - ID: `17`
     - A team consisting of one class versus another.

 * **Snowball Effect**<br>
     - ID: `18`
     - Players receive increasingly better status effects upon chaining kills.
     - All effects last `8` seconds and they renew after getting a kill.
     - Effects can be obtained from the previous one in the following order:
          - (None)
          - Speedboost
          - Mini-crit
          - Defense buff
          - Crits
          - Uber

 * **Frontier Justice**<br>
     - ID: `19`
     - **CONDITIONAL EFFECT:** Gamemode cannot be `Arena`.
     - Killing the last player who killed another will grant them crits for `8` seconds.

 * **Infection Tag**<br>
     - ID: `20`
     - **CONDITIONAL EFFECT:** In-game playercount must be `4` or higher **AND** gamemode cannot be `Arena`.
     - Killing a player will force them into the opposing team. The round is over when all players belong in 1 team (or when the objective is completed).

 * **Duelies**<br>
     - ID: `21`
     - **CONDITIONAL EFFECT:** In-game playercount must be `3` or higher.
     - Every `20 - 50` seconds, users will randomly receive a duel partner that they need to defeat.
          - If neither party dies, both users will explode violently.
          - Killing the duelee will give the attacker `8` seconds of Mini-crits.

* **Heatwave**<br>
     - ID: `22`
     - Every `36 - 72` seconds a heatwave will occur, which sets all players on fire.

* **Hyperheal**<br>
     - ID: `23`
     - **CONDITIONAL EFFECT:** In-game playercount must be `3` or higher.
     - Medics are able to overheal infinitely.

* **Forceful**<br>
     - ID: `24`
     - Increases the knockback by `300%`
          - Additionally, there's a `2%` chance of the knockback being increased by `1000%`

* **Assassins Indeed**<br>
     - ID: `25`
     - Both teams are forced to play Spy. Revolvers have one bullet per clip and they deal `10000%` more damage.

* **In Control**<br>
     - ID: `26`
     - Increases Air Control to `250`. All Soldier melee weapons crit while rocket jumping.

* **Bodycount**<br>
     - ID: `27`
     - **CONDITIONAL EFFECT:** If the playercount is lower than `3`, the gamemode cannot be `Arena`.
     - Killing a player grants the user `25` bonus max health.
          - The attacker also heals for this amount.
          - If a player disconnects and another joins in their place, they may get their health bonus.
               - For now this is a design choice to prevent newcomers from being overwhelmed.
     - This effect has two variants, each have a `50%` chance of occurring.
          - **Variant 1:** Bonus max health is lost upon death.
          - **Variant 2:** Bonus max health is kept after death.

* **Small**<br>
     - ID: `28`
     - Player size is multiplied by a random value between `0.35` and `0.70`.
          - Additionally, there's a `5%` chance of this value being `0.15`.

* **Mosquito Infestation**<br>
     - ID: `29`
     - Causes players to mimic mosquitos. The following effects are in place:
          - All players are forced to play Scout.
          - Players can infinitely double jump.
          - Players deal `Mini-crits` while mid-air.
          - Secondary weapons deal `30%` more damage.
          - Players are faster by `120%`.
          - Players size is multiplied by `0.75`.
          - Voice pitch is changed to `2.0`.

* **Balanced**<br>
     - ID: `30`
     - **CONDITIONAL EFFECT:** If the playercount is lower than `3`, the gamemode cannot be `Arena`.
     - Each death will contribute towards a universal indicator of team balance.
          - This indicator keeps track of which team has a higher killcount.
               - If the indicator is positive, `RED` has a higher killcount, `BLU` will be favored.
               - If the indicator goes negative, `BLU` has a higher killcount, `RED` will be favored.
          - Each player will receive a max health bonus depending on how advantaged their team is.
          - Each surplus kill will give `3` extra max hp to every player in the losing team, while the winning team's players will lose the same amount of max hp.

* **Perilous Performance**
     - ID: `31`
     - Players receive more damage if their kill-to-death ratio is higher than 1.
          - Caps at `+200%` (reached at 18:1 ratio)

* **Slowmo**
     - ID: `32`
     - This effect simulates slow motion without touching host_timescale.
          - Player speed is multiplied by `0.8`.
          - Reload, firing, holster, deploy and projectile speed is reduced by `50%`.
               - Does not apply to some projectiles.
          - Medic (over)healing speed is multipled by `0.5`.
          - Gravity lowered to `350`.
          - Voice pitch is changed to `0.7`.

* **Invis**
     - ID: `33`
     - Every player becomes invisible.
          - Status effects (such as healing, jarate or fire) and some minor details (muzzle, reloading) can make players visible.

* **Secondary Combat**
     - ID: `34`
     - Primary weapons cannot be used.
          - Spy is an exception, they will keep their revolvers.
          - Additionally, there's a `5%` chance of melee weapons being taken away as well.

* **Hell**
     - ID: `35`
     - Simulates true hell. The following effects are in place:
          - All players are forced to play Pyro.
          - The following flame attributes are changed:
               - Particle size is larger by `75%`.
               - Spread area is increased by `40` degrees.
          - The following primary weapon attributes are changed:
               - Primary weapon ammo is increased by `250%`.
               - Primary weapon firing rate is increased by `100%`.
               - Airblast force is increased by `75%`.
         - Secondary and melee weapons deal `25%` increased damage.
          - Voice pitch is changed to `0.5`.

* **Social Distancing**
     - ID: `36`
     - **CONDITIONAL EFFECT:** In-game playercount must be `3` or higher.
     - Teammates too close to each other (within a `256 Hammer Unit` radius) receive `66%` of the damage taken by someone.
          - This does not create a chain-reaction.

* **Disadvantaged**
     - ID: `37`
     - One special ability has been taken away from each class (except heavy, who doesn't have one).
          - Scout can no longer double jump
          - Soldier can no longer rocket jump.
          - Pyro can no longer airblast.
          - Demoman can no longer use their secondary weapon.
          - Engineer can no longer build.
          - Medic can no longer use their medigun.
          - Sniper can no longer headshot.
          - Spy can no longer disguise.

* **No Scrubs Allowed**
     - ID: `38`
     - Players are forced to play Sniper with only their primary weapon. Bodyshots will instantly kill the attacker.

* **What's a Reload?**
     - ID: `39`
     - Greatly increased clip size and reserve ammo for every weapon.
          - Primary weapons:
               - `+300%` clip size
               - `+150%` reserve ammo
          - Secondary weapons:
               - `+250%` clip size
               - `+200%` reserve ammo
               - `+200%` maximum charges for throwables
          - Melee weapons:
               - `+300%` maximum charges for throwables

* **Restriction**
     - ID: `40`
     - Randomly bans `3 - 7` classes.
     - When trying to change to a banned class, the plugin will force the player to the first class that isn't banned.
          - This will cause bots to be restricted to that class!

* **Incognizance**
     - ID: `41`
     - Some elements of the HUD become hidden while alive.
          - This includes the crosshair and all indicators (such as health, ammo, metal).

* **Horror Fortress**
     - ID: `42`
     - Greatly darkened screen.

* **Super Jump**
     - ID: `43`
     - Crouching will create a non-damaging explosion below the player that acts like a rocket jump.
          - Delay: `4` seconds.

* **Pulley**
     - ID: `44`
     - Hitting a player will pull them towards the attacker depending on damage dealt.

* **On Demand Glass Cannon**
     - ID: `45`
     - Players deal more damage depending on their health to max health ratio. The lower the health is, the more they damage.
          - Capped at `2x` damage.

* **Buffer's gambit**
     - ID: `46`
     - Crouching will apply a random (de)buff on the player.
          - Delay: `16` seconds.
          - Effects last `8` seconds.
          - Buff list with their appropriate chances:
               - Random damage immunity: `10%`
               - Speed-boost: `10%`
               - Mini-crits: `10%`
               - Defense bonus: `10%`
               - Become a ghost: `5%`
               - Crits: `3%`
               - Ubercharge: `2%`
          - Debuff list with their appropriate chances:
               - Slowed: `13%`
               - Marked for death: `12%`
               - Set on Fire: `10%`
               - Jarate, Mad Milk, Bleed: `6%`
               - Stunned: `4%`
               - Reduce player health to 1: `3%`
               - Explosion: `2%`
               
* **Skating Rink**
     - ID: `47`
     - The server-wide friction is reduced to `0.1`.

* **Stunning Metal**
     - ID: `48`
     - Greater instances of damage will slow down an enemy.
          - `25 <= damage < 50` causes `0.17` slowdown for `1.4` seconds.
          - `50 <= damage < 80` causes `0.32` slowdown for `2.6` seconds.
          - `80 <= damage < 110` causes `0.50` slowdown for `3.8` seconds.
          - `110 <= damage < 160` causes `0.75` slowdown for `5.0` seconds.
          - `160 <= damage` causes the player to be stunned for `5.0` seconds.

* **Death Stare**
     - ID: `49`
     - When two players look at each other, they both explode.
          - The check is periodic (to avoid server overload) and generally strict.
          - Limit is `3000 Hammer Units`.

* **Quickswap**
     - ID: `50`
     - Two players will swap places every `3-8` seconds. There's a `25` second grace period after the round starts.
          - Players have their own `15` second grace period after swapping places so they're not teleported around too often.
          - Swaps can happen with players from opposing teams.

* **Mann vs. Machine**
     - ID: `51`
     - **CONDITIONAL EFFECT:** In-game playercount must be at most `40%` of the server's capacity **AND** the map must have a generated navigation mesh.
     - Players are assigned to a team at random. `10%` more bots are added to the other team. An additional bot is added if possible.

* **Projectile Mayhem**
     - ID: `52`
     - **CONDITIONAL EFFECT:** In-game playercount must be `24` or less. 
     - Every second a new projectile is assigned to primary and secondary weapons.
          - These projectiles can be:
               - Default
               - Rocket
               - Syringe
               - Flare
               - Righteous Bison Particle

* **Shielding Medicine**
     - ID: `53`
     - **CONDITIONAL EFFECT:** In-game playercount must be `2` or higher. 
     - Medics have the ability to use the `Level 1` Mann vs. Machine shield.