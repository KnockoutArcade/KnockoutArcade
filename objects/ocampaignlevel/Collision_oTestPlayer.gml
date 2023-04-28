/// @description Insert description here
// You can write your code in this editor

if (global.p1ButtonLight)
{
	room_goto(levelDestination);
	
	global.p1StartingPositionX = levelStartX;
	global.p1StartingPositionY = levelStartY;
	
	global.gameMode = GAMEMODE.PLATFORMING;
	
	global.p1SelectedCharacter = oRussel;
	global.p1PaletteID = 0;
}


