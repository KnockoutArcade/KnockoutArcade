moveUp = global.p1ButtonUp
moveDown = global.p1ButtonDown
moveLeft = global.p1ButtonLeft
moveRight = global.p1ButtonRight

moveDirection = (moveLeft + moveRight) * moveSpeed;
verticalMoveDirection = (-moveUp - moveDown) * moveSpeed;

xSpeed = moveDirection;
ySpeed =  verticalMoveDirection;

x += xSpeed;
y += ySpeed;

x = clamp(x, 10, room_width-10);
y = clamp(y, 10, room_height-10);