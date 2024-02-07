/// @description Insert description here
// You can write your code in this editor


#region Handle Inputs

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

// Decrease the cursor cooldown
cursorCooldown--;

// If the cursor isn't moving, reset the cooldown
if (menuRowMove == 0 && menuCollumnMove == 0)
{
	cursorCooldown = 0;
}

#endregion

switch (state)
{
	case (ePauseMenuState.MAIN) :
	{
		// If we are using the opening animation and we have reached the end, switch to the pause menu backdrop
		if ((sprite_index == sPauseMenu_Open_P1 || sprite_index == sPauseMenu_Open_P2) && image_index >= image_number - 1)
		{
			sprite_index = sPauseMenu_MainBackdrop;
			image_index = playerNumber;
		}
		
		// Handle Cursor
		if (menuRowMove != 0 && cursorCooldown <= 0)
		{
			currentRow -= menuRowMove;
			
			if (currentRow < 0)
			{
				currentRow = mainRowMax - 1;
			}
			
			if (currentRow >= mainRowMax)
			{
				currentRow = 0;
			}
			
			cursorCooldown = cursorCooldownAmount;
		}
		
		// Handle Selecting Options
		if (menuConfirm && !menuConfirmBuffer) // If we pressed confirm
		{
			menuConfirmBuffer = true;
			
			switch (currentRow)
			{
				// Resume
				case 0:
				{
					owner.pauseMenuObject = noone;
					global.game_paused = false;
					
					instance_destroy();
				}
				break;
				
				// Command lists
				case 1:
				{
					state = ePauseMenuState.COMMAND_LISTS; // Set state
					commandListCurrentTab = 0; // Make sure to start on the first tab (Command Inputs)
					commandListCurrentPage = 0; // Reset current page
					cursorCooldown = 0;
					
					// Determine which character to display
					if (playerNumber == 0) // Player 1
					{
						switch (global.p1SelectedCharacter)
						{
							// Russel
							default:
							{
								commandListCharacter = 0;
							}
							break;
							
							// Beverly
							case oBeverly:
							{
								commandListCharacter = 1;
							}
							break;
						}
					}
					else // Player 2
					{
						switch (global.p2SelectedCharacter)
						{
							// Russel
							default:
							{
								commandListCharacter = 0;
							}
							break;
							
							// Beverly
							case oBeverly:
							{
								commandListCharacter = 1;
							}
							break;
						}
					}
				}
				break;
				
				// Options
				case 2:
				{
					state = ePauseMenuState.OPTIONS; // Set state
					previousRow = currentRow; // Save our current row so we can return to it later
					currentRow = 0; // reset current row (default on No)
					cursorCooldown = 0; // refresh cooldown
				}
				break;
				
				// Restart
				case 3:
				{
					state = ePauseMenuState.ARE_YOU_SURE; // Set state
					areYouSureAction = eAreYouSureAction.RESTART; // We want to restart the room after selecting Yes
					previousRow = currentRow; // Save our current row so we can return to it later
					currentRow = 1; // reset current row (default on No)
					cursorCooldown = 0; // refresh cooldown
				}
				break;
				
				// Character Select
				case 4:
				{
					state = ePauseMenuState.ARE_YOU_SURE; // Set state
					areYouSureAction = eAreYouSureAction.CHARACTER_SELECT; // We want to go to Char Sel after selecting Yes
					previousRow = currentRow; // Save our current row so we can return to it later
					currentRow = 1; // reset current row (default on No)
					cursorCooldown = 0; // refresh cooldown
				}
				break;
				
				// Main Menu
				case 5:
				{
					state = ePauseMenuState.ARE_YOU_SURE; // Set state
					areYouSureAction = eAreYouSureAction.MAIN_MENU; // We want to go to Main Menu after selecting Yes
					previousRow = currentRow; // Save our current row so we can return to it later
					currentRow = 1; // reset current row (default on No)
					cursorCooldown = 0; // refresh cooldown
				}
				break;
			}
		}
		
		// Handle Pressing Back
		if (menuDeny && !menuDenyBuffer)
		{
			// Pressing back is the same as resuming the game
			owner.pauseMenuObject = noone;
			global.game_paused = false;
					
			instance_destroy();
		}
	}
	break;
	
	case ePauseMenuState.COMMAND_LISTS:
	{
		// Handle Cursor
		if (menuCollumnMove != 0 && cursorCooldown <= 0) // Left and Right
		{
			commandListCurrentTab += menuCollumnMove;
			
			if (commandListCurrentTab < 0)
			{
				commandListCurrentTab = commandListMaxTabs - 1;
			}
			
			if (commandListCurrentTab >= commandListMaxTabs)
			{
				commandListCurrentTab = 0;
			}
			
			// Reset what page we are on
			commandListCurrentPage = 0;
			
			cursorCooldown = cursorCooldownAmount;
		}
		
		if (menuRowMove != 0 && cursorCooldown <= 0) // Up and Down
		{
			commandListCurrentPage -= menuRowMove;
			
			// If we try to scroll up after 0, reset to 0
			if (commandListCurrentPage < 0)
			{
				commandListCurrentPage = 0;
			}
			
			cursorCooldown = cursorCooldownAmount;
		}
		
		// Handle selections
		if (menuDeny && !menuDenyBuffer) // If we pressed Deny to go back
		{
			menuDenyBuffer = true;
			
			state = ePauseMenuState.MAIN; // Set state
			currentRow = 1; // Restore current row (Command List)
			cursorCooldown = 0; // refresh cooldown
		}
	}
	break;
	
	case ePauseMenuState.OPTIONS:
	{
		// Handle Cursor
		if (menuRowMove != 0 && cursorCooldown <= 0) // Up and Down
		{
			currentRow -= menuRowMove;
			
			if (currentRow < 0)
			{
				currentRow = optionsRowMax - 1;
			}
			
			if (currentRow >= optionsRowMax)
			{
				currentRow = 0;
			}
			
			cursorCooldown = cursorCooldownAmount;
		}
		
		// Handle Pressing Back
		if (menuDeny && !menuDenyBuffer)
		{
			menuDenyBuffer = true;
			
			state = ePauseMenuState.MAIN; // Set state
			currentRow = previousRow; // Restore current row
			cursorCooldown = 0; // refresh cooldown
		}
	}
	break;
	
	case ePauseMenuState.ARE_YOU_SURE:
	{
		// Handle Cursor
		if (menuRowMove != 0 && cursorCooldown <= 0)
		{
			currentRow -= menuRowMove;
			
			if (currentRow < 0)
			{
				currentRow = areYouSureRowMax - 1;
			}
			
			if (currentRow >= areYouSureRowMax)
			{
				currentRow = 0;
			}
			
			cursorCooldown = cursorCooldownAmount;
		}
		
		// Handle selections
		if (menuConfirm && !menuConfirmBuffer) // If we pressed confirm
		{
			menuConfirmBuffer = true;
			
			switch (currentRow)
			{
				// Yes
				case 0:
				{
					if (areYouSureAction == eAreYouSureAction.CHARACTER_SELECT)
					{
						room_goto(rCharacterSelectScreen);
					}
					else if (areYouSureAction == eAreYouSureAction.MAIN_MENU)
					{
						room_goto(rMainMenu);
					}
					else if (areYouSureAction == eAreYouSureAction.RESTART)
					{
						room_restart();
					}
					
				}
				break;
				
				// No
				case 1:
				{
					state = ePauseMenuState.MAIN; // Set state
					currentRow = previousRow; // Restore current row
					cursorCooldown = 0; // refresh cooldown
				}
				break;
			}
		}
	}
	break;
}


