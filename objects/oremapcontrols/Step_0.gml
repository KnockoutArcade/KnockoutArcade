playerSelectedText = (playerControlsToChange == global.player1Controls) ? "Player 1" : "Player 2";

if (playerID == 1)
{
	var menuUp = global.p1ButtonMenuUp;
	var menuDown = global.p1ButtonMenuDown;
	var menuLeft = global.p1ButtonMenuLeft;
	var menuRight = global.p1ButtonMenuRight;
	var menuConfirm = global.p1ButtonMenuConfirm;
	var menuBack = global.p1ButtonMenuDeny;
}
else
{
	var menuUp = global.p2ButtonMenuUp;
	var menuDown = global.p2ButtonMenuDown;
	var menuLeft = global.p1ButtonMenuLeft;
	var menuRight = global.p1ButtonMenuRight;
	var menuConfirm = global.p2ButtonMenuConfirm;
	var menuBack = global.p2ButtonMenuDeny;
}

menuCooldown--;


if (menuCooldown < 1 && !showMessage)
{
	if (menuUp)
	{
		selectedOption--;
		menuCooldown = 10;
	}
	else if (menuDown == -1)
	{
		selectedOption++;
		menuCooldown = 10;
	}
	else if (menuLeft == -1)
	{
		menuCooldown = 10;
		
		if (selectedOption == -1)
		{
			// If we are selecting the very top option, switch between changing player 1 and player 2's controls
			playerControlsToChange = (playerControlsToChange == global.player1Controls) ? global.player2Controls : global.player1Controls;
			playerControlsType = (playerControlsType == global.player1ControllerType) ? global.player2ControllerType : global.player1ControllerType;
		}
		else
		{
			selectedOption -= 8;
		}
	}
	else if (menuRight)
	{
		menuCooldown = 10;
		
		if (selectedOption == -1)
		{
			// If we are selecting the very top option, switch between changing player 1 and player 2's controls
			playerControlsToChange = (playerControlsToChange == global.player1Controls) ? global.player2Controls : global.player1Controls;
			playerControlsType = (playerControlsType == global.player1ControllerType) ? global.player2ControllerType : global.player1ControllerType;
		}
		else
		{
			selectedOption += 8;
		}
	}
}

// handle special cases in menu movement
if (selectedOption == -2) // pressed up from the player selector
{
	selectedOption = -1;
}
else if (selectedOption == 15) // pressed down from run
{
	selectedOption = 14;
}
else if (selectedOption > 3 && selectedOption < 8) // pressed down from right or left on special, super, run
{
	selectedOption = 3;
}
else if (selectedOption < -2) // pressed left on up, down, left, or right
{
	selectedOption += 16;
}
else if (selectedOption > 15) // pressed right on light, medium, heavy, grab, special, super, or run
{
	selectedOption -= 16;
}

if (menuBack && !showMessage)
{
	room_goto_previous()
}

if (menuConfirm && !showMessage && menuCooldown < 1)
{
	menuCooldown = 10;
	showMessage = true;
}
else if(showMessage)
{
	var newKeyPressed = false;
	var newKey = 0;
	
	if (playerControlsToChange == global.player1Controls)
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
	
	
	if (menuCooldown < 1 && newKeyPressed)
	{
		showMessage = false;
		menuCooldown = 10;
		
		switch (selectedOption)
		{
			case 0: // up
				if (playerControlsType == "KEYBOARD")
				{
					playerControlsToChange.Keyboard.buttonUp = newKey;
				}
				else
				{
					playerControlsToChange.Controller.buttonUp = newKey;
				}
			break;
			
			case 1: // down
				if (playerControlsType == "KEYBOARD")
				{
					playerControlsToChange.Keyboard.buttonDown = newKey;
				}
				else
				{
					playerControlsToChange.Controller.buttonDown = newKey;
				}
			break;
			
			case 2: // left
				if (playerControlsType == "KEYBOARD")
				{
					playerControlsToChange.Keyboard.buttonLeft = newKey;
				}
				else
				{
					playerControlsToChange.Controller.buttonLeft = newKey;
				}
			break;
			
			case 3: // right
				if (playerControlsType == "KEYBOARD")
				{
					playerControlsToChange.Keyboard.buttonRight = newKey;
				}
				else
				{
					playerControlsToChange.Controller.buttonRight = newKey;
				}
			break;
			
			case 8: // light
				if (playerControlsType == "KEYBOARD")
				{
					playerControlsToChange.Keyboard.buttonLight = newKey;
				}
				else
				{
					playerControlsToChange.Controller.buttonLight = newKey;
				}
			break;
			
			case 9: // medium
				if (playerControlsType == "KEYBOARD")
				{
					playerControlsToChange.Keyboard.buttonMedium = newKey;
				}
				else
				{
					playerControlsToChange.Controller.buttonMedium = newKey;
				}
			break;
			
			case 10: // heavy
				if (playerControlsType == "KEYBOARD")
				{
					playerControlsToChange.Keyboard.buttonHeavy = newKey;
				}
				else
				{
					playerControlsToChange.Controller.buttonHeavy = newKey;
				}
			break;
			
			case 11: //grab
				if (playerControlsType == "KEYBOARD")
				{
					playerControlsToChange.Keyboard.buttonGrab = newKey;
				}
				else
				{
					playerControlsToChange.Controller.buttonGrab = newKey;
				}
			break;
			
			case 12: //special
				if (playerControlsType == "KEYBOARD")
				{
					playerControlsToChange.Keyboard.buttonSpecial = newKey;
				}
				else
				{
					playerControlsToChange.Controller.buttonSpecial = newKey;
				}
			break;
			
			case 13: //Super
				if (playerControlsType == "KEYBOARD")
				{
					playerControlsToChange.Keyboard.buttonSuper = newKey;
				}
				else
				{
					playerControlsToChange.Controller.buttonSuper = newKey;
				}
			break;
			
			case 14: //Run
				if (playerControlsType == "KEYBOARD")
				{
					playerControlsToChange.Keyboard.buttonRun = newKey;
				}
				else
				{
					playerControlsToChange.Controller.buttonRun = newKey;
				}
			break;
		}
		SaveControls();
	}
}
