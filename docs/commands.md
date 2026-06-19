# Roundabout Commands and ConVars
### User commands
* **roundabout|ra \<command>** - Universal command that can simulate every command without an underscore.
     -  **command:** Command and its arguments.
          - Available parameters
               - User
                    - **roundabout_help**: `help|h`
                    - **roundabout_github**: `github|gh`
                    - **roundabout_version**: `version|v`
                    - **roundabout_voteskip**: `voteskip|vs`
                    - **roundabout_effectlist**: `effectlist|el`
                    - **roundabout_effect**: `effect|e`
               - Admin
                    - **roundabout_force**: `force|f`
               - Root
                    - **roundabout_enable**: `enable`
          - Example usages:
               - `!roundabout help`
               - `!roundabout e lowgravityr`
               - `!ra f medieval vampire`
* **roundabout_help** - Returns the commands that can be used into the player's console.
* **roundabout_github** - Returns the link to the GitHub repository.
* **roundabout_version** - Returns the version of the plugin.
* **roundabout_voteskip** - Initiates a voteskipping process to force a new round.
     -  Requires at least half the players.
* **roundabout_effectlist** - Opens a menu with all the effects.
* **roundabout_effect \<token\>** - Shows the effect details on the screen.
     -  **token:** ID or token of the effect.
          - Current effect when not given.
     -  Example usages:
          - `!roundabout_effect 50`
          - `!roundabout_effect bleedbuffed`

### Admin commands
* **roundabout_force [c|count \<n>  ||  \<token...>[r]]** - Forces a new round with a desired effect.<br>
     -  **token:** IDs or tokens of the effect.<br>
          - Chosen randomly when not given.
          - IDs and tokens can be mixed.
          - When given, it ignores all conditions for certain effects.
               - May cause unwanted effects. Generally this should just mean that no significant gameplay changes will take place.
          - Some effects are mutually exclusive and they cannot be forced either.
          - An `r` modifier can be used to force rare variants of an effect.
               - Doesn't do anything if an effect has no such variant.
          - Example usages:
               - `!roundabout_force`
               - `!roundabout_force 23`
               - `!roundabout_force parryr`
               - `!roundabout_force 1r 2 3 4 5`
               - `!roundabout_force 16r 2 3 lowgravityr`<br>
     - **n:** Specifies the amount of random effects to generate
          - Must be used together with `count`
          - Example usages:
               - `!roundabout_force count 2`
               - `!roundabout_force c 4`<br>
* **roundabout_blacklist [\<on|off> || <add|remove> \<token>]** - Manages the blacklist.
     -  **on|off:** Enable/disable the blacklist.
          - Can be modified while off.
     -  **add|remove \<token>:** Add/remove an effect from the blacklist.
          - **token**: ID or token of the effect.
          - Effects can be manually toggled inside `addons/sourcemod/configs/roundabout_blacklist.cfg`
* **roundabout_enable <0|1>** - Enables or disables the plugin effects.<br>
     -  Enabling the effects will not restart the round.

### ConVars
* **sm_roundabout_toggle <0|1>** - Enables or disables the plugin effects<br>
     - **Default:** `1`
     - Enabling the effects will not restart the round.
* **sm_roundabout_multieffect_max_count <1-10>** - Determines the max amount of effects that can naturally appear
     - **Default:** `5`
     - More effects can be forced.
* **sm_roundabout_multieffect_base_chance <0-1>** - Base chance of a double-effect round
     - **Default:** `0.08`
     - The total chance of a multieffect round is roughly double this value.
* **sm_roundabout_multieffect_rarity_multiplier <0-100>** - Determines the rarity multiplier for a multieffect round
     - **Default:** `2`
     - An additional effect will be rarer by this much
     - For example if 2 effects has a probability of `0.08`, then 3 effects has `0.04` with a multiplier of `2`