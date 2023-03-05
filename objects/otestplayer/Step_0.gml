moveUp = global.p1ButtonUp
moveDown = global.p1ButtonDown
moveLeft = global.p1ButtonLeft
moveRight = global.p1ButtonRight

moveDir = (moveLeft + moveRight) * moveSpd;
verticalMoveDir = (-moveUp - moveDown) * moveSpd;

xspd = moveDir;
yspd =  verticalMoveDir;

x += xspd;
y += yspd;

