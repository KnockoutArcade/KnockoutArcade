if (followTarget != noone)
{ 
	xPosition = followTarget.x;
	yPosition = followTarget.y;
}

x = clamp(x, 85, room_width-85);
y = clamp(y, 65, room_height-65);

x += (xPosition - x)/25;
y += (yPosition - y)/25;

camera_set_view_pos(view_camera[0], x-(cameraWidth*0.5),y-(cameraHeight*0.5));
