/// @description Insert description here
// You can write your code in this editor

// Inputs
// Find the first controller
var slot0Controller = FindController(0); // Find the first gamepad ID
var wasdController = FindController(13); // Find the WASD controller object

// Both the first controller slot and the WASD controller can control the file screen

// initialize the inputs
var moveLeft = 0;
var moveRight = 0;
var moveUp = 0;
var moveDown = 0;

var confirm = 0;
var returnToMainMenu = 0;

// Handle detecting controller inputs
if (slot0Controller != -1)
{
	if (slot0Controller.buttonMenuLeft == -1) 
	{
		moveLeft = -1;
		mostRecentControllerType = CONTROLLER_TYPES.PAD;
	}
	if (slot0Controller.buttonMenuRight) 
	{
		moveRight = 1;
		mostRecentControllerType = CONTROLLER_TYPES.PAD;
	}
	
	if (slot0Controller.buttonMenuUp) 
	{
		moveUp = 1;
		mostRecentControllerType = CONTROLLER_TYPES.PAD;
	}
	if (slot0Controller.buttonMenuDown == -1) 
	{
		moveDown = -1;
		mostRecentControllerType = CONTROLLER_TYPES.PAD;
	}

	if (slot0Controller.buttonMenuConfirm) 
	{
		confirm = true;
		mostRecentControllerType = CONTROLLER_TYPES.PAD;
	}
	if (slot0Controller.buttonMenuDeny) 
	{
		returnToMainMenu = true;
		mostRecentControllerType = CONTROLLER_TYPES.PAD;
	}
}
// Handle detecting WASD inputs
if (wasdController != -1)
{
	if (wasdController.buttonMenuLeft == -1) 
	{
		moveLeft = -1;
		mostRecentControllerType = CONTROLLER_TYPES.WASD;
	}
	if (wasdController.buttonMenuRight) 
	{
		moveRight = 1;
		mostRecentControllerType = CONTROLLER_TYPES.WASD;
	}
	
	if (wasdController.buttonMenuUp) 
	{
		moveUp = 1;
		mostRecentControllerType = CONTROLLER_TYPES.WASD;
	}
	if (wasdController.buttonMenuDown == -1) 
	{
		moveDown = -1;
		mostRecentControllerType = CONTROLLER_TYPES.WASD;
	}

	if (wasdController.buttonMenuConfirm) 
	{
		confirm = true;
		mostRecentControllerType = CONTROLLER_TYPES.WASD;
	}
	if (wasdController.buttonMenuDeny) 
	{
		returnToMainMenu = true;
		mostRecentControllerType = CONTROLLER_TYPES.WASD;
	}
}

// Movement Calculation
#region

var horizontalMovement = moveRight + moveLeft;
var verticalMovement = -(moveUp + moveDown);

// Get the angle to move towards
moveDirection = point_direction(0, 0, horizontalMovement, verticalMovement);

// Set how fast to move the player
if (horizontalMovement != 0 || verticalMovement != 0)
{
	moveSpeed += acceleration;
	
	if (moveSpeed >= maxSpeed)
	{
		moveSpeed = maxSpeed;
	}
}
else
{
	moveSpeed = 0;
}

xSpeed = lengthdir_x(moveSpeed, moveDirection);
ySpeed = lengthdir_y(moveSpeed, moveDirection);

#endregion

// Collision
#region

if (place_meeting(x + xSpeed, y, oWall))
{
	x = round(x);
	
	while !(place_meeting(x + sign(xSpeed), y, oWall))
	{
		x += sign(xSpeed);
	}
	xSpeed = 0;
}

x += xSpeed;

if (place_meeting(x, y + ySpeed, oWall))
{
	y = round(y);
	
	while !(place_meeting(x, y + sign(ySpeed), oWall))
	{
		y += sign(ySpeed);
	}
	ySpeed = 0;
}
y += ySpeed;

#endregion

// Animation
#region

animTimer++;

// If moving horizontally...
if (horizontalMovement != 0 && verticalMovement == 0)
{
	sprite_index = OverworldSprites.sideways_Sprite;
	image_xscale = horizontalMovement;
}
else if (horizontalMovement != 0 && verticalMovement == -1) // Travelling up and diagonally
{
	sprite_index = OverworldSprites.diagonalUpwards_Sprite;
	image_xscale = horizontalMovement;
}
else if (horizontalMovement != 0 && verticalMovement == 1) // Travelling down and diagonally
{
	sprite_index = OverworldSprites.diagonalDownwards_Sprite;
	image_xscale = horizontalMovement;
}
else if (horizontalMovement == 0 && verticalMovement == -1) // Travelling straight up
{
	sprite_index = OverworldSprites.upwards_Sprite;
}
else if (horizontalMovement == 0 && verticalMovement == 1) // Travelling straight down
{
	sprite_index = OverworldSprites.downwards_Sprite;
}
else // Not moving at all
{
	image_index = 0;
	animTimer = 0;
}

// If we have just started moving, immediately display the first walk frame.
if (animTimer == 1)
{
	image_index = 1;
}

#endregion

// Returning to main menu
if (returnToMainMenu)
{
	room_goto(rMainMenu);
	exit;
}

// Accepting a level
if (confirm && place_meeting(x, y, oCampaignLevel))
{
	with (instance_place(x, y, oCampaignLevel))
	{
		global.p1StartingPositionX = levelStartX;
		global.p1StartingPositionY = levelStartY;
	
		global.gameMode = GAMEMODE.PLATFORMING;
	
		global.p1SelectedCharacter = oRussel;
		global.p1PaletteID = 0;
	
		global.campaignStartLevelDelay = startLevelDelay;
		
		// Set up controls
		if (other.mostRecentControllerType == CONTROLLER_TYPES.PAD)
		{
			global.player1ControllerSlot = 0;
		}
		else
		{
			global.player1ControllerSlot = 13;
		}
		
		room_goto(levelDestination);
	}
}