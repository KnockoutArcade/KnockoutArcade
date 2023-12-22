/// Pan the global camera to a determined location
function Cutscene_PanCameraLinear(destinationX, destinationY, time)
{
	cameraTimer += 1;
	global.camObj.isLocked = true;
	
	// On the first loop of this script, determine how far the camera must travel each frame
	if (cameraTimer == 1)
	{
		cameraTravelDistanceX = (destinationX - global.camObj.x) / time;
		cameraTravelDistanceY = (destinationY - global.camObj.y) / time;
	}
	
	// Move the camera
	global.camObj.x += cameraTravelDistanceX;
	global.camObj.y += cameraTravelDistanceY;
	
	// Once the camera has reached its destination, return to normal
	if (cameraTimer == time)
	{
		// Reset vars
		cameraTimer = 0;
		cameraTravelDistanceX = 0;
		cameraTravelDistanceY = 0;
		
		Cutscene_ENDSCENE();
	}
}