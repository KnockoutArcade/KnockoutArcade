var P2menuUp = global.p2ButtonUp;
var P2menuDown = global.p2ButtonDown;
var P2menuConfirm = global.p2ButtonLight;
var P2menuBack = global.p2ButtonMedium;
menuCooldown--;

if (P2menuUp && menuCooldown < 1)
{
	image_index--;
	menuCooldown = 7;
}

if (P2menuDown == -1 && menuCooldown < 1)
{
	image_index++;
	menuCooldown = 7;
}


if (keyboard_check_released(P2menuConfirm) && image_index == 0) 
{    
	showMessage = true;
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKeyUp = keyboard_lastkey;
		global.player2Controls.buttonUp = newKeyUp;
		showMessage = false;
	}
}

if (keyboard_check_released(P2menuConfirm) && image_index == 1)
{    
	showMessage = true;
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKeyDown = keyboard_lastkey;
		global.player2Controls.buttonDown = newKeyDown;
		showMessage = false;
	}
}

if (keyboard_check_released(P2menuConfirm) && image_index == 2)
{    
	showMessage = true;
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKeyLeft = keyboard_lastkey;
		global.player1Controls.buttonLeft = newKeyLeft;
		showMessage = false;
	}
}

if (keyboard_check_released(P2menuConfirm) && image_index == 3)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKeyRight = keyboard_lastkey;
		global.player2Controls.buttonRight = newKeyRight;
		showMessage = false;
	}
}

if (keyboard_check_released(P2menuConfirm) && image_index == 4)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKeyLight = keyboard_lastkey;
		global.player2Controls.buttonLight = newKeyLight;
		showMessage = false;
	}
}

if (keyboard_check_released(P2menuConfirm) && image_index == 5)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKeyMedium = keyboard_lastkey;
		global.player2Controls.buttonMedium = newKeyMedium;
		showMessage = false;
	}
}

if (keyboard_check_released(P2menuConfirm) && image_index == 6)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKey = keyboard_lastkey;
		global.player2Controls.buttonHeavy = newKey;
		showMessage = false;
	}
}

if (keyboard_check_released(P2menuConfirm) && image_index == 7)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKey = keyboard_lastkey;
		global.player2Controls.buttonGrab = newKey;
		showMessage = false;
	}
}

if (keyboard_check_released(P2menuConfirm) && image_index == 8)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKey = keyboard_lastkey;
		global.player2Controls.buttonSpecial = newKey;
		showMessage = false;
	}
}

if (keyboard_check_released(P2menuConfirm) && image_index == 9)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKey = keyboard_lastkey;
		global.player2Controls.buttonSuper = newKey;
		showMessage = false;
	}
}

if (keyboard_check_released(P2menuConfirm) && image_index == 10)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKey = keyboard_lastkey;
		global.player2Controls.buttonRun = newKey;
		showMessage = false;
	}
}

if (P2menuBack)
{
	room_goto_previous()
}



