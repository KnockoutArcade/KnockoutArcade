/// @description Insert description here
// You can write your code in this editor

// Speed Vars
maxSpeed = 1.5;
acceleration = 0.3;

// Movement Vars
moveDirection = 0;
moveSpeed = 0;
xSpeed = 0;
ySpeed = 0;

// Initialize Coordinates
x = global.campaignMapLocationX;
y = global.campaignMapLocationY;

// Animation Vars
animTimer = 0;

// Sprites
// note - these are inside a struct so that it will be easier to replace them with other character sprites.
OverworldSprites = {
	sideways_Sprite : sOverworldRussel_Side,
	upwards_Sprite : sOverworldRussel_Up,
	downwards_Sprite : sOverworldRussel_Down,
	diagonalUpwards_Sprite: sOverworldRussel_UpDiagonal,
	diagonalDownwards_Sprite : sOverworldRussel_DownDiagonal
}

mostRecentControllerType = CONTROLLER_TYPES.PAD;