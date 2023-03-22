var P1menuUp = global.p1ButtonUp;
var P1menuDown = global.p1ButtonDown;
var P1menuConfirm = global.p1ButtonLight;
var P1menuBack = global.p1ButtonMedium;
menuCooldown--;

if (P1menuUp && menuCooldown < 1)
{
	image_index--;
	menuCooldown = 7;
}

if (P1menuDown == -1 && menuCooldown < 1)
{
	image_index++;
	menuCooldown = 7;
}


if (keyboard_check_pressed(P1menuConfirm) && image_index == 0) 
{    
	showMessage = true;
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKeyUp = keyboard_lastkey;
		global.player1Controls.buttonUp = newKeyUp;
		showMessage = false;
	}
}

if (keyboard_check_released(P1menuConfirm) && image_index == 1)
{    
	showMessage = true;
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKeyDown = keyboard_lastkey;
		global.player1Controls.buttonDown = newKeyDown;
		showMessage = false;
	}
}

if (keyboard_check_released(P1menuConfirm) && image_index == 2)
{    
	showMessage = true;
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKeyLeft = keyboard_lastkey;
		global.player1Controls.buttonLeft = newKeyLeft;
		showMessage = false;
	}
}

if (keyboard_check_released(P1menuConfirm) && image_index == 3)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKeyRight = keyboard_lastkey;
		global.player1Controls.buttonRight = newKeyRight;
		showMessage = false;
	}
}

if (keyboard_check_released(P1menuConfirm) && image_index == 4)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKeyLight = keyboard_lastkey;
		global.player1Controls.buttonLight = newKeyLight;
		showMessage = false;
	}
}

if (keyboard_check_released(P1menuConfirm) && image_index == 5)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKeyMedium = keyboard_lastkey;
		global.player1Controls.buttonMedium = newKeyMedium;
		showMessage = false;
	}
}

if (keyboard_check_released(P1menuConfirm) && image_index == 6)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKey = keyboard_lastkey;
		global.player1Controls.buttonHeavy = newKey;
		showMessage = false;
	}
}

if (keyboard_check_released(P1menuConfirm) && image_index == 7)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKey = keyboard_lastkey;
		global.player1Controls.buttonGrab = newKey;
		showMessage = false;
	}
}

if (keyboard_check_released(P1menuConfirm) && image_index == 8)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKey = keyboard_lastkey;
		global.player1Controls.buttonSpecial = newKey;
		showMessage = false;
	}
}

if (keyboard_check_released(P1menuConfirm) && image_index == 9)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKey = keyboard_lastkey;
		global.player1Controls.buttonSuper = newKey;
		showMessage = false;
	}
}

if (keyboard_check_released(P1menuConfirm) && image_index == 10)
{    
	if(keyboard_check_pressed(vk_anykey)) 
	{
		var newKey = keyboard_lastkey;
		global.player1Controls.buttonRun = newKey;
		showMessage = false;
	}
}

if (P1menuBack)
{
	room_goto_previous()
}



