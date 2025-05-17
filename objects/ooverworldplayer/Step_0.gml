/// @description Insert description here
// You can write your code in this editor

// Inputs
var moveUp = global.p1ButtonMenuUp;
var moveDown = global.p1ButtonMenuDown;
var moveLeft = global.p1ButtonMenuLeft;
var moveRight = global.p1ButtonMenuRight;

var returnToMainMenu = global.p1ButtonMenuDeny;

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
}