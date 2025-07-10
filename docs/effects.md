# Roundabout Effects

* **Pure**<br>
     - ID: `0`
     - Vanilla TF2 experience, doesn't change anything.
     - <details><summary>SPOILER</summary>There's a 20% chance of a one-time event occurring sometime between 60 and 160 seconds where everyone will be forced to A-pose without the ability to move or use weapons. This lasts 12 seconds, after which users will explode.</details>

* **Low Gravity**<br>
     - ID: `1`
     - Lowers the gravity to a random value between `100` and `400`.
          - Additionally, there's a `2%` chance of the gravity being `0`

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
     - All player-to-player damage is reduced to a mere `33%`.

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