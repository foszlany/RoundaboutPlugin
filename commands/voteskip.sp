#pragma semicolon 1

public Action Command_VoteSkip(int client, int args) {
     if(!g_voteSkip[client]) {
          g_voteSkip[client] = true;
          g_voteSkipCount++;

          int requiredVotes = GetClientCount() == 2 ? 2 : GetClientCount() / 2;
          if(g_voteSkipCount >= requiredVotes) {
               g_voteSkipCount = 0;
               for(int i = 1; i <= MAXPLAYERS; i++) {
                    g_voteSkip[i] = false;
               }

               ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 Voteskip passed! Restarting round...");
               ServerCommand("mp_restartgame 1");
          }
          else {
               PrintToChatAll("\x07B143F1[Roundabout]\x01 %N has voted to skip the current effect using !roundabout_voteskip. (%d/%d)", client, g_voteSkipCount, requiredVotes);
          }
     }
     else {
          ReplyToCommand(client, "\x07B143F1[Roundabout]\x01 You have already voted to skip this effect.");
     }

     return Plugin_Handled;
}