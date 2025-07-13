# Roundabout Effects

* **Pure**<br>
     - ID: `0`
     - Vanilla TF2 experience, doesn't change anything.
     - <details><summary>SPOILER</summary>There's a 10% chance of a one-time event occurring sometime between 60 and 160 seconds where everyone will be forced to A-pose without the ability to move or use weapons. This lasts 12 seconds, after which users will explode.</details>

* **Low Gravity**<br>
     - ID: `1`
     - **CONDITIONAL EFFECT:** Gravity must be higher than 400.
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
     - Killing the last player who killed another will grant them crits for `8` seconds.

 * **Infection Tag**<br>
     - ID: `20`
     - **CONDITIONAL EFFECT:** In-game playercount must be 4 or higher.
     - Killing a player will force them into the opposing team. The round is over when all players belong in 1 team (or when the objective is completed).

 * **Duelies**<br>
     - ID: `21`
     - **CONDITIONAL EFFECT:** In-game playercount must be 3 or higher.
     - Every `20 - 46` seconds, users will randomly receive a duel partner that they need to defeat.
          - If neither party dies, both users will explode violently.
          - Killing the duelee will give the attacker `8` seconds of Mini-crits.

* **Heatwave**<br>
     - ID: `22`
     - Every `36 - 72` seconds a heatwave will occur, which sets all players on fire.

* **Hyperheal**<br>
     - ID: `23`
     - **CONDITIONAL EFFECT:** In-game playercount must be 3 or higher.
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
          - Gravity lowered to `350`.

* **Invis**
     - ID: `33`
     - Everyone is invisible.
          - Status effects (such as healing, jarate or fire) can make players visible.