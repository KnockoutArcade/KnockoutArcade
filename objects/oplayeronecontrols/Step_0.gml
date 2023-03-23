
if (playerID == 1)
{
	var menuUp = global.p1ButtonUp;
	var menuDown = global.p1ButtonDown;
	var menuConfirm = global.p1ButtonLight;
	var menuBack = global.p1ButtonMedium;
}
else
{
	var menuUp = global.p2ButtonUp;
	var menuDown = global.p2ButtonDown;
	var menuConfirm = global.p2ButtonLight;
	var menuBack = global.p2ButtonMedium;
}

menuCooldown--;


if (menuCooldown < 1 && !showMessage)
{
	if (menuUp)
	{
		image_index--;
		menuCooldown = 10;
	}
	else if (menuDown == -1)
	{
		image_index++;
		menuCooldown = 10;
	}
}

// I removed p1confirmPressed since it would be redundant. All of the attack buttons already use check_pressed.

if (menuConfirm && !showMessage && menuCooldown < 1)
{
	menuCooldown = 10;
	showMessage = true;
}
else if(showMessage)
{
	if (menuCooldown < 1)
	{
		switch (image_index)
		{
			case 0: // up
				if(keyboard_check_pressed(vk_anykey))
				{
					var newKey = keyboard_lastkey;
					playerControlsToChange.buttonUp = newKey;
					showMessage = false;
				}
			break;
			
			case 1: // down
				if(keyboard_check_pressed(vk_anykey))
				{
					var newKey = keyboard_lastkey;
					playerControlsToChange.buttonDown = newKey;
					showMessage = false;
				}
			break;
			
			case 2: // left
				if(keyboard_check_pressed(vk_anykey))
				{
					var newKey = keyboard_lastkey;
					playerControlsToChange.buttonLeft = newKey;
					showMessage = false;
				}
			break;
			
			case 3: // right
				if(keyboard_check_pressed(vk_anykey))
				{
					var newKey = keyboard_lastkey;
					playerControlsToChange.buttonRight = newKey;
					showMessage = false;
				}
			break;
			
			
			case 4: // light
				if(keyboard_check_pressed(vk_anykey))
				{
					var newKey = keyboard_lastkey;
					playerControlsToChange.buttonLight = newKey;
					showMessage = false;
				}
			break;
			
			case 5: // medium
				if(keyboard_check_pressed(vk_anykey))
				{
					var newKey = keyboard_lastkey;
					playerControlsToChange.buttonMedium = newKey;
					showMessage = false;
				}
			break;
			
			case 6: // heavy
				if(keyboard_check_pressed(vk_anykey))
				{
					var newKey = keyboard_lastkey;
					playerControlsToChange.buttonHeavy = newKey;
					showMessage = false;
				}
			break;
			
			case 7: //grab
				if(keyboard_check_pressed(vk_anykey))
				{
					var newKey = keyboard_lastkey;
					playerControlsToChange.buttonGrab = newKey;
					showMessage = false;
				}
			break;
			
			case 8: //special
				if(keyboard_check_pressed(vk_anykey))
				{
					var newKey = keyboard_lastkey;
					playerControlsToChange.buttonSpecial = newKey;
					showMessage = false;
				}
			break;
			
			
			case 9: //Super
				if(keyboard_check_pressed(vk_anykey))
				{
					var newKey = keyboard_lastkey;
					playerControlsToChange.buttonSuper = newKey;
					showMessage = false;
				}
			break;
			
			case 10: //Run
				if(keyboard_check_pressed(vk_anykey))
				{
					var newKey = keyboard_lastkey;
					playerControlsToChange.buttonRun = newKey;
					showMessage = false;
				}
			break;
		}
	}
}

// if (keyboard_check_pressed(P1menuConfirm) && image_index == 0)
// {    
// 	showMessage = true;
// 	if(keyboard_check_pressed(vk_anykey)) 
// 	{
// 		var newKeyUp = keyboard_lastkey;
// 		global.player1Controls.buttonUp = newKeyUp;
// 		showMessage = false;
// 	}
// }

// if (keyboard_check_released(P1menuConfirm) && image_index == 1)
// {    
// 	showMessage = true;
// 	if(keyboard_check_pressed(vk_anykey)) 
// 	{
// 		var newKeyDown = keyboard_lastkey;
// 		global.player1Controls.buttonDown = newKeyDown;
// 		showMessage = false;
// 	}
// }

// if (keyboard_check_released(P1menuConfirm) && image_index == 2)
// {    
// 	showMessage = true;
// 	if(keyboard_check_pressed(vk_anykey)) 
// 	{
// 		var newKeyLeft = keyboard_lastkey;
// 		global.player1Controls.buttonLeft = newKeyLeft;
// 		showMessage = false;
// 	}
// }

// if (keyboard_check_released(P1menuConfirm) && image_index == 3)
// {    
// 	if(keyboard_check_pressed(vk_anykey)) 
// 	{
// 		var newKeyRight = keyboard_lastkey;
// 		global.player1Controls.buttonRight = newKeyRight;
// 		showMessage = false;
// 	}
// }

// if (keyboard_check_released(P1menuConfirm) && image_index == 4)
// {    
// 	if(keyboard_check_pressed(vk_anykey)) 
// 	{
// 		var newKeyLight = keyboard_lastkey;
// 		global.player1Controls.buttonLight = newKeyLight;
// 		showMessage = false;
// 	}
// }

// if (keyboard_check_released(P1menuConfirm) && image_index == 5)
// {    
// 	if(keyboard_check_pressed(vk_anykey)) 
// 	{
// 		var newKeyMedium = keyboard_lastkey;
// 		global.player1Controls.buttonMedium = newKeyMedium;
// 		showMessage = false;
// 	}
// }

// if (keyboard_check_released(P1menuConfirm) && image_index == 6)
// {    
// 	if(keyboard_check_pressed(vk_anykey)) 
// 	{
// 		var newKey = keyboard_lastkey;
// 		global.player1Controls.buttonHeavy = newKey;
// 		showMessage = false;
// 	}
// }

// if (keyboard_check_released(P1menuConfirm) && image_index == 7)
// {    
// 	if(keyboard_check_pressed(vk_anykey)) 
// 	{
// 		var newKey = keyboard_lastkey;
// 		global.player1Controls.buttonGrab = newKey;
// 		showMessage = false;
// 	}
// }

// if (keyboard_check_released(P1menuConfirm) && image_index == 8)
// {    
// 	if(keyboard_check_pressed(vk_anykey)) 
// 	{
// 		var newKey = keyboard_lastkey;
// 		global.player1Controls.buttonSpecial = newKey;
// 		showMessage = false;
// 	}
// }

// if (keyboard_check_released(P1menuConfirm) && image_index == 9)
// {    
// 	if(keyboard_check_pressed(vk_anykey)) 
// 	{
// 		var newKey = keyboard_lastkey;
// 		global.player1Controls.buttonSuper = newKey;
// 		showMessage = false;
// 	}
// }

// if (keyboard_check_released(P1menuConfirm) && image_index == 10)
// {    
// 	if(keyboard_check_pressed(vk_anykey)) 
// 	{
// 		var newKey = keyboard_lastkey;
// 		global.player1Controls.buttonRun = newKey;
// 		showMessage = false;
// 	}
// }

if (menuBack && !showMessage)
{
	room_goto_previous()
}
