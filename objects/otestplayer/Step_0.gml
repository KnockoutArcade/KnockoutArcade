moveUp = global.p1ButtonMenuUp;
moveDown = global.p1ButtonMenuDown;
moveLeft = global.p1ButtonMenuLeft;
moveRight = global.p1ButtonMenuRight;

var returnToMainMenu = global.p1ButtonMenuDeny;

moveDirection = (moveLeft + moveRight) * moveSpeed;
verticalMoveDirection = (-moveUp - moveDown) * moveSpeed;

xSpeed = moveDirection;
ySpeed =  verticalMoveDirection;

if (sign(verticalMoveDirection) != 0 || sign(xSpeed) != 0)
{
	image_speed = 1;
}
else
{
	image_speed = 0;
	image_index = 0;
}


if (sign(ySpeed) == 1)
{
	sprite_index = sOverworldRussel_Down;
} 
else if (sign(ySpeed) == -1)
{
	sprite_index = sOverworldRussel_Up;
}
else if (sign(xSpeed) != 0)
{
	sprite_index = sOverworldRussel_Side;
	image_xscale = sign(xSpeed);
}

x += xSpeed;
y += ySpeed;

x = clamp(x, 10, room_width-10);
y = clamp(y, 10, room_height-10);

if (returnToMainMenu)
{
	room_goto(rMainMenu);
}