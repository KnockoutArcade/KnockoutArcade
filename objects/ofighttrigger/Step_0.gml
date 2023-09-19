/// @description Insert description here
// You can write your code in this editor

if (isTriggered)
{
	enemyID = instance_create_layer(enemySpawnX, enemySpawnY, "Instances", enemyToSpawn);
	
	with (enemyID)
	{
		playerID = 3;
		
		hp = 10;
		
		image_xscale = other.enemyInitialDirection;
		opponent = other.instanceThatTriggeredThis;
	}
	
	isCurrentlyActive = true;
	
	global.camObj.isLocked = lockCamera;
	global.camObj.x = lockCameraPositionX;
	global.camObj.y = lockCameraPositionY;
	
	isTriggered = false;
}


if (isCurrentlyActive)
{
	if (enemyID.hp <= 0)
	{
		isCurrentlyActive = false;
		global.camObj.isLocked = false;
		
		instance_destroy();
	}
}