/// @description Insert description here
// You can write your code in this editor

// Set the camera's target
if (p1 != noone && p2 != noone)
{
	xTo = (p1.xHome + p2.xHome) * .5;
}

// Move the camera
if (room != rStageArcade)
{
	x = lerp(xTo, x, cameraSpeed);
	
	camera_set_view_pos(view_camera[0], clamp(x-(camWidth*.5), 0, camWidth), 0);

	
	// Clamp the camera to the room's bounderies
	x = clamp(x, camWidth*.5, camWidth*1.5);
}
else 
{
	camera_set_view_pos(view_camera[0], clamp(x-(camWidth*.5), 0, 0), 0);
	x = camWidth*.5;
}