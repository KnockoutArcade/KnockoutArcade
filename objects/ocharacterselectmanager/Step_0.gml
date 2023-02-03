/// @description Insert description here
// You can write your code in this editor

// Player 1 cursor vars
var P1menuLeft = global.p1ButtonLeft;
var P1menuRight = global.p1ButtonRight;
var P1menuColMove = P1menuLeft + P1menuRight;

var P1menuUp = global.p1ButtonUp;
var P1menuDown = global.p1ButtonDown;
var P1menuRowMove = P1menuUp + P1menuDown;

var P1menuConfirm = global.p1ButtonLight;
var P1menuCancel = global.p1ButtonMedium;
var P1menuConfirmBuffer = false;
var P1menuAltSelBuffer = false;

// Player 2 cursor vars
var P2menuLeft = global.p2ButtonLeft;
var P2menuRight = global.p2ButtonRight;
var P2menuColMove = P2menuLeft + P2menuRight;

var P2menuUp = global.p2ButtonUp;
var P2menuDown = global.p2ButtonDown;
var P2menuRowMove = P2menuUp + P2menuDown;

var P2menuConfirm = global.p2ButtonLight;
var P2menuCancel = global.p2ButtonMedium;
var P2menuConfirmBuffer = false;

P1cursorCooldown--;
P2cursorCooldown--;

charSelBoxTimer++;

// Handle P1 cursor movement
if P1menuColMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedChar {
	P1charSelCol += P1menuColMove;
	P1cursorCooldown = 10;
}
if P1menuRowMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedChar {
	P1charSelRow += P1menuRowMove;
	P1cursorCooldown = 10;
}
if P1menuRowMove == 0 && P1menuColMove == 0 P1cursorCooldown = 0;
if P1charSelCol > charSelColMax P1charSelCol = 0;
if P1charSelCol < 0 P1charSelCol = charSelColMax;
if P1charSelRow > charSelRowMax P1charSelRow = 0;
if P1charSelRow < 0 P1charSelRow = charSelRowMax;

if P1menuConfirm && !P1hasSelectedChar{
	P1hasSelectedChar = true;
	P1menuConfirmBuffer = true;
}

if P1menuCancel {
	if P1hasSelectedAlt P1hasSelectedAlt = false;
	else if P1hasSelectedChar P1hasSelectedChar = false;
	
	RTF_animTimer = 0;
	RTF_currentFrame = 0;
}

// Handle Palette Selection
if P1hasSelectedChar {
	if P1menuColMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedAlt{
	global.p1PaletteID += P1menuColMove;
	P1cursorCooldown = 10;
	
	if global.p1PaletteID >= global.RusselPalettes.numOfPalettes global.p1PaletteID = 0;
	if global.p1PaletteID < 0 global.p1PaletteID = global.RusselPalettes.numOfPalettes - 1;
	
	}
	
	if P1menuConfirm && !P1menuConfirmBuffer && !P1hasSelectedAlt{
		P1hasSelectedAlt = true;
		P1menuAltSelBuffer = true;
	}
}


// Handle P2 cursor movement
if P2menuColMove != 0 && P2cursorCooldown < 1 && !P2hasSelectedChar {
	P2charSelCol += P2menuColMove;
	P2cursorCooldown = 10;
}
if P2menuRowMove != 0 && P2cursorCooldown < 1 && !P2hasSelectedChar {
	P2charSelRow += P2menuRowMove;
	P2cursorCooldown = 10;
}
if P2menuRowMove == 0 && P2menuColMove == 0 P2cursorCooldown = 0;
if P2charSelCol > charSelColMax P2charSelCol = 0;
if P2charSelCol < 0 P2charSelCol = charSelColMax;
if P2charSelRow > charSelRowMax P2charSelRow = 0;
if P2charSelRow < 0 P2charSelRow = charSelRowMax;

if P2menuConfirm && !P2hasSelectedChar{
	P2hasSelectedChar = true;
	P2menuConfirmBuffer = true;
}

if P2menuCancel {
	if P2hasSelectedAlt P2hasSelectedAlt = false;
	else if P2hasSelectedChar P2hasSelectedChar = false;
	
	RTF_animTimer = 0;
	RTF_currentFrame = 0;
}

// Handle Palette Selection
if P2hasSelectedChar {
	if P2menuColMove != 0 && P2cursorCooldown < 1 && !P2hasSelectedAlt{
	global.p2PaletteID += P2menuColMove;
	P2cursorCooldown = 10;
	
	// Handle Palette Data
	if global.p2PaletteID >= global.RusselPalettes.numOfPalettes global.p2PaletteID = 0;
	if global.p2PaletteID < 0 global.p2PaletteID = global.RusselPalettes.numOfPalettes - 1;
	
	}
	
	if P2menuConfirm && !P2menuConfirmBuffer {
		P2hasSelectedAlt = true;
		P2menuConfirmBuffer = true;
	}
}


if charSelBoxTimer > 4 {
	charSelBoxAlt = !charSelBoxAlt;
	charSelBoxTimer = 0;
}

// Character Select Animations
charSelAnimTimer++;
if charSelAnimTimer > (60 / charSelFrameRate) {
	charSelAnimTimer = 0;
	P1charSelCurrentFrame++;
}

// Ready To Fight Animations
if P1hasSelectedAlt && P2hasSelectedAlt RTF_animTimer++;
if RTF_animTimer >= (60 / RTF_frameRate) && RTF_currentFrame != 4 {
	RTF_animTimer = 0;
	RTF_currentFrame++;
}



// Advance to match
if P1hasSelectedAlt && P2hasSelectedAlt && P1menuConfirm && !P1menuAltSelBuffer {
	if keyboard_check(vk_enter) room = rRusselStage;
	else if keyboard_check(vk_shift) room = rBeverlyStage;
	else if keyboard_check(vk_control) room = rJayStage;
	else room = rStageArcade;
}