var P1menuUp = global.p1ButtonUp;
var P1menuDown = global.p1ButtonDown;
var P1menuConfirm = global.p1ButtonLight;

menuCooldown--;

if (P1menuUp && menuCooldown < 1)
{
	image_index--;
	menuCooldown = menuCooldownBuffer;
	drawInitialText = false;
} 
else if (P1menuDown == -1 && menuCooldown < 1)
{
	image_index++;
	menuCooldown = menuCooldownBuffer;
	drawInitialText = false;
}
else if (P1menuUp + P1menuDown == 0)
{
	menuCooldown = 0;
}

if (image_index == 0 && P1menuConfirm)
{
	room_goto(rRusselMap);
	
	global.campaignMapLocationX = 499;
	global.campaignMapLocationY = 105
}

if (image_index == 1 && P1menuConfirm)
{
	room_goto(rCharacterSelectScreen);
}

if (image_index == 3 && P1menuConfirm)
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

// Control Percy's Blinking
percyBlinkTimer++;
if (percyBlinkTimer >= percyEyesOpenTimerCap) && (!isPercyEyesClosed)
{
	percyBlinkTimer = 0;
	isPercyEyesClosed = true;
}
else if (percyBlinkTimer >= percyEyesClosedTimerCap) && (isPercyEyesClosed)
{
	percyBlinkTimer = 0;
	isPercyEyesClosed = false;
}