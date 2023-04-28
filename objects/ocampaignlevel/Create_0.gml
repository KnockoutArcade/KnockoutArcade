/// @description Insert description here
// You can write your code in this editor

// Which level to send the player to
levelDestination = rCampaignLevelTemplate;

// Where to start the player in the level
levelStartX = 32;
levelStartY = 104;

levelName = "CampaignTest";

// If the level for this object has been completed, change its color
if (ds_list_find_index(global.completedLevels, levelName) != -1)
{
	image_index = 1;
}