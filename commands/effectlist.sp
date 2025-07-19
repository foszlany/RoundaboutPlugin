#pragma semicolon 1

public Action Command_EffectList(int client, int args) {
     ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Effect list: https://github.com/foszlany/RoundaboutPlugin/blob/main/docs/effects.md");
     return Plugin_Handled;
}