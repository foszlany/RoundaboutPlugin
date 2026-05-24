#pragma semicolon 1

public Action Command_VoteSkip(int client, int args) {
     if(!g_VoteSkip[client]) {
          g_VoteSkip[client] = true;
          g_VoteSkipCount++;

          int requiredVotes = GetClientCount() == 2 ? 2 : GetClientCount() / 2;
          if(g_VoteSkipCount >= requiredVotes) {
               g_VoteSkipCount = 0;
               for(int i = 1; i <= MAXPLAYERS; i++) {
                    g_VoteSkip[i] = false;
               }

               ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Voteskip passed! Restarting round...");
               ServerCommand("mp_restartgame 1");
          }
          else {
               PrintToChatAll("\x07B143F1[Roundabout]\x01 %N has voted to skip the current effect using !roundabout_voteskip. (%d/%d)", client, g_VoteSkipCount, requiredVotes);
          }
     }
     else {
          ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 You have already voted to skip this effect.");
     }

     return Plugin_Handled;
}