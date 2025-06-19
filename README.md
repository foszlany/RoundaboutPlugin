# Roundabout
**Roundabout** is a TF2 server plugin that rolls a random effect each round to make the gameplay as chaotic as possible.

The plugin is currently under heavy development, more features are being added.<br><br>

## Effects
Read the effect details [here](./docs/effects.md).<br><br>

## Commands
### User commands
* **roundabout_github** - Links to the GitHub repository<br>
* **roundabout_version** - Returns the version of the plugin<br>

### Admin commands
* **roundabout_force \<id\>** - Forces a new round with a desired effect<br>
     -  **id:** ID of the effect. Chosen randomly when not given. <br>
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
The compiled plugin version `roundabout.smx` can be found inside the `plugin` folder.<br><br>

If you wish to compile the source code yourself, use [this](https://github.com/modcommunity/how-to-compile-sourcemod-plugins) guide.

Alternatively you can use the VSCode extension [SourcePawn Studio](https://github.com/Sarrus1/sourcepawn-studio) and follow its [Quick Start](https://sarrus1.github.io/sourcepawn-studio/docs/quick-start/) guide.