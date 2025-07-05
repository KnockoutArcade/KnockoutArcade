/// @description Insert description here
// You can write your code in this editor

draw_self();

// Draw the player number
draw_sprite(sPlayerNumbers, playerNumber, x + 4 + (playerNumber * 56), y + 3);

switch (state)
{
	case eSetControlsState.ACTIVE:
	{	
		// Draw the options backdrops
		for (var i = 0; i < maxOnScreenOptions; i++;) // for each on screen option (there's 8)
		{
			#region Draw that option's backdrop
			
			if (controlsOptions[topRowOption + i] < 4) // If the option is a direction...
			{
				draw_sprite(sControlsMenuUI_InputBackgrounds, 0, x + 9, y + 20 + (i * 10));
			}
			else if (controlsOptions[topRowOption + i] < 8) // If the option is an attack
			{
				draw_sprite(sControlsMenuUI_InputBackgrounds, 1, x + 9, y + 20 + (i * 10));
			}
			else if (controlsOptions[topRowOption + i] < 11) // If the option is an action
			{
				draw_sprite(sControlsMenuUI_InputBackgrounds, 2, x + 9, y + 20 + (i * 10));
			}
			
			#endregion
		}
		
		#region Draw our Cursor in-between the names and the backdrops
		draw_sprite(sControlsMenuUI_Selection, playerNumber, x + 6, y + 18 + (selectedRow * 10));
		#endregion
		
		// Draw the option names and inputs
		for (var i = 0; i < maxOnScreenOptions; i++;) // for each on screen option (there's 8)
		{	
			//Draw that options' text
			draw_sprite(sControlsMenuUI_InputNames, controlsOptions[topRowOption + i], x + 9, y + 20 + (i * 10));
			
			
			// Draw that option's input
			if (controlsOptions[topRowOption + i] < 11) // If the option has an input...
			{
				// If player is using a controller...
				if (playerControlsType == CONTROLLER_TYPES.PAD)
				{
					// determine which option to look up the input for
					var lookupOption = 0;
					switch (controlsOptions[topRowOption + i])
					{
						case 0: // up
						{
							lookupOption = playerControls.Controller.buttonUp;
						}
						break;
						case 1: // down
						{
							lookupOption = playerControls.Controller.buttonDown;
						}
							break;
						case 2: // left
						{
							lookupOption = playerControls.Controller.buttonLeft;
						}
						break;
						case 3: // right
						{
							lookupOption = playerControls.Controller.buttonRight;
						}
						break;
						
						case 4: // light
						{
							lookupOption = playerControls.Controller.buttonLight;
						}
						break;
						case 5: // medium
						{
							lookupOption = playerControls.Controller.buttonMedium;
						}
						break;
						case 6: // heavy
						{
							lookupOption = playerControls.Controller.buttonHeavy;
						}
						break;
						case 7: // special
						{
							lookupOption = playerControls.Controller.buttonSpecial;
						}
						break;
						
						case 8: // grab
						{
							lookupOption = playerControls.Controller.buttonGrab;
						}
						break;
						case 9: // run
						{
							lookupOption = playerControls.Controller.buttonRun;
						}
						break;
						case 10: // super
						{
							lookupOption = playerControls.Controller.buttonSuper;
						}
						break;
					}
						
					// draw the input
					draw_sprite(sButtons_Controller, ConvertButtonIntoImageIndex(lookupOption), x + 58, y + 20 + (i * 10));
				}
				else if (playerControlsType == CONTROLLER_TYPES.WASD)// for WASD
				{
					// determine which option to look up the input for
					var lookupOption = 0;
					switch (controlsOptions[topRowOption + i])
					{
						case 0: // up
						{
							lookupOption = playerControls.Keyboard_WASD.buttonUp;
						}
						break;
						case 1: // down
						{
							lookupOption = playerControls.Keyboard_WASD.buttonDown;
						}
						break;
						case 2: // left
						{
							lookupOption = playerControls.Keyboard_WASD.buttonLeft;
						}
						break;
						case 3: // right
						{
							lookupOption = playerControls.Keyboard_WASD.buttonRight;
						}
						break;
						
						case 4: // light
						{
							lookupOption = playerControls.Keyboard_WASD.buttonLight;
						}
						break;
						case 5: // medium
						{
							lookupOption = playerControls.Keyboard_WASD.buttonMedium;
						}
						break;
						case 6: // heavy
						{
							lookupOption = playerControls.Keyboard_WASD.buttonHeavy;
						}
						break;
						case 7: // special
						{
							lookupOption = playerControls.Keyboard_WASD.buttonSpecial;
						}
						break;
						
						case 8: // grab
						{
							lookupOption = playerControls.Keyboard_WASD.buttonGrab;
						}
						break;
						case 9: // run
						{
							lookupOption = playerControls.Keyboard_WASD.buttonRun;
						}
						break;
						case 10: // super
						{
							lookupOption = playerControls.Keyboard_WASD.buttonSuper;
						}
						break;
					}
						
					// draw the input
					draw_sprite(sButtons_Keyboard, ConvertKeyIntoImageIndex(lookupOption), x + 58, y + 20 + (i * 10));
				}
				else // for arrow keys
				{
					// determine which option to look up the input for
					var lookupOption = 0;
					switch (controlsOptions[topRowOption + i])
					{
						case 0: // up
						{
							lookupOption = playerControls.Keyboard_Arrows.buttonUp;
						}
						break;
						case 1: // down
						{
							lookupOption = playerControls.Keyboard_Arrows.buttonDown;
						}
						break;
						case 2: // left
						{
							lookupOption = playerControls.Keyboard_Arrows.buttonLeft;
						}
						break;
						case 3: // right
						{
							lookupOption = playerControls.Keyboard_Arrows.buttonRight;
						}
						break;
						
						case 4: // light
						{
							lookupOption = playerControls.Keyboard_Arrows.buttonLight;
						}
						break;
						case 5: // medium
						{
							lookupOption = playerControls.Keyboard_Arrows.buttonMedium;
						}
						break;
						case 6: // heavy
						{
							lookupOption = playerControls.Keyboard_Arrows.buttonHeavy;
						}
						break;
						case 7: // special
						{
							lookupOption = playerControls.Keyboard_Arrows.buttonSpecial;
						}
						break;
						
						case 8: // grab
						{
							lookupOption = playerControls.Keyboard_Arrows.buttonGrab;
						}
						break;
						case 9: // run
						{
							lookupOption = playerControls.Keyboard_Arrows.buttonRun;
						}
						break;
						case 10: // super
						{
							lookupOption = playerControls.Keyboard_Arrows.buttonSuper;
						}
						break;
					}
						
					// draw the input
					draw_sprite(sButtons_Keyboard, ConvertKeyIntoImageIndex(lookupOption), x + 58, y + 20 + (i * 10));
				}
			}
		}
	
		// Draw please press new button
		if (isCurrentlySettingButton)
		{
			draw_sprite(sControlsMenuUI_PressNewButton, 0, x, y);
		}
	}
	break;
	
	case eSetControlsState.WAIT_FOR_INPUT:
	{
		if (waitForInputButtonType == 2)
		{
			draw_sprite(sButtons_Keyboard, 16, x + 34, y + 64);
		}
		else if (waitForInputButtonType == 1)
		{
			draw_sprite(sButtons_Keyboard, 64, x + 34, y + 64);
		}
		else
		{
			draw_sprite(sButtons_Controller, 0, x + 34, y + 64);
		}
	}
	break;
}
