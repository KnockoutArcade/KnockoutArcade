/// @description Insert description here
// You can write your code in this editor

#region Inputs
// Initialize
var menuUp = 0;
var menuDown = 0;
var menuRowMove = menuUp + menuDown;
	
var menuLeft = 0;
var menuRight = 0;
var menuCollumnMove = menuLeft + menuRight;
	
var menuConfirm = false;
var menuConfirmBuffer = false;
	
var menuDeny = false;
var menuDenyBuffer = false;

// Detect the controller
var controllerObject = FindController(controllerSlot);

if (controllerObject != -1)
{
	menuUp = controllerObject.buttonMenuUp;
	menuDown = controllerObject.buttonMenuDown;
	menuRowMove = menuUp + menuDown;
	
	menuLeft = controllerObject.buttonMenuLeft;
	menuRight = controllerObject.buttonMenuRight;
	menuCollumnMove = menuLeft + menuRight;
	
	menuConfirm = controllerObject.buttonMenuConfirm;
	menuConfirmBuffer = false;
	
	menuDeny = controllerObject.buttonMenuDeny;
	menuDenyBuffer = false;
}

#endregion

// Decrease the cursor cooldown
cursorCooldown--;

// If the cursor isn't moving, reset the cooldown
if (menuRowMove == 0 && menuCollumnMove == 0)
{
	cursorCooldown = 0;
}


// These states control the animation of the menu, as well as what it can do during those animations
switch (state)
{
	case eSetControlsState.OPENING:
	{
		// If we are using the opening animation and we have reached the end, switch to the turn to face animation
		if (image_index >= image_number - 1)
		{
			if (isWaitingForInput || controllerSlot == -1)
			{
				sprite_index = sControlsMenu_PressStart;
				image_index = 0;
				
				state = eSetControlsState.WAIT_FOR_INPUT;
			}
			else
			{
				sprite_index = sControlsMenu_TurnFace;
				image_index = 0;
				
				state = eSetControlsState.TURN_TO_FACE;
			}
		}
	}
	break;
	
	case eSetControlsState.WAIT_FOR_INPUT:
	{
		// Handle Activating
		if (menuConfirm && !menuConfirmBuffer)
		{
			sprite_index = sControlsMenu_TurnFace;
			image_index = 0;
			
			state = eSetControlsState.TURN_TO_FACE;
			
			audio_play_sound(sfx_UI_Select, 0, false);
		}
		
		
		// Handle leaving
		if (menuDeny && !menuDenyBuffer) || (instance_number(oSetControlsMenu) <= 1)
		{
			menuDenyBuffer = true;
			
			// Switch to the turn away state
			sprite_index = sControlsMenu_Opening;
			image_index = 6;
			image_speed = -1;
			
			state = eSetControlsState.LEAVE;
			
			// Play Sound
			audio_play_sound(sfx_UI_Exit, 0, false);
		}
	}
	break;
	
	case eSetControlsState.TURN_TO_FACE:
	{
		// If we have reached the end of this animation, switch to the active animation
		if (image_index >= image_number - 1)
		{
			sprite_index = sControlsMenu_Base;
			image_index = 0;
			
			state = eSetControlsState.ACTIVE;
		}
	}
	break;
	
	case eSetControlsState.ACTIVE:
	{
		// If we press up or down
		if (menuRowMove != 0 && cursorCooldown <= 0 && !isCurrentlySettingButton)
		{
			// Update our selected option
			selectedOption -= menuRowMove;
			
			// Wrap our selected option to the maximum number of selections
			if (selectedOption >= maxSelections)
			{
				selectedOption = 0;
			}
			else if (selectedOption < 0)
			{
				selectedOption = maxSelections - 1;
			}
			
			// If we've scrolled past the bottom of the selections...
			if (selectedOption > topRowOption + (maxOnScreenOptions - 1))
			{
				while (selectedOption > topRowOption + (maxOnScreenOptions - 1))
				{
					topRowOption += 1;
				}
			}
			else if (selectedOption < topRowOption) // otherwise if we've scrolled past the top...
			{
				while (selectedOption < topRowOption)
				{
					topRowOption -= 1;
				}
			}
			
			selectedRow = selectedOption - topRowOption;
			
			// Play Sound
			audio_play_sound(sfx_UI_Hover, 0, false);
			
			// set cooldown
			cursorCooldown = cursorCooldownAmount;
		}
		
		// If we have pressed A to change our current button map...
		if (menuConfirm && !menuConfirmBuffer && !isCurrentlySettingButton)
		{
			menuConfirmBuffer = true;
			
			// Play Sound
			audio_play_sound(sfx_UI_Select, 0, false);
			
			if (selectedOption == 11) // Restore defaults
			{
				if (playerNumber == 0)
				{
					RestorePlayer1DefaultControls();
					
					SaveControls(1);
					
					playerControls = global.player1Controls;
				}
				else
				{
					RestorePlayer2DefaultControls();
					
					SaveControls(2);
					
					playerControls = global.player2Controls;
				}
			}
			else if (selectedOption == 12) // Confirm controls
			{
				// Switch to the turn away state
				sprite_index = sControlsMenu_TurnAway
				image_index = 0;
			
				state = eSetControlsState.TURN_AWAY;
			}
			else
			{
				isCurrentlySettingButton = true;
			}
		}
		
		// If we press BACK
		if (menuDeny && !menuDenyBuffer && !isCurrentlySettingButton)
		{
			menuDenyBuffer = true;
			
			// Switch to the turn away state
			sprite_index = sControlsMenu_TurnAway
			image_index = 0;
			
			state = eSetControlsState.TURN_AWAY;
			
			// Play Sound
			audio_play_sound(sfx_UI_Exit, 0, false);
		}
		
		// If we are setting controls
		if (isCurrentlySettingButton)
		{
			// Detect if we are pressing a new key
			var newKeyPressed = false;
			var newKey = 0;
	
			if (playerControlsType == CONTROLLER_TYPES.WASD || playerControlsType == CONTROLLER_TYPES.ARROWS)
			{
				newKeyPressed = keyboard_check_pressed(vk_anykey);
				newKey = keyboard_lastkey;
			}
			else
			{
				newKeyPressed = GamepadCheck(controllerSlot);
				newKey = global.lastControllerButton;
			}
	
			// If we have pressed a new button...
			if (newKeyPressed && !menuConfirmBuffer)
			{
				isCurrentlySettingButton = false;
				
				// Set the player's new button
				switch (selectedOption)
				{
					case 0: // up
						if (playerControlsType == CONTROLLER_TYPES.WASD)
						{
							playerControls.Keyboard_WASD.buttonUp = newKey;
						}
						else if (playerControlsType == CONTROLLER_TYPES.ARROWS)
						{
							playerControls.Keyboard_Arrows.buttonUp = newKey;
						}
						else
						{
							playerControls.Controller.buttonUp = newKey;
						}
					break;
			
					case 1: // down
						if (playerControlsType == CONTROLLER_TYPES.WASD)
						{
							playerControls.Keyboard_WASD.buttonDown = newKey;
						}
						else if (playerControlsType == CONTROLLER_TYPES.ARROWS)
						{
							playerControls.Keyboard_Arrows.buttonDown = newKey;
						}
						else
						{
							playerControls.Controller.buttonDown = newKey;
						}
					break;
			
					case 2: // left
						if (playerControlsType == CONTROLLER_TYPES.WASD)
						{
							playerControls.Keyboard_WASD.buttonLeft = newKey;
						}
						else if (playerControlsType == CONTROLLER_TYPES.ARROWS)
						{
							playerControls.Keyboard_Arrows.buttonLeft = newKey;
						}
						else
						{
							playerControls.Controller.buttonLeft = newKey;
						}
					break;
			
					case 3: // right
						if (playerControlsType == CONTROLLER_TYPES.WASD)
						{
							playerControls.Keyboard_WASD.buttonRight = newKey;
						}
						else if (playerControlsType == CONTROLLER_TYPES.ARROWS)
						{
							playerControls.Keyboard_Arrows.buttonRight = newKey;
						}
						else
						{
							playerControls.Controller.buttonRight = newKey;
						}
					break;
			
					case 4: // light
						if (playerControlsType == CONTROLLER_TYPES.WASD)
						{
							playerControls.Keyboard_WASD.buttonLight = newKey;
						}
						else if (playerControlsType == CONTROLLER_TYPES.ARROWS)
						{
							playerControls.Keyboard_Arrows.buttonLight = newKey;
						}
						else
						{
							playerControls.Controller.buttonLight = newKey;
						}
					break;
			
					case 5: // medium
						if (playerControlsType == CONTROLLER_TYPES.WASD)
						{
							playerControls.Keyboard_WASD.buttonMedium = newKey;
						}
						else if (playerControlsType == CONTROLLER_TYPES.ARROWS)
						{
							playerControls.Keyboard_Arrows.buttonMedium = newKey;
						}
						else
						{
							playerControls.Controller.buttonMedium = newKey;
						}
					break;
			
					case 6: // heavy
						if (playerControlsType == CONTROLLER_TYPES.WASD)
						{
							playerControls.Keyboard_WASD.buttonHeavy = newKey;
						}
						else if (playerControlsType == CONTROLLER_TYPES.ARROWS)
						{
							playerControls.Keyboard_Arrows.buttonHeavy = newKey;
						}
						else
						{
							playerControls.Controller.buttonHeavy = newKey;
						}
					break;
			
					case 7: //special
						if (playerControlsType == CONTROLLER_TYPES.WASD)
						{
							playerControls.Keyboard_WASD.buttonSpecial = newKey;
						}
						else if (playerControlsType == CONTROLLER_TYPES.ARROWS)
						{
							playerControls.Keyboard_Arrows.buttonSpecial = newKey;
						}
						else
						{
							playerControls.Controller.buttonSpecial = newKey;
						}
					break;
			
					
					case 8: //grab
						if (playerControlsType == CONTROLLER_TYPES.WASD)
						{
							playerControls.Keyboard_WASD.buttonGrab = newKey;
						}
						else if (playerControlsType == CONTROLLER_TYPES.ARROWS)
						{
							playerControls.Keyboard_Arrows.buttonGrab = newKey;
						}
						else
						{
							playerControls.Controller.buttonGrab = newKey;
						}
					break;
			
					case 9: //Run
						if (playerControlsType == CONTROLLER_TYPES.WASD)
						{
							playerControls.Keyboard_WASD.buttonRun = newKey;
						}
						else if (playerControlsType == CONTROLLER_TYPES.ARROWS)
						{
							playerControls.Keyboard_Arrows.buttonRun = newKey;
						}
						else
						{
							playerControls.Controller.buttonRun = newKey;
						}
					break;
					
					case 10: //Super
						if (playerControlsType == CONTROLLER_TYPES.WASD)
						{
							playerControls.Keyboard_WASD.buttonSuper = newKey;
						}
						else if (playerControlsType == CONTROLLER_TYPES.ARROWS)
						{
							playerControls.Keyboard_Arrows.buttonSuper = newKey;
						}
						else
						{
							playerControls.Controller.buttonSuper = newKey;
						}
					break;
				}
				
				// Play Sound
				audio_play_sound(sfx_UI_Select, 0, false);
				
				// Save the player's controls
				if (playerNumber == 0)
				{
					SaveControls(1);
				}
				else
				{
					SaveControls(2);
				}
				
			}
		}
	}
	break;
	
	case eSetControlsState.TURN_AWAY:
	{
		// If we have reached the end of this animation, switch to the leave animation
		if (image_index >= image_number - 1)
		{
			sprite_index = sControlsMenu_Opening;
			image_index = 6;
			image_speed = -1;
			
			state = eSetControlsState.LEAVE;
		}
	}
	break;
	
	case eSetControlsState.LEAVE:
	{
		// If we have reached the end of this animation, destroy
		if (image_index <= 1)
		{
			instance_destroy();
		}
	}
	break;
}


