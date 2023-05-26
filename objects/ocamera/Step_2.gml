/// @description Insert description here
// You can write your code in this editor

switch (global.gameMode)
{
	case GAMEMODE.VERSUS:
	{
		// Move the camera
		if (room != rStageArcade)
		{
			// Set the camera's target
			if (p1 != noone && p2 != noone)
			{
				// Camera's target is the midpoint between both players
				xCameraDestination = (p1.xHome + p2.xHome) * .5;
			}
			
			// Handle cam during command grabs
			if (p1.state == eState.COMMAND_GRAB && p2.state == eState.BEING_GRABBED)
			{
				// Camera's target is the attacking player
				xCameraDestination = p1.xHome;
			}
			else if (p2.state == eState.COMMAND_GRAB && p1.state == eState.BEING_GRABBED)
			{
				// Camera's target is the attacking player
				xCameraDestination = p2.xHome;
			}
			
	
			x = lerp(xCameraDestination, x, cameraSpeed);
	
			camera_set_view_pos(view_camera[0], clamp(x-(cameraWidth*.5), 0, cameraWidth), 0);

	
			// Clamp the camera to the room's bounderies
			x = clamp(x, cameraWidth*.5, cameraWidth*1.5);
		}
		else 
		{
			camera_set_view_pos(view_camera[0], clamp(x-(cameraWidth*.5), 0, 0), 0);
			x = cameraWidth*.5;
		}
	}
	break;
	
	case GAMEMODE.PLATFORMING:
	{
		// Set the camera's target
		if (p1 != noone)
		{
			// Camera's target is the midpoint between both players
			xCameraDestination = (p1.xHome) + (p1.hsp * 2);
		}
		
		x = lerp(xCameraDestination, x, cameraSpeed);
	
		camera_set_view_pos(view_camera[0], clamp(x-(cameraWidth*.5), 0, room_width - (cameraWidth)), 0);

	
		// Clamp the camera to the room's bounderies
		x = clamp(x, cameraWidth*.5, room_width - (cameraWidth*.5));
	}
	break;
}
