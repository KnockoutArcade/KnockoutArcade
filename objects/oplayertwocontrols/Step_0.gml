var P2menuUp = global.p2ButtonUp;
var P2menuDown = global.p2ButtonDown;
var P2menuConfirm = global.p2ButtonLight;
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

if (P2menuConfirm && image_index == 0)
{    
		show_message("Press Any Key")
		global.p1ButtonUp = keyboard_lastkey;
}


