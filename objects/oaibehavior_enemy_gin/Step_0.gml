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
			randomDelayTimer = irandom_range(30, 120);
		}
		
		// Wait a random amount of time
		randomDelayTimer--;
		
		// Once that timer runs out...
		if (randomDelayTimer <= 0)
		{
			// choose whether to walk or attack
			var decideWalkOrAttack = irandom_range(0, 9);
			
			// 6/10 chance to choose walking
			if (decideWalkOrAttack < 7)
			{
				// Set the state
				AIState = eAIState.WALK;
		
				// Reset event timers
				AIEventTimer = 0;
			
				// Determine random ideal range
				idealRangeChosenVariation = irandom_range(-idealRangeVariation, idealRangeVariation);
		
				// Set where we are going
				targetPositionX = opponent.x + ((idealRangeFromPlayer + idealRangeChosenVariation)) * -sign(characterID.image_xscale);
				targetPositionY = opponent.y;
			}
			else // 4/10 chance to attack
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
			// Walk towards the player
			if (opponent.x > characterID.x)
			{
				controllerID.buttonRight = true;
				controllerID.buttonLeft = false;
			}
			else if (opponent.x < characterID.x)
			{
				controllerID.buttonLeft = true;
				controllerID.buttonRight = false;
			}
			
			// Determine if we have gotten close enough to the player
			if (characterID.x < opponent.x + 20) && (characterID.x > opponent.x - 20)
			{
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
			/*
			// Determine random delay
			randomDelayTimer = irandom_range(30, 120);
			
			// Determine random ideal range
			idealRangeChosenVariation = irandom_range(-idealRangeVariation, idealRangeVariation);
			
			// Set where we are going
			targetPositionX = opponent.x + ((idealRangeFromPlayer + idealRangeChosenVariation)) * -sign(characterID.image_xscale);
			targetPositionY = opponent.y;
			*/
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



