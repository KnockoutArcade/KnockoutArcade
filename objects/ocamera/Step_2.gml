/// @description Insert description here
// You can write your code in this editor

switch (global.gameMode)
{
	case GAMEMODE.VERSUS:
	{
		if (!global.game_paused)
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
				
				// During a victory animation, target the player who's winning
				if (isTargetingWinner)
				{
					xCameraDestination = roundWinTarget.xHome;
				}
				
				// If the camera is not shaking...
				if (!isScreenShaking)
				{
					x = lerp(xCameraDestination, x, cameraSpeed);
	
					camera_set_view_pos(view_camera[0], clamp(x-(cameraWidth*.5), 0, cameraWidth), 0);

	
					// Clamp the camera to the room's bounderies
					x = clamp(x, cameraWidth*.5, cameraWidth*1.5);
				
					xHome = x;
					yHome = y;
				}
				else // Handle screen shake
				{
					ProcessCameraShake();
				}
			}
			else 
			{
				// Use a static camera for the beta arcade stage
				camera_set_view_pos(view_camera[0], clamp(x-(cameraWidth*.5), 0, 0), 0);
				x = cameraWidth*.5;
			}
		}
	}
	break;
	
	case GAMEMODE.PLATFORMING:
	{
		if (!global.game_paused)
		{
			if (!isScreenShaking)
			{
				// If the camera is locked in place, don't update it's movement
				if (!isLocked)
				{
					// Set the camera's target
					if (p1 != noone)
					{
						// Camera's target is the midpoint between both players
						xCameraDestination = (p1.xHome) + (p1.hsp * 2);
					}
			
					// Smoothly move the camera to its destination
					x = lerp(xCameraDestination, x, cameraSpeed);
				}
		
				// Set the camera's position
				camera_set_view_pos(view_camera[0], clamp(x-(cameraWidth*.5), 0, room_width - (cameraWidth)), 0);
	
				// Clamp the camera to the room's bounderies
				x = clamp(x, cameraWidth*.5, room_width - (cameraWidth*.5));
		
				// Set the home values
				xHome = x;
				yHome = y;
			}
			else // Handle Screen Shake
			{
				ProcessCameraShake();
			}
		}
	}
	break;
}
