/// @description Insert description here
// You can write your code in this editor

draw_self();

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
		
		// Draw our Cursor in-between the names and the backdrops
		draw_sprite(sControlsMenuUI_Selection, playerNumber, x + 6, y + 18 + (selectedRow * 10));
		
		// Draw the option names and inputs
		for (var i = 0; i < maxOnScreenOptions; i++;) // for each on screen option (there's 8)
		{	
			//Draw that options' text
			draw_sprite(sControlsMenuUI_InputNames, controlsOptions[topRowOption + i], x + 9, y + 20 + (i * 10));
			
			// Draw that option's input
			if (controlsOptions[topRowOption + i] < 11) // If the option has an input...
			{
				// Player 1
				if (playerNumber == 0)
				{
					// If P1 is using a controller...
					if (global.player1ControllerType == "PAD")
					{
						// determine which option to look up the input for
						var lookupOption = 0;
						switch (controlsOptions[topRowOption + i])
						{
							case 0: // up
							{
								lookupOption = global.player1Controls.Controller.buttonUp;
							}
							break;
							case 1: // down
							{
								lookupOption = global.player1Controls.Controller.buttonDown;
							}
							break;
							case 2: // left
							{
								lookupOption = global.player1Controls.Controller.buttonLeft;
							}
							break;
							case 3: // right
							{
								lookupOption = global.player1Controls.Controller.buttonRight;
							}
							break;
							
							case 4: // light
							{
								lookupOption = global.player1Controls.Controller.buttonLight;
							}
							break;
							case 5: // medium
							{
								lookupOption = global.player1Controls.Controller.buttonMedium;
							}
							break;
							case 6: // heavy
							{
								lookupOption = global.player1Controls.Controller.buttonHeavy;
							}
							break;
							case 7: // special
							{
								lookupOption = global.player1Controls.Controller.buttonSpecial;
							}
							break;
							
							case 8: // grab
							{
								lookupOption = global.player1Controls.Controller.buttonGrab;
							}
							break;
							case 9: // run
							{
								lookupOption = global.player1Controls.Controller.buttonRun;
							}
							break;
							case 10: // super
							{
								lookupOption = global.player1Controls.Controller.buttonSuper;
							}
							break;
						}
						
						// draw the input
						draw_sprite(sButtons_Controller, ConvertButtonIntoImageIndex(lookupOption), x + 58, y + 20 + (i * 10));
					}
				}
				
				
			}
		}
	}
	break;
}
