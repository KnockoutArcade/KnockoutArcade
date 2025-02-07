/// @description Insert description here
// You can write your code in this editor

if (oGameManager.p1.isInCutscene)
{
	exit;
}

// This is a basic enemy that occasionally walks in and hits the player with a 3-hit combo


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
	controllerID.buttonLight = false;
			
	// Reset Timer
	AIEventTimer = 0;
}

// Prevent this object from running and blocking
characterID.canRun = false;
characterID.isAbleToBlock = false;

// FSM - Finite State Machine
switch (AIState)
{
	case eAIState.INACTIVE :
	{
		// Do nothing
	}
	break;
	
	case eAIState.IDLE :
	{
		// Set our controller inputs
		controllerID.buttonLeft = false;
		controllerID.buttonRight = false;
		controllerID.buttonUp = false;
		controllerID.buttonDown = false;
		
		// Upon entering this state, determine how long between actions
		if (AIEventTimer == 1)
		{
			randomDelayTimer = irandom_range(30, 90);
		}
		
		// Wait a random amount of time
		randomDelayTimer--;
		
		// Once that timer runs out...
		if (randomDelayTimer <= 0)
		{
			// choose whether to walk or attack
			var decideWalkOrAttack = irandom_range(0, 15);
			
			// 12/15 chance to choose walking
			if (decideWalkOrAttack < 16)
			{
				// Set the state
				AIState = eAIState.WALK;
		
				// Reset event timers
				AIEventTimer = 0;
			
				// Determine random ideal range
				idealRangeChosenVariation = irandom_range(-idealRangeVariation, idealRangeVariation);
		
				// Set where we are going
				setTargetPosition(opponent.x + ((idealRangeFromPlayer + idealRangeChosenVariation)) * -sign(characterID.image_xscale), characterID.y);
			}
			else // 3/15 chance to attack
			{
				// Set the state
				AIState = eAIState.ATTACK;
		
				// Reset event timers
				AIEventTimer = 0;
				
				// Set the attack substate to 0
				attackSubstate = 0;
			}
		}
		
	}
	break;
	
	case eAIState.WALK :
	{
		// Determine where we need to go (refresh every 5 frames)
		// In this case, our target is some distance away from the player (based on the direction this is facing)
		if (AIEventTimer mod 5 == 0)
		{
			setTargetPosition(opponent.x + ((idealRangeFromPlayer + idealRangeChosenVariation)) * -sign(characterID.image_xscale), characterID.y);
		}
		
		// Determine which direction we need to walk in
		var walkDirection = sign(targetPositionX - characterID.x);
		
		// Determine if we have reached our destination
		if (characterID.x < (targetPositionX + closeEnoughToTargetRange)) && (characterID.x > targetPositionX - closeEnoughToTargetRange)
		{
			walkDirection = 0;
		}
		
		// Floor collision check
		with (characterID)
		{
			// If our next position would make us walk close to over a pit, stop moving.
			if (!place_meeting(x + (walkSpeed * sign(image_xscale)), y + 1, oCollisionParent))
			{
				// note, we are using the walkspeed of the enemy so that we can be the most accurate.
				walkDirection = 0;
			}
			else if (!place_meeting(x + (walkSpeed * -sign(image_xscale)), y + 1, oCollisionParent))
			{
				// We also need to check if this enemy would walk backwards off of a platform.
				walkDirection = 0;
			}
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
			AIState = eAIState.IDLE;
			
			// Clear inputs
			controllerID.buttonLeft = false;
			controllerID.buttonRight = false;
			
			// Reset Timer
			AIEventTimer = 0;
		}
		
		// After a little over 2 seconds, if we have not reached our destination, go back to idle.
		if (AIEventTimer >= 130)
		{
			// Set the state
			AIState = eAIState.IDLE;
			
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
		// This state is split into two sub-states. 
		// First, walk to the player...
		if (!attackSubstate)
		{
			setTargetPosition(opponent.x, opponent.y);
			
			// Determine which direction we need to walk in
			var walkDirection = sign(targetPositionX - characterID.x);
		
			// Determine if we have reached our destination
			if (characterID.x < (targetPositionX + 20)) && (characterID.x > targetPositionX - 20)
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
			
				// Transition to the attack substate.
				attackSubstate = 1;
				
				AIEventTimer = 0;
				
				// Reset controls
				controllerID.buttonRight = false;
				controllerID.buttonLeft = false;
			}
			
			// If we can't get to the player fast enough, then just go back to idle
			if (AIEventTimer >= 120)
			{
				AIState = eAIState.IDLE;
				
				// Reset vars
				AIEventTimer = 0;
				attackSubstate = 0;
				
				// Reset controls
				controllerID.buttonRight = false;
				controllerID.buttonLeft = false;
			}
		}
		else // then, attack the player
		{
			// Hold down the light attack button
			controllerID.buttonLight = true;
			
			// After the attack is done, go back to idle.
			if (AIEventTimer > 30)
			{
				AIState = eAIState.IDLE;
				AIEventTimer = 0;
				attackSubstate = 0;
				
				controllerID.buttonLight = false;
			}
		}
	}
	break;
	
	case eAIState.HURT :
	{
		// Return to Walk once we've recovered
		if (characterID.state == eState.IDLE)
		{
			// Set the state
			AIState = eAIState.IDLE;
			
			// Reset event timers
			AIEventTimer = 0;
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



