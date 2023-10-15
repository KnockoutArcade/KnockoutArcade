/// @description Insert description here
// You can write your code in this editor

// Increase the event timer
AIEventTimer++;

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
		
		// if enough time has passed
		if (AIEventTimer >= 120)
		{
			// Set the state
			AIState = eAIState.WALK;
			
			// Set where we are going
			targetPositionX = opponent.x;
			targetPositionY = opponent.y;
			
			// Reset event timer
			AIEventTimer = 0;
		}
	}
	break;
	
	case eAIState.WALK :
	{
		// Determine which direction we need to walk in
		var walkDirection = sign(targetPositionX - x);
		
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
			controllerID.buttonLeft = false;
			controllerID.buttonRight = false;
		}
	}
	break;
	
	case eAIState.ATTACK :
	{
		
	}
	break;
	
	case eAIState.HURT :
	{
		
	}
	break;
}
