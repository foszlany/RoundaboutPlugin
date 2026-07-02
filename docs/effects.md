# Roundabout Effects

* **Multieffect**
     - **ID:** `N/A`
     - **Token:** `N/A`
     - Multieffect is a special round with multiple effects that can occasionally happen.
     - By default, up to `5` effects can appear naturally and `10` can be forced.
     - Bad combinations may occur, in which case `!roundabout_voteskip` may be used.
     - **The following probabilities are in place:**
          - **1 effect:**  `92.67%`
          - **2 effects:** `3.86%`
          - **3 effects:** `1.97%`
          - **4 effects:** `1.00%`
          - **5 effects:** `0.50%`
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

* **Pure**
     - **ID:** `0`
     - **Token:** `pure`
     - **Rare variant:** `4%` chance of a special one-time event.
     - Vanilla TF2 experience, doesn't change anything.

* **Low Gravity**
     - **ID:** `1`
     - **Token:** `lowgravity`
     - **Conditional effect:** Gravity must be higher than `400`
     - **Rare variant:** `2%` chance of the gravity being `5`
     - Lowers the gravity to a random value between `100` and `400`

* **Medieval**
     - **ID:** `2`
     - **Token:** `medieval`
     - **Conditional effect:** Medieval Mode must not be enabled.
     - Enables Medieval Mode.

* **Criticals**
     - **ID:** `3`
     - **Token:** `crit`
     - Gives guaranteed critical hits.
     - This effect has two variants, each have a `50%` chance of occurring.
     - **Variant 1:** Gives guaranteed `Mini-Crits`
     - **Variant 2:** Gives guaranteed `Crits`

* **Speedboost**
     - **ID:** `4`
     - **Token:** `speedboost`
     - Gives faster movement speed.

* **Thirdperson**
     - **ID:** `5`
     - **Token:** `thirdperson`
     - Turns on third person view for everyone.

* **Vampire**
     - **ID:** `6`
     - **Token:** `vampire`
     - **Rare variant:** `5%` chance of `100%` heal.
     - Heals back `60%` of the damage dealt when not overhealed.

* **Swim**
     - **ID:** `7`
     - **Token:** `swim`
     - Allows players to swim in the air.

* **Strong Suit**
     - **ID:** `8`
     - **Token:** `strongsuit`
     - Receive `Bullet`, `Explosion` or `Fire` invulnerability when spawning.
          - Player will not receive a different effect when changing weapons or classes in the spawn room.
          - Players will not be able to perform specific actions (e.g. rocket jumps) using damage types that they are immune to.

* **Force Melee**
     - **ID:** `9`
     - **Token:** `forcemelee`
     - **Rare variant:** `2%` chance of weapons dealing `1000%` more damage
     - Every Players is stripped to melee.

* **Fire Aspect**
     - **ID:** `10`
     - **Token:** `firemelee`
     - Melee hits set the target on fire for `8` seconds.
     - Players already on fire will receive `Mini-crits`

* **Schadenfreude**
     - **ID:** `11`
     - **Token:** `schadenfreude`
     - **Rare variant:** `2%` chance of guaranteed taunt.
     - Players have a `33%` chance each kill to forcibly taunt.

* **Spontaneous Combustion**
     - **ID:** `12`
     - **Token:** `rngdeath`
     - **Rare variant:** `0.01%` chance of everyone dying!
     - Players have a `1%` chance of dying each second.

* **Perfect Math Class**
     - **ID:** `13`
     - **Token:** `math`
     - Gives a random unique math problem every `12 - 36` seconds that must be answered in chat.
          - Not answering the problem correctly or within `8` seconds results in the player's death.
          - Better performing players generally receive harder math problems.
               - Upper bound for the answer is `400 x (Kills / Deaths)` rounded appropriately.

* **Weaklings**
     - **ID:** `14`
     - **Token:** `weaklings`
     - All damage is reduced to a mere `33%`

* **Buffed**
     - **ID:** `15`
     - **Token:** `bleedbuffed`
     - All damage causes `8` seconds of bleed.
          - Effect does not stack.
          - Effect is associated with whoever dealt damage to a player last.

* **Rolemodel**
     - **ID:** `16`
     - **Token:** `rolemodel`
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

* **Class Wars**
     - **ID:** `17`
     - **Token:** `classwars`
     - A team consisting of one class versus another.

* **Snowball Effect**
     - **ID:** `18`
     - **Token:** `snowball`
     - **Conditional effect:** In-game playercount must be `3` or higher.
     - Players receive increasingly better status effects upon chaining kills.
     - All effects last `8` seconds and they renew after getting a kill.
          - Once a player obtains the final effect, they can no longer renew them.
     - Effects can be obtained from the previous one in the following order:
          - (None)
          - Speedboost
          - Mini-crit
          - 75% Fire resistance
          - 75% Blast resistance
          - 75% Bullet resistance
          - Crits
          - Uber

* **Frontier Justice**
     - **ID:** `19`
     - **Token:** `justice`
     - **Conditional effect:** Gamemode cannot be `Arena`
     - Killing the last player who killed another will grant them crits for `8` seconds.

* **Infection Tag**
     - **ID:** `20`
     - **Token:** `infection`
     - **Conditional effect:** In-game playercount must be `4` or higher **AND** gamemode cannot be `Arena`
     - Killing a player will force them into the opposing team. The round is over when all players belong in 1 team (or when the objective is completed).
          - The last standing player receives guaranteed `Crits`

* **Duelies**
     - **ID:** `21`
     - **Token:** `duelies`
     - **Conditional effect:** In-game playercount must be `3` or higher.
     - Every `20 - 50` seconds, users will randomly receive a duel partner that they need to defeat.
          - If neither party dies, both users will explode violently.
          - Killing the duelee will give the attacker `8` seconds of `Mini-crits`.

* **Heatwave**
     - **ID:** `22`
     - **Token:** `heatwave`
     - Every `36 - 72` seconds a heatwave will occur, which sets all players on fire.

* **Hyperheal**
     - **ID:** `23`
     - **Token:** `hyperheal`
     - **Conditional effect:** In-game playercount must be `3` or higher.
     - Medics are able to overheal infinitely.

* **Forceful**
     - **ID:** `24`
     - **Token:** `forceful`
     - **Rare variant:** `2%` chance of the knockback being increased by `1000%`
     - Increases knockback by `300%`

* **Assassins Indeed**
     - **ID:** `25`
     - **Token:** `assassins`
     - Both teams are forced to play Spy. Revolvers have one bullet per clip and they deal `10000%` more damage.

* **In Control**
     - **ID:** `26`
     - **Token:** `incontrol`
     - All players are forced to play Soldier. The following are also in effect:
          - Increases Air Control to `250`
          - All Soldier melee weapons crit while rocket jumping
          - Primary weapons mini-crit airborne targets.

* **Bodycount**
     - **ID:** `27`
     - **Token:** `bodycount`
     - **Conditional effect:** If the playercount is lower than `3`, the gamemode cannot be `Arena`
     - Killing a player grants the user `25` bonus max health.
          - The attacker also heals for this amount.
          - If a player disconnects and another joins in their place, they may get their health bonus.
               - For now this is a design choice to prevent newcomers from being overwhelmed.
     - This effect has two variants, each have a `50%` chance of occurring.
          - **Variant 1:** Bonus max health is lost upon death.
          - **Variant 2:** Bonus max health is kept after death.

* **Small**
     - **ID:** `28`
     - **Token:** `small`
     - **Rare variant:** `5%` chance of this value being `0.15`
     - Player size is multiplied by a random value between `0.35` and `0.70`
     - Voice pitch is multiplied by `1.4`

* **Mosquito Infestation**
     - **ID:** `29`
     - **Token:** `mosquito`
     - Causes players to mimic mosquitos. The following effects are in place:
          - All players are forced to play Scout.
          - Players can infinitely double jump.
          - Players deal `Mini-crits` while mid-air.
          - Secondary weapons deal `30%` more damage.
          - Secondary weapons have `200%` more reserve ammo.
          - Players are faster by `120%`
          - Player size is multiplied by `0.75`
          - Voice pitch is changed to `2.0`

* **Balanced**
     - **ID:** `30`
     - **Token:** `balanced`
     - **Conditional effect:** If the playercount is lower than `3`, the gamemode cannot be `Arena`
     - Each death will contribute towards a universal indicator of team balance.
          - This indicator keeps track of which team has a higher killcount.
               - If the indicator is positive, `RED` has a higher killcount, `BLU` will be favored.
               - If the indicator goes negative, `BLU` has a higher killcount, `RED` will be favored.
          - Each player will receive a max health bonus depending on how advantaged their team is.
          - Each surplus kill will give `3` extra max hp to every player in the losing team, while the winning team's players will lose the same amount of max hp.

* **Perilous Performance**
     - **ID:** `31`
     - **Token:** `pperform`
     - Players receive more damage if their kill-to-death ratio is higher than 1.
          - Caps at `+200%` (reached at 18:1 ratio)

* **Slowmo**
     - **ID:** `32`
     - **Token:** `slowmo`
     - This effect simulates slow motion without touching host_timescale.
          - Player speed is multiplied by `0.8`
          - Reload, firing, holster, deploy and projectile speed is reduced by `50%`
               - Does not apply to some projectiles.
          - Medic (over)healing speed is multipled by `0.5`
          - Gravity lowered to `350`
          - Voice pitch is changed to `0.7`

* **Invis**
     - **ID:** `33`
     - **Token:** `invis`
     - Every player becomes invisible.
          - Status effects (such as healing, jarate or fire) and some minor details (muzzle, reloading) can make players visible.

* **Secondary Combat**
     - **ID:** `34`
     - **Token:** `secondary`
     - **Rare variant:** `5%` chance of melee weapons being taken away as well.
     - Primary weapons cannot be used.
          - Spy is an exception, they will keep their revolvers.

* **Hell**
     - **ID:** `35`
     - **Token:** `hell`
     - Simulates true hell. The following effects are in place:
          - All players are forced to play Pyro.
          - The following flame attributes are changed:
               - Particle size is larger by `75%`
               - Spread area is increased by `40` degrees.
          - The following primary weapon attributes are changed:
               - Primary weapon ammo is increased by `250%`
               - Primary weapon firing rate is increased by `100%`
               - Airblast force is increased by `75%`
          - Secondary and melee weapons deal `25%` increased damage.
          - Voice pitch is changed to `0.5`

* **Social Distancing**
     - **ID:** `36`
     - **Token:** `socialdist`
     - **Conditional effect:** In-game playercount must be `3` or higher.
     - Teammates too close to each other receive `66%` of the damage taken by someone.
          - Radius: `256 Hammer Units`
          - This does not create a chain-reaction.

* **Disadvantaged**
     - **ID:** `37`
     - **Token:** `disadvantaged`
     - One special ability has been taken away from each class.
          - Scout can no longer double jump
          - Soldier can no longer rocket jump.
          - Pyro can no longer airblast.
          - Demoman can no longer use their secondary weapon.
          - Heavy can no longer use their secondary weapon.
          - Engineer can no longer build.
          - Medic can no longer use their medigun.
          - Sniper can no longer headshot.
          - Spy can no longer disguise.

* **No Scrubs Allowed**
     - **ID:** `38`
     - **Token:** `noscrubs`
     - Players are forced to play Sniper with only their primary and melee weapons.
     - Bodyshots will instantly kill the attacker.
          - Taunt kills are allowed.

* **What's a Reload?**
     - **ID:** `39`
     - **Token:** `infiniteclip`
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
     - **ID:** `40`
     - **Token:** `restriction`
     - Randomly bans `3 - 7` classes.
     - When trying to change to a banned class, the plugin will force the player to the first class that isn't banned.
          - This will cause bots to be restricted to that class!

* **Incognizance**
     - **ID:** `41`
     - **Token:** `nohud`
     - Some elements of the HUD become hidden while alive.
          - This includes the crosshair and all indicators (such as health, ammo, metal).

* **Horror Fortress**
     - **ID:** `42`
     - **Token:** `horror`
     - Greatly darkened screen.

* **Super Jump**
     - **ID:** `43`
     - **Token:** `superjump`
     - Crouching will create a non-damaging explosion below the player that acts like a rocket jump.
          - Cooldown: `4` seconds.

* **Pulley**
     - **ID:** `44`
     - **Token:** `pulley`
     - Hitting a player will pull them towards the attacker depending on damage dealt.

* **On Demand Glass Cannon**
     - **ID:** `45`
     - **Token:** `odglasscannon`
     - Players deal more damage depending on their health to max health ratio. The lower the health is, the more they damage.
          - Capped at `2x` damage.

* **Buffer's gambit**
     - **ID:** `46`
     - **Token:** `buffersgambit`
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

* **Skating Rink**
     - **ID:** `47`
     - **Token:** `skatingrink`
     - The server-wide friction is reduced to `0.1`

* **Stunning Metal**
     - **ID:** `48`
     - **Token:** `stunningmetal`
     - Greater instances of damage will slow down an enemy.
          - `25 <= damage < 50` causes `0.17` slowdown for `1.4` seconds.
          - `50 <= damage < 80` causes `0.32` slowdown for `2.6` seconds.
          - `80 <= damage < 110` causes `0.50` slowdown for `3.8` seconds.
          - `110 <= damage < 160` causes `0.75` slowdown for `5.0` seconds.
          - `160 <= damage` causes the player to be stunned for `5.0` seconds.

* **Death Stare**
     - **ID:** `49`
     - **Token:** `deathstare`
     - When two players look at each other, they both explode.
          - The check runs every `0.15` seconds (to avoid server overload) and is generally strict.
          - Limit is `3000 Hammer Units`

* **Quickswap**
     - **ID:** `50`
     - **Token:** `quickswap`
     - Two players will swap places every `3-8` seconds. There's a `25` second grace period after the round starts.
          - Players have their own `15` second grace period after swapping places so they're not teleported around too often.
          - Swaps can happen with players from opposing teams.

* **Mann vs. Machine**
     - **ID:** `51`
     - **Token:** `mvm`
     - **Conditional effect:** In-game playercount must be at most `40%` of the server's capacity **AND** the map must have a generated navigation mesh **AND** there must be no pre-existing bots.
     - Players are assigned to a team at random. `10%` more bots are added to the other team. An additional bot is added if possible.

* **Projectile Mayhem**
     - **ID:** `52`
     - **Token:** `pmayhem`
     - **Conditional effect:** In-game playercount must be `24` or less.
     - Every second a new projectile is assigned to non-sniper primary and non-demoman secondary weapons.
          - The damage of the projectile deals as much damage as the original weapon would.
          - These projectiles can be:
               - Default
               - Rocket
               - Syringe
               - Flare
               - Righteous Bison Particle

* **Shielding Medicine**
     - **ID:** `53`
     - **Token:** `shieldingmed`
     - **Rare variant:** `15%` chance of shield being `Level 2`
     - **Conditional effect:** In-game playercount must be `3` or higher.
     - Medics have the ability to use the `Level 1` Mann vs. Machine shield.

* **Piercing Bullets**
     - **ID:** `54`
     - **Token:** `piercingbull`
     - **Conditional effect:** In-game playercount must be `3` or higher.
     - Bullets go through enemy players.

* **Achievement Hunter**
     - **ID:** `55`
     - **Token:** `achievement`
     - When a player earns an achievement, they gain Powerplay for `12 seconds`
          - Speed bonus
          - Guaranteed Critical hits
          - Ubercharged

* **Buffing Heal**
     - **ID:** `56`
     - **Token:** `buffheal`
     - **Conditional effect:** In-game playercount must be `3` or higher.
     - Medic healing rate is reduced to `33%`
     - Users healed will now gain `Mini-crits`
          - If any healing was done using the Crusader's Crossbow, then the buff is also granted.
               - Formula (in seconds): `1.0 + healamount / 20.0`

* **Called for me?**
     - **ID:** `57`
     - **Token:** `mediccall`
     - **Conditional effect:** In-game playercount must be `3` or higher.
     - Calling for Medic will teleport one if there is a suitable candidate.
          - There's a `6` second delay between attempts.
          - Conditions for a Medic to be suitable:
               - Must exist and be within the same team as the caller.
               - Must not already be healing someone.
               - Wasn't teleported in the past `8` seconds.

* **King**
     - **ID:** `58`
     - **Token:** `king`
     - **Conditional effect:** Gamemode cannot be `Arena`.
     - At the start of the round a King is randomly selected.
          - Killing the King will give the title to the killer.
          - The King has the following effects:
               - `+50%` increased damage
               - `+20%` larger player model
               - `+300` max health
               - `+6` health per second

* **Identity Theft**
     - **ID:** `59`
     - **Token:** `identitytheft`
     - **Conditional effect:** If the playercount is lower than `3`, the gamemode cannot be `Arena`
     - Killing a player changes the attacker's class to their victim's.

* **Time Travel**
     - **ID:** `60`
     - **Token:** `timetravel`
     - Every `8 - 32` seconds, a snapshot is created. After `1 - 24` seconds, all players will be rolled back into that snapshot. Snapshots keep the following:
          - Position, viewangles and velocity
          - Health
          - Class
          - Weapon slot
          - Clip sizes for each weapon

* **Parry it!**
     - **ID:** `61`
     - **Token:** `parry`
     - **Rare variant:** `2%` chance of players being instantly killed when failing a parry.
     - All players gain the ability to parry.
          - Calling for Medic will initiate the parry.
          - Any incoming damage can be parried, but only one instance at a time.
          - Parrying has a time window of `0.25` seconds with a `1.5` second cooldown.
               - If the player didn't receive damage within the time window, they will take `1.25x` damage for `1.5` seconds.
               - If the player did receive damage, the cooldown is reduced to `0.5` seconds and incoming damage is nullified.

* **Grappling Hook**
     - **ID:** `62`
     - **Token:** `grapple`
     - **Conditional effect:** Grappling hook and spells must not be enabled.
     - Players can use the grappling hook.

* **Spellbound**
     - **ID:** `63`
     - **Token:** `spellbound`
     - **Conditional effect:** If the playercount is lower than `3`, the gamemode cannot be `Arena`. Grappling hook and spells must not be enabled.
     - **Rare variant:** `2%` chance of guaranteed spell drops.
     - Dead players have a `20%` chance of dropping a spell.

* **Fog of War**
     - **ID:** `64`
     - **Token:** `mist`
     - **Rare variant:** `6%` chance of the fog to be colored.
     - A fog takes over the map. The following properties are used:
          - blend: `1`
          - fogstart: `1`
          - fogstart: `1`
          - fogend: Between `400` and `800`
          - fogmaxdensity: Between `0.4` and `0.7`
          - (default) fogcolor: `216 207 194`

* **Cosplay**
     - **ID:** `65`
     - **Token:** `cosplay`
     - Upon spawning, players keep their weapons but swap classes.

* **Wallhack**
     - **ID:** `66`
     - **Token:** `wallhack`
     - All players are visible through walls.
          - If it doesn't work, make sure that `glow_outline_effect_enable` is set to `1`

* **Reviving Uber**
     - **ID:** `67`
     - **Token:** `reviveuber`
     - **Conditional effect:** In-game playercount must be `3` or higher.
     - Activating uber revives players in exchange of `25%` ubercharge.

* **Continental Advantage**
     - **ID:** `68`
     - **Token:** `ping`
     - Damage scales based on ping between `50%` and `500%`

* **Mercenary Airdrop**
     - **ID:** `69`
     - **Token:** `airdrop`
     - **Conditional effect:** In-game playercount must be `3` or higher **AND** gamemode cannot be `Arena`
     - Players respawn on whoever they are spectating.

* **Bounty**
     - **ID:** `70`
     - **Token:** `bounty`
     - **Conditional effect:** Gamemode cannot be `Arena`
     - Every `45` seconds a new bounty appears.
          - A bounty specifies a weapon that players need to kill someone with.
               - Doing so grants `8` seconds of Powerplay.
               - The bounty may only be claimed once.
               - Reskins can be used.

* **2007**
     - **ID:** `71`
     - **Token:** `veteran`
     - Hats and unusual effects are removed.

* **Freeform Respawn**
     - **ID:** `72`
     - **Token:** `freerespawn`
     - **Conditional effect:** Gamemode cannot be `Arena`
     - After dying, players are sent into a ghost state, in which they can choose where they wish to respawn.
          - Classes must be changed while alive.

* **Kitswap**
     - **ID:** `73`
     - **Token:** `kitswap`
     - Ammo and health pickups have swapped functionality.

* **Pumpkin Bomber**
     - **ID:** `74`
     - **Token:** `pumpkin`
     - **Rare variant:** `3%` chance of the cooldown being `8` seconds.
     - Players can call for a medic to spawn a pumpkin bomb.
          - Cooldown: `24` seconds.
          
* **Suicide Bomber**
     - **ID:** `75`
     - **Token:** `bomber`
     - **Conditional effect:** If the playercount is lower than `3`, the gamemode cannot be `Arena`
     - Suiciding causes an explosion that damages nearby enemies.
          - Radius: `300 Hammer Units`
          - Max damage: `200`

* **Universal Wear**
     - **ID:** `76`
     - **Token:** `universalwear`
          - **Conditional effect:** If the playercount is lower than `3`, the gamemode cannot be `Arena`
     - When a player is killed with a certain weapon, said weapon will do `2%` less damage for every player on the server.
          - Damage of reskins is the same as the damage of their original counterpart.
