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

horizontalMovement = moveRight + moveLeft;
verticalMovement = moveUp + moveDown;

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

if (place_meeting(x, y - ySpeed, oWall))
{
	y = round(y);
	
	while !(place_meeting(x, y - sign(ySpeed), oWall))
	{
		y -= sign(ySpeed);
	}
	ySpeed = 0;
}
y += -ySpeed;

#endregion