/// @description Insert description here
// You can write your code in this editor

// This is where the "File Select" Text goes
// Initialize title text location
titlePositionX = -160;
titlePositionY = 8;

// This is the bar on the left that reads "KO"
leftmostBar = layer_get_id("LeftmostBar");
leftmostBarPositionX = -10;
layer_x(leftmostBar, leftmostBarPositionX);
leftmostBarTargetPosition = 5;

// This is the location of the first save file
file1PositionX = 16;
file1PositionY = 130;

// file 2
file2PositionX = 64;
file2PositionY = 130;

// file 3
file3PositionX = 112;
file3PositionY = 130;

// Y-Location where the files rest
fileDestinationY = 37;

// How fast the files move on the screen
fileMovementSpeed = 0.2;

// Which file we're currently selecting
selectedFile = 0;
isSelectingFile1 = false; // These are for the draw event
isSelectingFile2 = false;
isSelectingFile3 = false;

// What color to draw the text for each file
file1DrawColor = #38343b;
file2DrawColor = #38343b;
file3DrawColor = #38343b;

// Animation Timer
animTimer = 0;

// State Machine
state = eFILESELECTMENUSTATES.INTRO;
enum eFILESELECTMENUSTATES
{
	INTRO,
	SELECTING_FILE,
	DELETING_FILE,
	COPYING_FILE,
	CHOSE_FILE
}

// Menu Vars
menuHorizontalDirection = 0;
menuCooldown = 13;
menuCooldownTimer = 0;