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
					cameraSpeed = 0.75;
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
						// Camera behavior in Singleplayer is a lot different from VS mode.
						// The camera will attempt to keep the player on the left side of
						// the screen so that they can see more of the upcoming level.
						
						// If the player starts moving to the left, the camera will slowly
						// pan over to the left until the player is in the middle of the screen.
						// If they start moving to the right again, the camera pans until the
						// the player is off to the left side of the screen.
						
						// The camera's panning speed is tied to the player's movement speed.
						// If the player starts sprinting, the camera will pan much quicker.
						
						if (p1.movedir > 0) // Player is moving to the right
						{
							cameraPanDelayTimer -= 2;
							
							if (cameraPanDelayTimer <= 0)
							{
								cameraPanDelayTimer = 0;
								cameraSpeed = 0.85;
								
								if (p1.runningForward)
								{
									cameraSpeed = 0.7;
								}
								
								cameraPanDirection = 1;
							}
						}
						else if (p1.movedir < 0) // Player is moving to the left
						{
							cameraPanDelayTimer -= 1;
							
							if (cameraPanDelayTimer <= 0)
							{
								cameraPanDelayTimer = 0;
								cameraSpeed = 0.95;
								
								if (p1.runningForward)
								{
									cameraSpeed = 0.7;
								}
								
								cameraPanDirection = -1;
							}
						}
						else // Player is not moving
						{
							cameraPanDelayTimer = cameraPanDelay;
						}
						
						
						if (cameraPanDirection == 1)
						{
							// Camera's target is set to be in front of the player
							xCameraDestination = (p1.xHome) + cameraRightSidePanAmount;
						}
						else if (cameraPanDirection == -1)
						{
							// Camera's target is set to be almost on top of the player
							xCameraDestination = (p1.xHome) + cameraLeftSidePanAmount + (p1.hsp * 2);
						}
						
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
