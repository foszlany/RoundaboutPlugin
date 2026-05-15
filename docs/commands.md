# Roundabout Commands
### User commands
* **roundabout_help** - Returns the commands that can be used into the player's console.<br>
* **roundabout_github** - Returns the link to the GitHub repository.<br>
* **roundabout_version** - Returns the version of the plugin.<br>
* **roundabout_voteskip** - Initiates a voteskipping process to force a new round.<br>
     -  Requires at least half the players.<br>
* **roundabout_effectlist** - Returns the effect doc.<br>
* **roundabout_effect \<id\>** - Shows the effect details on the screen.<br>
     -  **id:** ID of the effect.<br>
          - Current effect when not given.
     -  Example usage: `!roundabout_effect 50`<br>

### Admin commands
* **roundabout_force [c|count \<n>  ||  \<id...>]** - Forces a new round with a desired effect.<br>
     -  **id:** ID of the effect.<br>
          - Chosen randomly when not given.
          - When given, it ignores all conditions for certain effects.
               - May cause unwanted effects. Generally this should just mean that no significant gameplay changes will take place.
          - Some effects are mutually exclusive and they cannot be forced either.
          - Example usages:
               - `!roundabout_force`
               - `!roundabout_force 23`
               - `!roundabout_force 1 2 3 4 5`<br>
     - **n:** Specifies the amount of random effects to generate
          - Must be used together with `count`
          - Example usages:
               - `!roundabout_force count 2`
               - `!roundabout_force c 4`<br>
* **roundabout_enable <0|1>** - Enables or disables the plugin effects.<br>
     -  Enabling the effects will not restart the round.

### ConVars
* **sm_roundabout_toggle <0|1>** - Enables or disables the plugin effects<br>
     -  Enabling the effects will not restart the round.<br><br>