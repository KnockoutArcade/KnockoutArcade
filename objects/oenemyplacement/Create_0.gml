/// @description Insert description here
// You can write your code in this editor

enemySetup = function() 
{
	// Create the enemy object
	enemyID = instance_create_layer(x, y, "Instances", enemyToSpawn);
	
	// Create the enemy controller
	enemyControllerID = instance_create_layer(x, y, "Instances", oAIController);
	
	// Create the enemy AI object
	enemyAIObject = instance_create_layer(x, y, "Instances", enemyBehavior);

	// Setup the enemy
	with (enemyID)
	{
		// No player
		playerID = 0;
	
		// Set HP
		hp = other.enemyHP;
	
		// Set facing direction
		image_xscale = other.enemyInitialDirection;
	
		// We're gunna assume that there's always exactly 1 GameManager in the scene.
		opponent = oGameManager.p1;
	
		// Make sure they're allowed to be offscreen
		shouldStayOnScreen = false;
	
		// Setup the palette for this object
		PaletteSetup(other.enemyPaletteID, selectedCharacter);
	
		// Hook up controller
		controllerID = other.enemyControllerID;
	}

	// Set up AI
	with (enemyAIObject)
	{
		characterID = other.enemyID; // The character that this AI is controlling
		controllerID = other.enemyControllerID; // The controller object to communicate with
		opponent = oGameManager.p1; // Who this AI is targeting
		
		AIState = eAIState.INACTIVE; // Make sure this enemy is inactive when it's spawned.
	}
}

//enemySetup();

// Whether this object should be active or not
isActive = false;

// Whether the AI this object handles should be active
isAIActive = false;