#include <sourcemod>

public Plugin:myinfo = {
	name = "TF2: Bots With Random Difficulty",
	author = "PixelIndieDev",
	description = "Make bots use a random difficulty levels with more easy bots then other difficulty bots",
	version = "1.0"
};

new Handle:tfbotdifficulty = INVALID_HANDLE;

public OnPluginStart() {
	tfbotdifficulty = FindConVar("tf_bot_difficulty");
}

public OnClientAuthorized(client) {

	if (IsFakeClient(client))
    {
        int difficulty = GetRandomInt(0, 4);

		if (difficulty>3) {
			difficulty = 0;
		}

        SetConVarInt(tfbotdifficulty, difficulty);
    }
}