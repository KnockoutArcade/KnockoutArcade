/// @description Insert description here
// You can write your code in this editor

if (isTriggered)
{
	enemyID = instance_create_layer(enemySpawnX, enemySpawnY, "Instances", enemyToSpawn);
	
	with (enemyID)
	{
		playerID = 3;
	}
	
	isCurrentlyActive = true;
	
	global.camObj.isLocked = lockCamera;
	global.camObj.x = lockCameraPositionX;
	global.camObj.y = lockCameraPositionY;
	
	isTriggered = false;
}


if (isCurrentlyActive)
{
	
}