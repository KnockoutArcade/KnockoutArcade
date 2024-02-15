/// @description Insert description here
// You can write your code in this editor

#region Inputs
// Determine which player's inputs to use
if (playerNumber == 0)
{
	var menuUp = global.p1ButtonMenuUp;
	var menuDown = global.p1ButtonMenuDown;
	var menuRowMove = menuUp + menuDown;
	
	var menuLeft = global.p1ButtonMenuLeft;
	var menuRight = global.p1ButtonMenuRight;
	var menuCollumnMove = menuLeft + menuRight;
	
	var menuConfirm = global.p1ButtonMenuConfirm;
	var menuConfirmBuffer = false;
	
	var menuDeny = global.p1ButtonMenuDeny;
	var menuDenyBuffer = false;
}
else
{
	var menuUp = global.p2ButtonMenuUp;
	var menuDown = global.p2ButtonMenuDown;
	var menuRowMove = menuUp + menuDown;
	
	var menuLeft = global.p2ButtonMenuLeft;
	var menuRight = global.p2ButtonMenuRight;
	var menuCollumnMove = menuLeft + menuRight;
	
	var menuConfirm = global.p2ButtonMenuConfirm;
	var menuConfirmBuffer = false;
	
	var menuDeny = global.p2ButtonMenuDeny;
	var menuDenyBuffer = false;
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
			sprite_index = sControlsMenu_TurnFace;
			image_index = 0;
			
			state = eSetControlsState.TURN_TO_FACE;
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
					
					SaveControls();
					
					playerControls = global.player1Controls;
				}
				else
				{
					RestorePlayer2DefaultControls();
					
					SaveControls();
					
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
	
			if (playerNumber == 0)
			{
				if (playerControlsType == "KEYBOARD")
				{
					newKeyPressed = keyboard_check_pressed(vk_anykey);
					newKey = keyboard_lastkey;
				}
				else
				{
					newKeyPressed = GamepadCheck(global.player1ControllerSlot);
					newKey = global.lastControllerButton;
				}
			}
			else
			{
				if (playerControlsType == "KEYBOARD")
				{
					newKeyPressed = keyboard_check_pressed(vk_anykey);
					newKey = keyboard_lastkey;
				}
				else
				{
					newKeyPressed = GamepadCheck(global.player2ControllerSlot);
					newKey = global.lastControllerButton;
				}
			}
	
			// If we have pressed a new button...
			if (newKeyPressed && !menuConfirmBuffer)
			{
				isCurrentlySettingButton = false;
				
				// Set the player's new button
				switch (selectedOption)
				{
					case 0: // up
						if (playerControlsType == "KEYBOARD")
						{
							playerControls.Keyboard.buttonUp = newKey;
						}
						else
						{
							playerControls.Controller.buttonUp = newKey;
						}
					break;
			
					case 1: // down
						if (playerControlsType == "KEYBOARD")
						{
							playerControls.Keyboard.buttonDown = newKey;
						}
						else
						{
							playerControls.Controller.buttonDown = newKey;
						}
					break;
			
					case 2: // left
						if (playerControlsType == "KEYBOARD")
						{
							playerControls.Keyboard.buttonLeft = newKey;
						}
						else
						{
							playerControls.Controller.buttonLeft = newKey;
						}
					break;
			
					case 3: // right
						if (playerControlsType == "KEYBOARD")
						{
							playerControls.Keyboard.buttonRight = newKey;
						}
						else
						{
							playerControls.Controller.buttonRight = newKey;
						}
					break;
			
					case 4: // light
						if (playerControlsType == "KEYBOARD")
						{
							playerControls.Keyboard.buttonLight = newKey;
						}
						else
						{
							playerControls.Controller.buttonLight = newKey;
						}
					break;
			
					case 5: // medium
						if (playerControlsType == "KEYBOARD")
						{
							playerControls.Keyboard.buttonMedium = newKey;
						}
						else
						{
							playerControls.Controller.buttonMedium = newKey;
						}
					break;
			
					case 6: // heavy
						if (playerControlsType == "KEYBOARD")
						{
							playerControls.Keyboard.buttonHeavy = newKey;
						}
						else
						{
							playerControls.Controller.buttonHeavy = newKey;
						}
					break;
			
					case 7: //special
						if (playerControlsType == "KEYBOARD")
						{
							playerControls.Keyboard.buttonSpecial = newKey;
						}
						else
						{
							playerControls.Controller.buttonSpecial = newKey;
						}
					break;
			
					
					case 8: //grab
						if (playerControlsType == "KEYBOARD")
						{
							playerControls.Keyboard.buttonGrab = newKey;
						}
						else
						{
							playerControls.Controller.buttonGrab = newKey;
						}
					break;
			
					case 9: //Run
						if (playerControlsType == "KEYBOARD")
						{
							playerControls.Keyboard.buttonRun = newKey;
						}
						else
						{
							playerControls.Controller.buttonRun = newKey;
						}
					break;
					
					case 10: //Super
						if (playerControlsType == "KEYBOARD")
						{
							playerControls.Keyboard.buttonSuper = newKey;
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
				SaveControls();
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


