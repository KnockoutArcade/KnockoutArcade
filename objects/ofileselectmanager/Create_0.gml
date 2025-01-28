/// @description Insert description here
// You can write your code in this editor

// This is where the "File Select" Text goes
// Initialize title text location
titlePositionX = -160;
titlePositionY = 8;

titleSubimage = 0; // Which text to display: "File Select" or "Character Select"

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

// What color to use for the file number
file1DrawColor = #38343b;
file2DrawColor = #38343b;
file3DrawColor = #38343b;

// What color to use for the time played an completion percent
file1TextDrawColor = #b2b2b2;
file2TextDrawColor = #b2b2b2;
file3TextDrawColor = #b2b2b2;

// Where the character voucher is
characterVoucherPositionX = 160;
characterVoucherPositionY = 0;

characterVoucherTargetPositionX = 42;
characterVoucherTargetPositionY = 52;
// NOTE: There may be more than one character voucher in the far future.
// When the time comes, make the vouchers into structs so that it's easier
// to iterate through them.

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
	CHOSE_FILE,
	CANCEL_CHARACTER_SELECT,
	CHARACTER_SELECT_INTRO,
	SELECTING_CHARACTER,
	START_GAME
}

// Menu Vars
menuHorizontalDirection = 0;
menuCooldown = 13;
menuCooldownTimer = 0;

// Sprite font
fileFont = font_add_sprite_ext(sSingleplayerHudNumbers, "0123456789.:-%", true, 1);