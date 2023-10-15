/// @description Insert description here
// You can write your code in this editor

if (isTriggered)
{
	// Create the enemy object
	enemyID = instance_create_layer(enemySpawnX, enemySpawnY, "Instances", enemyToSpawn);
	
	// Create the enemy controller
	enemyControllerID = instance_create_layer(enemySpawnX, enemySpawnY, "Instances", oAIController);
	
	// Create the enemy AI object
	enemyAIObject = instance_create_layer(enemySpawnX, enemySpawnY, "Instances", enemyBehavior);
	
	// Setup the enemy
	with (enemyID)
	{
		// No player
		playerID = 0;
		
		// Set HP (Temporary)
		hp = 10;
		
		// Flip and set opponent
		image_xscale = other.enemyInitialDirection;
		opponent = other.instanceThatTriggeredThis;
		
		// Hook up controller
		controllerID = other.enemyControllerID;
	}
	
	// Set up AI
	with (enemyAIObject)
	{
		characterID = other.enemyID; // The character that this AI is controlling
		controllerID = other.enemyControllerID; // The controller object to communicate with
		opponent = other.instanceThatTriggeredThis; // Who this AI is targeting
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
		
		// Destroy everything
		instance_destroy(enemyID);
		instance_destroy(enemyControllerID);
		instance_destroy(enemyAIObject);
		
		instance_destroy();
	}
}