# Roundabout Effects

* **Multieffect**<br>
     - Multieffect is a special round with multiple effects that can occasionally happen.
     - By default, up to `5` effects can appear naturally and `10` can be forced.
     - Bad combinations may occur, in which case `!roundabout_voteskip` may be used.
     - **The following probabilities are in place:**
          - **1 effect:**  `85.69%`
          - **2 effects:** `7.45%`
          - **3 effects:** `3.88%`
          - **4 effects:** `1.98%`
          - **5 effects:** `1.00%`
     - **Limitations**
          - `10` is set as the hard limit of a multieffect round
               - Anything above `5` can be highly chaotic and unstable.
          - The following effects can NOT appear during Multieffect:
               - `Pure`
               - `Mann vs. Machine`
          - At most one effect may be chosen from this pool:
               - `Rolemodel`
               - `Class Wars`
               - `Assassins Indeed`
               - `In Control`
               - `Mosquito Infestation`
               - `Hell`
               - `No Scrubs Allowed`
               - `Restriction`

* **Pure**<br>
     - ID: `0`
     - Token: `pure`
     - Vanilla TF2 experience, doesn't change anything.
     - <details><summary>SPOILER</summary>There's a 4% chance of a one-time event occurring sometime between 60 and 160 seconds where everyone will be forced to A-pose without the ability to move or use weapons. This lasts 12 seconds, after which users will explode.</details>

* **Low Gravity**<br>
     - ID: `1`
     - Token: `lowgravity`
     - **CONDITIONAL EFFECT:** Gravity must be higher than `400`.
     - Lowers the gravity to a random value between `100` and `400`.
          - Additionally, there's a `2%` chance of the gravity being `5`.

* **Medieval**<br>
     - ID: `2`
     - Token: `medieval`
     - **CONDITIONAL EFFECT:** Medieval Mode must not be enabled.
     - Enables Medieval Mode.

* **Criticals**<br>
     - ID: `3`
     - Token: `crit`
     - Gives guaranteed critical hits.
     - This effect has two variants, each have a `50%` chance of occurring.
     - **Variant 1:** Gives guaranteed `Mini-Crits`.
     - **Variant 2:** Gives guaranteed `Crits`.

* **Speedboost**<br>
     - ID: `4`
     - Token: `speedboost`
     - Gives faster movement speed.

* **Thirdperson**<br>
     - ID: `5`
     - Token: `thirdperson`
     - Turns on third person view for everyone.

* **Vampire**<br>
     - ID: `6`
     - Token: `vampire`
     - Heals back `60%` of the damage dealt when not overhealed.

* **Swim**<br>
     - ID: `7`
     - Token: `swim`
     - Allows players to swim in the air.

* **Strong Suit**<br>
     - ID: `8`
     - Token: `strongsuit`
     - Receive `Bullet`, `Explosion` or `Fire` invulnerability when spawning.
          - Player will not receive a different effect when changing weapons or classes in the spawn room.
          - Players will not be able to perform specific actions (e.g. rocket jumps) using damage types that they are immune to.

* **Force Melee**<br>
     - ID: `9`
     - Token: `forcemelee`
     - Every Players is stripped to melee.

* **Fire Aspect**<br>
     - ID: `10`
     - Token: `firemelee`
     - Melee hits set the target on fire for `8` seconds.
     - Players already on fire will receive `Mini-crits`.

* **Schadenfreude**<br>
     - ID: `11`
     - Token: `schadenfreude`
     - Players have a `33%` chance each kill to forcibly taunt.

* **Spontaneous Combustion**<br>
     - ID: `12`
     - Token: `rngdeath`
     - Players have a `1%` chance of dying each second.
     - There's also a `0.01%` chance of everyone dying!

* **Perfect Math Class**<br>
     - ID: `13`
     - Token: `math`
     - Gives a random unique math problem every `12 - 36` seconds that must be answered in chat.
          - Not answering the problem correctly or within `8` seconds results in the player's death.
          - Better performing players generally receive harder math problems.
               - Upper bound for the answer is `400 x (Kills / Deaths)` rounded appropriately.

* **Weaklings**<br>
     - ID: `14`
     - Token: `weaklings`
     - All damage is reduced to a mere `33%`.

* **Buffed**<br>
     - ID: `15`
     - Token: `bleedbuffed`
     - All damage causes `8` seconds of bleed.
          - Effect does not stack.
          - Effect is associated with whoever dealt damage to a player last.

* **Rolemodel**<br>
     - ID: `16`
     - Token: `rolemodel`
     - Users are randomly assigned a class that they cannot swap from.
     - An alternative effect has a `33%` chance to occur if the playercount can be associated with a common competitive format. The possible formats:
          - `2v2` (Ultiduo)
               - 1 Medic, 1 Soldier
          - `4v4`
               - 1 Medic, 1 Demoman, 1 Soldier, 1 Scout
          - `6v6` (6s)
               - 1 Medic, 1 Demoman, 2 Soldiers, 2 Scouts
          - `9v9` (Highlander)
               - 1 of each class

* **Class Wars**<br>
     - ID: `17`
     - Token: `classwars`
     - A team consisting of one class versus another.

* **Snowball Effect**<br>
     - ID: `18`
     - Token: `snowball`
     - **CONDITIONAL EFFECT:** In-game playercount must be `3` or higher. 
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
     - Token: `justice`
     - **CONDITIONAL EFFECT:** Gamemode cannot be `Arena`.
     - Killing the last player who killed another will grant them crits for `8` seconds.

* **Infection Tag**<br>
     - ID: `20`
     - Token: `infection`
     - **CONDITIONAL EFFECT:** In-game playercount must be `4` or higher **AND** gamemode cannot be `Arena`.
     - Killing a player will force them into the opposing team. The round is over when all players belong in 1 team (or when the objective is completed).

* **Duelies**<br>
     - ID: `21`
     - Token: `duelies`
     - **CONDITIONAL EFFECT:** In-game playercount must be `3` or higher.
     - Every `20 - 50` seconds, users will randomly receive a duel partner that they need to defeat.
          - If neither party dies, both users will explode violently.
          - Killing the duelee will give the attacker `8` seconds of Mini-crits.

* **Heatwave**<br>
     - ID: `22`
     - Token: `heatwave`
     - Every `36 - 72` seconds a heatwave will occur, which sets all players on fire.

* **Hyperheal**<br>
     - ID: `23`
     - Token: `hyperheal`
     - **CONDITIONAL EFFECT:** In-game playercount must be `3` or higher.
     - Medics are able to overheal infinitely.

* **Forceful**<br>
     - ID: `24`
     - Token: `forceful`
     - Increases the knockback by `300%`
          - Additionally, there's a `2%` chance of the knockback being increased by `1000%`

* **Assassins Indeed**<br>
     - ID: `25`
     - Token: `assassins`
     - Both teams are forced to play Spy. Revolvers have one bullet per clip and they deal `10000%` more damage.

* **In Control**<br>
     - ID: `26`
     - Token: `incontrol`
     - All players are forced to play Soldier. The following are also in effect:
          - Increases Air Control to `250`
          - All Soldier melee weapons crit while rocket jumping
          - Primary weapons mini-crit airborne targets.

* **Bodycount**<br>
     - ID: `27`
     - Token: `bodycount`
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
     - Token: `small`
     - Player size is multiplied by a random value between `0.35` and `0.70`. Voice pitch is multiplied by `1.4`.
          - Additionally, there's a `5%` chance of this value being `0.15`.

* **Mosquito Infestation**<br>
     - ID: `29`
     - Token: `mosquito`
     - Causes players to mimic mosquitos. The following effects are in place:
          - All players are forced to play Scout.
          - Players can infinitely double jump.
          - Players deal `Mini-crits` while mid-air.
          - Secondary weapons deal `30%` more damage.
          - Secondary weapons have `200%` more reserve ammo.
          - Players are faster by `120%`.
          - Player size is multiplied by `0.75`.
          - Voice pitch is changed to `2.0`.

* **Balanced**<br>
     - ID: `30`
     - Token: `balanced`
     - **CONDITIONAL EFFECT:** If the playercount is lower than `3`, the gamemode cannot be `Arena`.
     - Each death will contribute towards a universal indicator of team balance.
          - This indicator keeps track of which team has a higher killcount.
               - If the indicator is positive, `RED` has a higher killcount, `BLU` will be favored.
               - If the indicator goes negative, `BLU` has a higher killcount, `RED` will be favored.
          - Each player will receive a max health bonus depending on how advantaged their team is.
          - Each surplus kill will give `3` extra max hp to every player in the losing team, while the winning team's players will lose the same amount of max hp.

* **Perilous Performance**<br>
     - ID: `31`
     - Token: `pperform`
     - Players receive more damage if their kill-to-death ratio is higher than 1.
          - Caps at `+200%` (reached at 18:1 ratio)

* **Slowmo**<br>
     - ID: `32`
     - Token: `slowmo`
     - This effect simulates slow motion without touching host_timescale.
          - Player speed is multiplied by `0.8`.
          - Reload, firing, holster, deploy and projectile speed is reduced by `50%`.
               - Does not apply to some projectiles.
          - Medic (over)healing speed is multipled by `0.5`.
          - Gravity lowered to `350`.
          - Voice pitch is changed to `0.7`.

* **Invis**<br>
     - ID: `33`
     - Token: `invis`
     - Every player becomes invisible.
          - Status effects (such as healing, jarate or fire) and some minor details (muzzle, reloading) can make players visible.

* **Secondary Combat**<br>
     - ID: `34`
     - Token: `secondary`
     - Primary weapons cannot be used.
          - Spy is an exception, they will keep their revolvers.
          - Additionally, there's a `5%` chance of melee weapons being taken away as well.

* **Hell**<br>
     - ID: `35`
     - Token: `hell`
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

* **Social Distancing**<br>
     - ID: `36`
     - Token: `socialdist`
     - **CONDITIONAL EFFECT:** In-game playercount must be `3` or higher.
     - Teammates too close to each other (within a `256 Hammer Unit` radius) receive `66%` of the damage taken by someone.
          - This does not create a chain-reaction.

* **Disadvantaged**<br>
     - ID: `37`
     - Token: `disadvantaged`
     - One special ability has been taken away from each class (except heavy, who doesn't have one).
          - Scout can no longer double jump
          - Soldier can no longer rocket jump.
          - Pyro can no longer airblast.
          - Demoman can no longer use their secondary weapon.
          - Engineer can no longer build.
          - Medic can no longer use their medigun.
          - Sniper can no longer headshot.
          - Spy can no longer disguise.

* **No Scrubs Allowed**<br>
     - ID: `38`
     - Token: `noscrubs`
     - Players are forced to play Sniper with only their primary and melee weapons.
     - Bodyshots will instantly kill the attacker.
          - Taunt kills are allowed.

* **What's a Reload?**<br>
     - ID: `39`
     - Token: `infiniteclip`
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

* **Restriction**<br>
     - ID: `40`
     - Token: `restriction`
     - Randomly bans `3 - 7` classes.
     - When trying to change to a banned class, the plugin will force the player to the first class that isn't banned.
          - This will cause bots to be restricted to that class!

* **Incognizance**<br>
     - ID: `41`
     - Token: `nohud`
     - Some elements of the HUD become hidden while alive.
          - This includes the crosshair and all indicators (such as health, ammo, metal).

* **Horror Fortress**<br>
     - ID: `42`
     - Token: `horror`
     - Greatly darkened screen.

* **Super Jump**<br>
     - ID: `43`
     - Token: `superjump`
     - Crouching will create a non-damaging explosion below the player that acts like a rocket jump.
          - Cooldown: `4` seconds.

* **Pulley**<br>
     - ID: `44`
     - Token: `pulley`
     - Hitting a player will pull them towards the attacker depending on damage dealt.

* **On Demand Glass Cannon**<br>
     - ID: `45`
     - Token: `odglasscannon`
     - Players deal more damage depending on their health to max health ratio. The lower the health is, the more they damage.
          - Capped at `2x` damage.

* **Buffer's gambit**<br>
     - ID: `46`
     - Token: `buffersgambit`
     - Calling for Medic will apply a random (de)buff on the player.
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

* **Skating Rink**<br>
     - ID: `47`
     - Token: `skatingrink`
     - The server-wide friction is reduced to `0.1`.

* **Stunning Metal**<br>
     - ID: `48`
     - Token: `stunningmetal`
     - Greater instances of damage will slow down an enemy.
          - `25 <= damage < 50` causes `0.17` slowdown for `1.4` seconds.
          - `50 <= damage < 80` causes `0.32` slowdown for `2.6` seconds.
          - `80 <= damage < 110` causes `0.50` slowdown for `3.8` seconds.
          - `110 <= damage < 160` causes `0.75` slowdown for `5.0` seconds.
          - `160 <= damage` causes the player to be stunned for `5.0` seconds.

* **Death Stare**<br>
     - ID: `49`
     - Token: `deathstare`
     - When two players look at each other, they both explode.
          - The check runs every `0.15` seconds (to avoid server overload) and is generally strict.
          - Limit is `3000 Hammer Units`.

* **Quickswap**<br>
     - ID: `50`
     - Token: `quickswap`
     - Two players will swap places every `3-8` seconds. There's a `25` second grace period after the round starts.
          - Players have their own `15` second grace period after swapping places so they're not teleported around too often.
          - Swaps can happen with players from opposing teams.

* **Mann vs. Machine**<br>
     - ID: `51`
     - Token: `mvm`
     - **CONDITIONAL EFFECT:** In-game playercount must be at most `40%` of the server's capacity **AND** the map must have a generated navigation mesh.
     - Players are assigned to a team at random. `10%` more bots are added to the other team. An additional bot is added if possible.

* **Projectile Mayhem**<br>
     - ID: `52`
     - Token: `pmayhem`
     - **CONDITIONAL EFFECT:** In-game playercount must be `24` or less. 
     - Every second a new projectile is assigned to non-sniper primary and non-demoman secondary weapons.
          - The damage of the projectile deals as much damage as the original weapon would.
          - These projectiles can be:
               - Default
               - Rocket
               - Syringe
               - Flare
               - Righteous Bison Particle

* **Shielding Medicine**<br>
     - ID: `53`
     - Token: `shieldingmed`
     - **CONDITIONAL EFFECT:** In-game playercount must be `3` or higher. 
     - Medics have the ability to use the `Level 1` Mann vs. Machine shield.
          - Additionally, there's a `15%` chance of shield being `Level 2`.

* **Piercing Bullets**<br>
     - ID: `54`
     - Token: `piercingbull`
     - **CONDITIONAL EFFECT:** In-game playercount must be `3` or higher. 
     - Bullets go through enemy players.

* **Achievement Hunter**<br>
     - ID: `55`
     - Token: `achievement`
     - When a player earns an achievement, they gain Powerplay for `12 seconds`.
          - Speed bonus
          - Guaranteed Critical hits
          - Ubercharged

* **Buffing Heal**<br>
     - ID: `56`
     - Token: `buffheal`
     - **CONDITIONAL EFFECT:** In-game playercount must be `3` or higher. 
     - Medic healing rate is reduced to `33%`. Users healed will now gain `Mini-crits`.
          - If any healing was done using the Crusader's Crossbow, then the buff is also granted.
               - Formula (in seconds): `1.0 + healamount / 20.0`

* **Called for me?**<br>
     - ID: `57`
     - Token: `mediccall`
     - **CONDITIONAL EFFECT:** In-game playercount must be `3` or higher.
     - Calling for Medic will teleport one if there is a suitable candidate.
          - There's a `6` second delay between attempts.
          - Conditions for a Medic to be suitable:
               - Must exist and be within the same team as the caller
               - Must not already be healing someone
               - Wasn't teleported in the past `8` seconds.

* **King**<br>
     - ID: `58`
     - Token: `king`
     - **CONDITIONAL EFFECT:** Gamemode cannot be Arena.
     - At the start of the round a King is randomly selected.
          - Killing the King will give the title to the killer.
          - The King has the following effects:
               - `+50%` increased damage
               - `+20%` larger player model
               - `+300` max health
               - `+6` health per second

* **Identity Theft**<br>
     - ID: `59`
     - Token: `identitytheft`
     - **CONDITIONAL EFFECT:** If the playercount is lower than `3`, the gamemode cannot be `Arena`.
     - Killing a player changes the attacker's class to their victim's.

* **Time Travel**<br>
     - ID: `60`
     - Token: `timetravel`
     - Every `8 - 32` seconds, a snapshot is created. After `1 - 24` seconds, all players will be rolled back into that snapshot. Snapshots keep the following:
          - Position, viewangles and velocity
          - Health
          - Class
          - Weapon slot
          - Clip sizes for each weapon

* **Parry it!**<br>
     - ID: `61`
     - Token: `parry`
     - All players gain the ability to parry.
          - Calling for Medic will initiate the parry.
          - Any incoming damage can be parried, but only one instance at a time.
          - Parrying has a time window of `0.25` seconds with a `1.5` second cooldown.
               - If the player didn't receive damage within the time window, they will take `1.25x` damage for `1.5` seconds.
               - If the player did receive damage, the cooldown is reduced to `0.5` seconds and incoming damage is nullified.