var P1menuUp = global.p1ButtonUp;
var P1menuDown = global.p1ButtonDown;
var P1menuConfirm = global.p1ButtonLight;

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

if (image_index == 0 and P1menuConfirm)
{
	room_goto(rRusselMap);
}

if (image_index == 1 and P1menuConfirm)
{
	room_goto(rCharacterSelectScreen);
}