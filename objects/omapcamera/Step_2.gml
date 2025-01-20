/// @description Insert description here
// You can write your code in this editor

if (followTarget != noone)
{ 
	xPosition = followTarget.x;
	yPosition = followTarget.y;
}

x = xPosition;
y = yPosition;

x = clamp(x, 85, room_width-85);
y = clamp(y, 65, room_height-65);



camera_set_view_pos(view_camera[0], x-(cameraWidth*0.5),y-(cameraHeight*0.5));


