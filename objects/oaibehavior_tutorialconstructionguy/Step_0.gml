/// @description Insert description here
// You can write your code in this editor

// Increase the event timer
AIEventTimer++;

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
		var walkDirection = sign(targetPositionX - characterID.x);
		
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
		
		// After some time has passed, attack
		if (AIEventTimer >= 30)
		{
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
			AIState = eAIState.IDLE;
			
			// Clear inputs
			controllerID.buttonHeavy = false;
			
			// Reset Timer
			AIEventTimer = 0;
		}
	}
	break;
	
	case eAIState.HURT :
	{
		
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
