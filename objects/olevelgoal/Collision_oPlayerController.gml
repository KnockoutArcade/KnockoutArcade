/// @description Insert description here
// You can write your code in this editor

if (!global.gameHalt)
{
	audio_stop_sound(bgm_Russel_Stage);

	global.campaignMapRoom = levelDestination;

	global.campaignMapLocationX = mapReturnX;
	global.campaignMapLocationY = mapReturnY;

	ds_list_add(global.completedLevels, levelName);

	global.hasCompletedLevel = true;
}