/// @description Insert description here
// You can write your code in this editor

// This is where the "File Select" Text goes
titlePositionX = 0;
titlePositionY = 0;

// This is the bar on the left that reads "KO"
leftmostBar = layer_get_id("LeftmostBar");
leftmostBarPositionX = 0;

// This is the location of the first save file
file1PositionX = 0;
file1PositionY = 0;

// Second save file
file2PositionX = 0;
file2PositionY = 0;

// Third save file
file3PositionX = 0;
file3PositionY = 0;

// Y-Location where the files rest
fileDestinationY = 37;

// How fast the files move on the screen
fileMovementSpeed = 0.2;

// Animation Timer
animTimer = 0;

state = eFILESELECTMENUSTATES.INTRO;

enum eFILESELECTMENUSTATES
{
	INTRO,
	SELECTING_FILE,
	DELETING_FILE,
	COPYING_FILE,
	CHOSE_FILE
}