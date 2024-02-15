/// @description Insert description here
// You can write your code in this editor

if (global.p1ButtonMenuConfirm)
{
	
	global.p1StartingPositionX = levelStartX;
	global.p1StartingPositionY = levelStartY;
	
	global.gameMode = GAMEMODE.PLATFORMING;
	
	global.p1SelectedCharacter = oBeverly;
	global.p1PaletteID = 0;
	
	global.campaignStartLevelDelay = startLevelDelay;
	
	room_goto(levelDestination);
}


