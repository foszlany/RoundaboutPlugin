### User commands
* **roundabout_help** - Returns the commands that can be used into the player's console.<br>
* **roundabout_github** - Returns the link to the GitHub repository.<br>
* **roundabout_version** - Returns the version of the plugin.<br>
* **roundabout_effectlist** - Returns the effect doc.<br>
* **roundabout_effect \<id\>** - Shows the effect details on the screen.<br>
     -  **id:** ID of the effect.<br>
          - Current effect when not given.
     -  Example usage: `!roundabout_effect 50`<br>

### Admin commands
* **roundabout_force \<id\>** - Forces a new round with a desired effect.<br>
     -  **id:** ID of the effect.<br>
          - Chosen randomly when not given.
          - When given, it ignores all conditions for certain effects.
               - May cause unwanted effects. Generally this should just mean that no significant gameplay changes will take place.
     -  Example usage: `!roundabout_force 1`<br>
* **roundabout_enable \<arg\>** - Enables or disables the plugin effects.<br>
     -  **arg:** 1 or 0 (enable or disable) <br>
     -  Enabling the effects will not restart the round.
     -  Example usage: `!roundabout_enable 0`