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

if (image_index == 0 && P1menuConfirm)
{
	room_goto(rRusselMap);
}

if (image_index == 1 && P1menuConfirm)
{
	room_goto(rCharacterSelectScreen);
}

if (image_index == 2 and P1menuConfirm)
{
	room_goto(rOptions);
}

if (image_index == 4 && P1menuConfirm)
{
	room_goto(rCredits);
}

// Testing out Single-Player Mechanics. This takes you to the test level
if (image_index == 2 && P1menuConfirm)
{
	room_goto(rPlatformingTestStage);
	
	global.gameMode = GAMEMODE.PLATFORMING;
	
	global.p1SelectedCharacter = oRussel;
	global.p1PaletteID = 0;
}