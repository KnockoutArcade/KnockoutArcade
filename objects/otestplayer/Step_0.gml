moveUp = global.p1ButtonMenuUp;
moveDown = global.p1ButtonMenuDown;
moveLeft = global.p1ButtonMenuLeft;
moveRight = global.p1ButtonMenuRight;

var returnToMainMenu = global.p1ButtonMenuDeny;

moveDirection = (moveLeft + moveRight) * moveSpeed;
verticalMoveDirection = (-moveUp - moveDown) * moveSpeed;

xSpeed = moveDirection;
ySpeed =  verticalMoveDirection;

x += xSpeed;
y += ySpeed;

x = clamp(x, 10, room_width-10);
y = clamp(y, 10, room_height-10);

if (returnToMainMenu)
{
	room_goto(rMainMenu);
}