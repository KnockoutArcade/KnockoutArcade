playerSelectedText = (playerControlsToChange == global.player1Controls) ? "Player 1" : "Player 2";

if (playerID == 1)
{
	var menuUp = global.p1ButtonUp;
	var menuDown = global.p1ButtonDown;
	var menuLeft = global.p1ButtonLeft;
	var menuRight = global.p1ButtonRight;
	var menuConfirm = global.p1ButtonLight;
	var menuBack = global.p1ButtonMedium;
}
else
{
	var menuUp = global.p2ButtonUp;
	var menuDown = global.p2ButtonDown;
	var menuLeft = global.p1ButtonLeft;
	var menuRight = global.p1ButtonRight;
	var menuConfirm = global.p2ButtonLight;
	var menuBack = global.p2ButtonMedium;
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
			playerControlsToChange = (playerControlsToChange == global.player1Controls) ? global.player2Controls : global.player1Controls;
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
			playerControlsToChange = (playerControlsToChange == global.player1Controls) ? global.player2Controls : global.player1Controls;
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
		if (global.player1ControllerType == "KEYBOARD")
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
		if (global.player2ControllerType == "KEYBOARD")
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
				playerControlsToChange.buttonUp = newKey;
			break;
			
			case 1: // down
				playerControlsToChange.buttonDown = newKey;
			break;
			
			case 2: // left
				playerControlsToChange.buttonLeft = newKey;
			break;
			
			case 3: // right
				playerControlsToChange.buttonRight = newKey;
			break;
			
			case 8: // light
				playerControlsToChange.buttonLight = newKey;
			break;
			
			case 9: // medium
				playerControlsToChange.buttonMedium = newKey;
			break;
			
			case 10: // heavy
				playerControlsToChange.buttonHeavy = newKey;
			break;
			
			case 11: //grab
				playerControlsToChange.buttonGrab = newKey;
			break;
			
			case 12: //special
				playerControlsToChange.buttonSpecial = newKey;
			break;
			
			case 13: //Super
				playerControlsToChange.buttonSuper = newKey;
			break;
			
			case 14: //Run
				playerControlsToChange.buttonRun = newKey;
			break;
		}
	}
	
	SaveControls();
}

if (menuBack && !showMessage)
{
	room_goto_previous()
}
