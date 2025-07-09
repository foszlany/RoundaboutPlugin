#pragma semicolon 1

public void ExplodePlayer(int client) {
     FakeClientCommand(client, "explode");
     EmitSoundToClient(client, "weapons/explode3.wav");
}