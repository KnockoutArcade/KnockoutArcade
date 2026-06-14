// Which level to send the player to
levelDestination = rPlatformingStage_Russel1;

// Where to start the player in the level
levelStartX = 32;
levelStartY = 0;

levelName = "CoinOpCarnage";

// If the level for this object has been completed, change its color
if (ds_list_find_index(global.completedLevels, levelName) != -1)
{
	image_index = 1;
}
else
{
	image_index = 0;
}

startLevelDelay = 10;