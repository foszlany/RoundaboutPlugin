# Roundabout
**Roundabout** is a TF2 server plugin that rolls a random effect each round to make the gameplay as fun and refreshing as possible.

**TF2Attributes** is required for this plugin to run on your server.<br>

## Effects
#### Effects vary greatly in complexity.
- Some may only appear under certain conditions, such as ample player count.<br>
- Some may have multiple variants. These can take form in:
     - Randomness *(e.g. slightly randomized low gravity)*
     - Rare chance of great amplification *(e.g. extreme increase in knockback)*
     - Custom modifications *(e.g. persistent or temporary additive buff upon killing someone)*<br><br>

Read the effect details [here](./docs/effects.md).<br><br>

## Commands
### User commands
* **roundabout_github** - Links to the GitHub repository<br>
* **roundabout_version** - Returns the version of the plugin<br>

### Admin commands
* **roundabout_force \<id\>** - Forces a new round with a desired effect<br>
     -  **id:** ID of the effect.<br>
          - Chosen randomly when not given.
          - When given, it ignores all conditions for certain effects. May cause unwanted effects.
     -  Example usage: `!roundabout_force 1`<br>
* **roundabout_enable \<arg\>** - Enables or disables the plugin effects<br>
     -  **arg:** 1 or 0 (enable or disable) <br>
     -  Enabling the effects will not restart the round.
     -  Example usage: `!roundabout_enable 0`

### ConVars
* **sm_roundabout_toggle \<arg\>** - Enables or disables the plugin effects<br>
     -  **arg:** 1 or 0 (enable or disable) <br>
     -  Enabling the effects will not restart the round.<br><br>

## Compile
The compiled plugin version `roundabout.smx` can be found inside the `plugin` folder.<br>

**TF2Attributes** is required to compile this plugin.

If you wish to compile the source code yourself, use [this](https://github.com/modcommunity/how-to-compile-sourcemod-plugins) guide.

Alternatively you can use the VSCode extension [SourcePawn Studio](https://github.com/Sarrus1/sourcepawn-studio) and follow its [Quick Start](https://sarrus1.github.io/sourcepawn-studio/docs/quick-start/) guide.

If you wish to create your own effects, read about how to do that [here](./docs/create_effect.md).<br><br>