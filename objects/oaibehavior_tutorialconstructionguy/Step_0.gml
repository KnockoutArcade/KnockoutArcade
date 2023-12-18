/// @description Insert description here
// You can write your code in this editor

// Increase the event timer
AIEventTimer++;

// If this has been hit, go to hurt state
if (characterID.hitstun > 0)
{
	// Set the state
	AIState = eAIState.HURT;
	
	// Clear inputs
	controllerID.buttonLeft = false;
	controllerID.buttonRight = false;
	controllerID.buttonHeavy = false;
			
	// Reset Timer
	AIEventTimer = 0;
}

// Prevent this object from running
characterID.canRun = false;

// FSM - Finite State Machine
switch (AIState)
{
	case eAIState.INACTIVE :
	{
		
	}
	break;
	
	case eAIState.IDLE :
	{
		// Set our controller inputs
		controllerID.buttonLeft = false;
		controllerID.buttonRight = false;
		controllerID.buttonUp = false;
		controllerID.buttonDown = false;
		
		// If this AI is ever in idle, go to the walk state instead.
		// Set the state
		AIState = eAIState.WALK;
		
		// Reset event timers
		AIEventTimer = 0;
			
		// Determine random delay
		randomDelayTimer = irandom_range(30, 120);
			
		// Determine random ideal range
		idealRangeChosenVariation = irandom_range(-idealRangeVariation, idealRangeVariation);
		
		// Set where we are going
		targetPositionX = opponent.x + ((idealRangeFromPlayer + idealRangeChosenVariation)) * -sign(characterID.image_xscale);
		targetPositionY = opponent.y;
	}
	break;
	
	case eAIState.WALK :
	{
		// Determine where we need to go (refresh every 5 frames)
		// In this case, our target is some distance away from the player (based on the direction this is facing)
		if (AIEventTimer mod 5 == 0)
		{
			targetPositionX = opponent.x + ((idealRangeFromPlayer + idealRangeChosenVariation)) * -sign(characterID.image_xscale);
		}
		
		// Determine which direction we need to walk in
		var walkDirection = sign(targetPositionX - characterID.x);
		
		// Determine if we have reached our destination
		if (characterID.x < (targetPositionX + closeEnoughToTargetRange)) && (characterID.x > targetPositionX - closeEnoughToTargetRange)
		{
			walkDirection = 0;
		}
		
		// If the destination is to the left
		if (walkDirection == -1)
		{
			controllerID.buttonLeft = true;
			controllerID.buttonRight = false;
		}
		else if (walkDirection == 1) // if the destination is to the right
		{
			controllerID.buttonLeft = false;
			controllerID.buttonRight = true;
		}
		else // If we reach our destination
		{
			// if walk direction is 0, it means we don't need to move and we are able to attack
			
			// Set the state
			AIState = eAIState.ATTACK;
			
			// Clear inputs
			controllerID.buttonLeft = false;
			controllerID.buttonRight = false;
			
			// Reset Timer
			AIEventTimer = 0;
		}
	}
	break;
	
	case eAIState.ATTACK :
	{
		// Upon entering this state
		if (AIEventTimer <= 1)
		{
			// Input a heavy attack
			controllerID.buttonHeavy = true;
		}
		else
		{
			controllerID.buttonHeavy = false;
		}
		
		// Once the attack has finished (the character is not in an attack state anymore)
		if (!characterID.inAttackState && AIEventTimer > 1)
		{
			// Set the state
			AIState = eAIState.WALK;
			
			// Clear inputs
			controllerID.buttonHeavy = false;
			
			// Determine random delay
			randomDelayTimer = irandom_range(30, 120);
			
			// Determine random ideal range
			idealRangeChosenVariation = irandom_range(-idealRangeVariation, idealRangeVariation);
			
			// Set where we are going
			targetPositionX = opponent.x + ((idealRangeFromPlayer + idealRangeChosenVariation)) * -sign(characterID.image_xscale);
			targetPositionY = opponent.y;
		}
	}
	break;
	
	case eAIState.HURT :
	{
		// Return to Walk once we've recovered
		if (characterID.state == eState.IDLE)
		{
			// Set the state
			AIState = eAIState.WALK;
			
			// Reset event timers
			AIEventTimer = 0;
			
			// Determine random delay
			randomDelayTimer = irandom_range(30, 120);
			
			// Determine random ideal range
			idealRangeChosenVariation = irandom_range(-idealRangeVariation, idealRangeVariation);
			
			// Set where we are going
			targetPositionX = opponent.x + ((idealRangeFromPlayer + idealRangeChosenVariation)) * -sign(characterID.image_xscale);
			targetPositionY = opponent.y;
		}
	}
	break;
	
	default : // If this has entered an invalid state
	{
		// Set the state
		AIState = eAIState.IDLE;
		// Reset event timer
		AIEventTimer = 0;
	}
}
