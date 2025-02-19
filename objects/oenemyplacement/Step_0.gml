/// @description Insert description here
// You can write your code in this editor

// Check to see if the player has entered this radius AND we are not already active

// TODO: update this function once Co-op has been added
if (point_distance(x, y, oGameManager.p1.x, oGameManager.p1.y) <= activationRadius && !isActive)
{
	isActive = true;
	
	// run the setup script
	enemySetup();
}
else if (point_distance(x, y, oGameManager.p1.x, oGameManager.p1.y) >= deactivationRadius && isActive && enemyID.hp > 0)
{
	isActive = false
	isAIActive = false;
	
	// Destroy the enemy
	instance_destroy(enemyID);
	instance_destroy(enemyControllerID);
	instance_destroy(enemyAIObject);
	
	exit;
}

// Activate the AI once within range
if (point_distance(x, y, oGameManager.p1.x, oGameManager.p1.y) <= AIActivationRadius && !isAIActive)
{
	enemyAIObject.AIState = eAIState.IDLE;
	isAIActive = true;
	
	// This is to make the AI start moving instantly
	enemyAIObject.AIEventTimer = 2;
	enemyAIObject.randomDelayTimer = 0;
}



// If this object is allowed to be active
if (isActive)
{
	// Once the enemy has run out of HP or fallen into a pit, destroy it
	if ((enemyID.state == eState.ENEMY_KO && enemyID.animTimer >= 45) || enemyID.hasFallenDownPit)
	{
		// Destroy everything
		instance_destroy(enemyID);
		instance_destroy(enemyControllerID);
		instance_destroy(enemyAIObject);

		// In the future, I might not want to destroy this object to allow it to respawn its enemy
		instance_destroy();
	}
}





