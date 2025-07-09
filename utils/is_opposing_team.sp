#pragma semicolon 1

public bool IsOpposingTeam(int client1, int client2) {
    TFTeam team1 = TF2_GetClientTeam(client1);
    TFTeam team2 = TF2_GetClientTeam(client2);

    bool isValidTeam1 = (team1 == TFTeam_Red || team1 == TFTeam_Blue);
    bool isValidTeam2 = (team2 == TFTeam_Red || team2 == TFTeam_Blue);

    return (isValidTeam1 && isValidTeam2 && team1 != team2);
}