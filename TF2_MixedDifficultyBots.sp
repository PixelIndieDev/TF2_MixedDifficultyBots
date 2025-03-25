#include <sourcemod>

public Plugin:myinfo = {
	name = "TF2: Bots With Random Difficulty",
	author = "PixelIndieDev",
	description = "Assigns random difficulty levels to TF2 bots, with a higher chance of selecting a specific difficulty level",
	version = "1.1"
};

// Console variables (ConVars) for configuring bot difficulty behavior
//(0: Easy, 1: Normal, 2: Hard, 3: Expert)
new Handle:sm_tf2_bot_difficulty_min = INVALID_HANDLE;
new Handle:sm_tf2_bot_difficulty_max = INVALID_HANDLE;
new Handle:sm_tf2_bot_preferred_difficulty = INVALID_HANDLE;
new Handle:sm_tf2_bot_chance_to_select_preferred_difficulty = INVALID_HANDLE;

// Handle for the internal TF2 bot difficulty ConVar
new Handle:tfbotdifficulty = INVALID_HANDLE;

/**
 * Initializes ConVars and sets the initial bot difficulty.
 */
public OnPluginStart() {
	sm_tf2_bot_difficulty_min = CreateConVar("sm_tf2_bot_difficulty_min", "0", "The minimum allowed difficulty for a TF2 bot", FCVAR_PLUGIN, true, 0.0, true, 3.0);
	sm_tf2_bot_difficulty_max = CreateConVar("sm_tf2_bot_difficulty_max", "3", "The maximum allowed difficulty for a TF2 bot", FCVAR_PLUGIN, true, 0.0, true, 3.0);
	sm_tf2_bot_preferred_difficulty = CreateConVar("sm_tf2_bot_preferred_difficulty", "1", "The bot difficulty level that has a higher chance of being selected", FCVAR_PLUGIN, true, 0.0, true, 3.0);
	sm_tf2_bot_chance_to_select_preferred_difficulty = CreateConVar("sm_tf2_bot_chance_to_select_preferred_difficulty", "35", "The percentage chance the preferred bot difficulty has to be selected", FCVAR_PLUGIN, true, 0.0, true, 100.0);

	tfbotdifficulty = FindConVar("tf_bot_difficulty");

	SetRandomTF2BotDifficulty();
}

/**
 * If the client is a bot, the difficulty level is randomized.
 */
public OnClientAuthorized(client) {

	if (IsFakeClient(client))
    {
        SetRandomTF2BotDifficulty();
    }
}

public SetRandomTF2BotDifficulty() {

	// Determine difficulty based on the configured probability
	if (GetRandomInt(1, 100) <= GetConVarInt(sm_tf2_bot_chance_to_select_preferred_difficulty)) {
		// Apply the selected difficulty level
		SetConVarInt(tfbotdifficulty, GetConVarInt(sm_tf2_bot_preferred_difficulty));
	} else {
		// Apply the selected difficulty level
		SetConVarInt(tfbotdifficulty, GetRandomInt(GetConVarInt(sm_tf2_bot_difficulty_min), GetConVarInt(sm_tf2_bot_difficulty_max)));
	}
	
}