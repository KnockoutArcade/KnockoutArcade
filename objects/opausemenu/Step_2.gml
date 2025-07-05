/// @description Insert description here
// You can write your code in this editor


#region Handle Inputs
var menuUp = 0;
var menuDown = 0;
var menuRowMove = menuUp + menuDown;
	
var menuLeft = 0;
var menuRight = 0;
var menuCollumnMove = menuLeft + menuRight;
	
var menuConfirm = 0;
var menuConfirmBuffer = false;
	
var menuDeny = 0;
var menuDenyBuffer = false;

// Listen for the controller
var controllerObject = FindController(controllerSlot)
if (controllerObject != -1 && !useAllControllers)
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
else if (useAllControllers) // Listen for all controllers
{
	// For each input, if any controller is pressing that button, set that button to true
	for (var i = 0; i < ds_list_size(oControllerManager.controllers); i++;)
	{
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuLeft == -1) menuLeft = oControllerManager.controllers[| i].controllerInstance.buttonMenuLeft;
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuRight) menuRight = oControllerManager.controllers[| i].controllerInstance.buttonMenuRight;
		
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuUp) menuUp = oControllerManager.controllers[| i].controllerInstance.buttonMenuUp;
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuDown == -1) menuDown = oControllerManager.controllers[| i].controllerInstance.buttonMenuDown;
		
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuConfirm) menuConfirm = true;
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuDeny) menuDeny = true;
	}
	
	menuRowMove = menuUp + menuDown;
	menuCollumnMove = menuLeft + menuRight;
	
	menuConfirmBuffer = false;
	menuDenyBuffer = false;
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
			
			// Play sound
			audio_play_sound(sfx_UI_Hover, 0, false);
		}
		
		// Handle Selecting Options
		if (menuConfirm && !menuConfirmBuffer) // If we pressed confirm
		{
			menuConfirmBuffer = true;
			
			// Play Sound
			audio_play_sound(sfx_UI_Select, 0, false);
			
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
							
							// Jay
							case oJay:
							{
								commandListCharacter = 2;
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
							
							// Jay
							case oJay:
							{
								commandListCharacter = 2;
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
			// Play Sound
			audio_play_sound(sfx_UI_Exit, 0, false);
			
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
			
			// Play Sound
			audio_play_sound(sfx_CharSel_SelectAlt, 0, false);
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
			
			// Play Sound
			audio_play_sound(sfx_UI_Hover, 0, false);
		}
		
		// Handle selections
		if (menuDeny && !menuDenyBuffer) // If we pressed Deny to go back
		{
			menuDenyBuffer = true;
			
			// Play Sound
			audio_play_sound(sfx_UI_Exit, 0, false);
			
			state = ePauseMenuState.MAIN; // Set state
			currentRow = 1; // Restore current row (Command List)
			cursorCooldown = 0; // refresh cooldown
		}
	}
	break;
	
	case ePauseMenuState.OPTIONS:
	{
		// As long as a controls menu doesn't exist, process this state
		if (!instance_exists(oSetControlsMenu))
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
			
				// Play Sound
				audio_play_sound(sfx_UI_Hover, 0, false);
			}
		
			// Handle Pressing Back
			if (menuDeny && !menuDenyBuffer)
			{
				menuDenyBuffer = true;
			
				// Play Sound
				audio_play_sound(sfx_UI_Exit, 0, false);
			
				state = ePauseMenuState.MAIN; // Set state
				currentRow = previousRow; // Restore current row
				cursorCooldown = 0; // refresh cooldown
			}
		
			// If the player presses left or right...
			if (menuCollumnMove != 0 && cursorCooldown <= 0)
			{
				switch (currentRow)
				{
					// Music
					case 0:
					{
						// Increase or decrease the volume
						global.musicVolume += 0.1 * menuCollumnMove;
					
						// Cap out the volume
						if (global.musicVolume < 0)
						{
							global.musicVolume = 0;
						}
						else if (global.musicVolume > 1)
						{
							global.musicVolume = 1;
						}
					
						// Update actual volume
						audio_group_set_gain(audiogroup_music, global.musicVolume, 0);
					
						// Play Sound
						audio_play_sound(sfx_CharSel_SelectAlt, 0, false);
					}
					break;
				
					// SFX
					case 1:
					{
						// Increase or decrease the volume
						global.sfxVolume += 0.1 * menuCollumnMove;
					
						// Cap out the volume
						if (global.sfxVolume < 0)
						{
							global.sfxVolume = 0;
						}
						else if (global.sfxVolume > 1)
						{
							global.sfxVolume = 1;
						}
					
						// Update actual volume
						audio_group_set_gain(audiogroup_soundeffect, global.sfxVolume, 0);
					
						// Play Sound
						audio_play_sound(sfx_CharSel_SelectAlt, 0, false);
					}
					break;
				
					// Voices
					case 2:
					{
						// Increase or decrease the volume
						global.voicesVolume += 0.1 * menuCollumnMove;
					
						// Cap out the volume
						if (global.voicesVolume < 0)
						{
							global.voicesVolume = 0;
						}
						else if (global.voicesVolume > 1)
						{
							global.voicesVolume = 1;
						}
					
						// Update actual volume
						audio_group_set_gain(audiogroup_voices, global.voicesVolume, 0);
					
						// Play Sound
						audio_play_sound(sfx_CharSel_SelectAlt, 0, false);
					}
					break;
				}
			
				// Add cooldown to the cursor
				cursorCooldown = cursorCooldownAmount;
			}
		
			// If the player presses Confirm
			if (menuConfirm && !menuConfirmBuffer)
			{
				menuConfirmBuffer = true;
			
				switch (currentRow)
				{
					// Set Controls
					case 4:
					{
						// Play Sound
						audio_play_sound(sfx_UI_Select, 0, false);
					
						// Spawn the controls objects
						if (playerNumber == 0)
						{
							// If this is not a CPU, spawn P1's controls object
							if (controllerSlot != -1)
							{
								var p1ControlsMenu = instance_create_depth(global.camObj.x - 80, global.camObj.y, -20000, oSetControlsMenu);
								p1ControlsMenu.playerNumber = 0;
								p1ControlsMenu.playerControls = global.player1Controls;
								
								// Search for the controller instance so we know what controller type to look for
								var controllerInstance = FindController(controllerSlot);
								if (controllerInstance != -1)
								{
									p1ControlsMenu.playerControlsType = controllerInstance.controllerType;
								}
								
								p1ControlsMenu.controllerSlot = controllerSlot;
							}
							
							// Spawn P2 control object, unless that player's a CPU
							if (p2ControllerSlot != -1)
							{
								var p2ControlsMenu = instance_create_depth(global.camObj.x, global.camObj.y, -20000, oSetControlsMenu);
								p2ControlsMenu.playerNumber = 1;
								p2ControlsMenu.playerControls = global.player2Controls;
								
								// Search for the controller instance so we know what controller type to look for
								var controllerInstance2 = FindController(p2ControllerSlot);
								if (controllerInstance2 != -1)
								{
									p2ControlsMenu.playerControlsType = controllerInstance2.controllerType;
								}
								
								p2ControlsMenu.controllerSlot = p2ControllerSlot;
								p2ControlsMenu.isWaitingForInput = true;
							}
						}
						else
						{
							// Spawn P2 control object, unless that player's a CPU
							if (controllerSlot != -1)
							{
								var p2ControlsMenu = instance_create_depth(global.camObj.x, global.camObj.y, -20000, oSetControlsMenu);
								p2ControlsMenu.playerNumber = 1;
								p2ControlsMenu.playerControls = global.player2Controls;
								
								// Search for the controller instance so we know what controller type to look for
								var controllerInstance2 = FindController(controllerSlot);
								if (controllerInstance2 != -1)
								{
									p2ControlsMenu.playerControlsType = controllerInstance2.controllerType;
								}
								
								p2ControlsMenu.controllerSlot = controllerSlot;
							}
							
							// If this is not a CPU, spawn P1's controls object
							if (p2ControllerSlot != -1)
							{
								var p1ControlsMenu = instance_create_depth(global.camObj.x - 80, global.camObj.y, -20000, oSetControlsMenu);
								p1ControlsMenu.playerNumber = 0;
								p1ControlsMenu.playerControls = global.player1Controls;
								
								// Search for the controller instance so we know what controller type to look for
								var controllerInstance = FindController(p2ControllerSlot);
								if (controllerInstance != -1)
								{
									p1ControlsMenu.playerControlsType = controllerInstance.controllerType;
								}
								
								p1ControlsMenu.controllerSlot = p2ControllerSlot;
								p1ControlsMenu.isWaitingForInput = true;
							}
						}
					}
					break;
				
					// Back
					case 5:
					{
						// Play Sound
						audio_play_sound(sfx_UI_Exit, 0, false);
					
						state = ePauseMenuState.MAIN; // Set state
						currentRow = previousRow; // Restore current row
						cursorCooldown = 0; // refresh cooldown
					}
					break;
				}
			}
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
			
			// Play Sound
			audio_play_sound(sfx_UI_Hover, 0, false);
		}
		
		// Handle Pressing Back
		if (menuDeny && !menuDenyBuffer)
		{
			menuDenyBuffer = true;
			
			// Play Sound
			audio_play_sound(sfx_UI_Exit, 0, false);
			
			state = ePauseMenuState.MAIN; // Set state
			currentRow = previousRow; // Restore current row
			cursorCooldown = 0; // refresh cooldown
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
					// Play Sound
					audio_play_sound(sfx_UI_Select, 0, false);
					
					if (areYouSureAction == eAreYouSureAction.CHARACTER_SELECT)
					{
						room_goto(rCharacterSelectScreen);
						
						// reset music
						audio_stop_sound(bgm_Russel_Stage);
					}
					else if (areYouSureAction == eAreYouSureAction.MAIN_MENU)
					{
						room_goto(rMainMenu);
						
						// reset music
						audio_stop_sound(bgm_Russel_Stage);
					}
					else if (areYouSureAction == eAreYouSureAction.RESTART)
					{
						room_restart();
						
						// reset music
						audio_stop_sound(bgm_Russel_Stage);
					}
					
				}
				break;
				
				// No
				case 1:
				{
					// Play Sound
					audio_play_sound(sfx_UI_Exit, 0, false);
					
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


