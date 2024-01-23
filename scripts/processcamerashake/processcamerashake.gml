// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ProcessCameraShake()
{
	// Decrease the screen shake timer
	screenShakeDuration--;
				
	// Choose a random number between -screenShakeLevel and screenShakeLevel
	// for both x and y. This will be what we offset the camera's
	// position by to achieve a shaking effect.
	
	var effectiveShake = screenShakeLevel - 1;
	effectiveShake = max(screenShakeLevel, 0);
	
	var randomCamOffsetX = random_range((-effectiveShake / 2), (effectiveShake / 2));
	var randomCamOffsetY = random_range((-effectiveShake / 2), (effectiveShake / 2));
	
	// Apply offset
	if (screenShakeDuration mod 3 == 1)
	{
		x = xHome + randomCamOffsetX;
		y = yHome + randomCamOffsetY;
	}
	
	// Once the duration has expired...
	if (screenShakeDuration <= 0)
	{
		// reset isScreenShaking
		isScreenShaking = false;
	
		// return the camera to its normal position
		x = xHome;
		y = yHome;
	}
	
	// Set the camera's view
	camera_set_view_pos(view_camera[0], x-(cameraWidth*.5), y);
}