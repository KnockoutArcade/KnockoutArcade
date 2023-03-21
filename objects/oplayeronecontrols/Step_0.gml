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

if (P1menuConfirm) && image_index == 0
{    
	remapKey = true;
}

if keyboard_check_pressed(ord("Q"))
{
	showNewKey = true;
}

if (P1menuBack)
{
	room_goto_previous()
}

if (remapKey)
{
	if(keyboard_check_pressed(vk_anykey)) 
	{
		newKey = keyboard_lastkey;
		remapKey = false;
		global.p1ButtonUp = newKey;
	}
}

