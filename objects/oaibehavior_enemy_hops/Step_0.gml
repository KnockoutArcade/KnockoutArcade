/// @description Insert description here
// You can write your code in this editor

if (oGameManager.p1.isInCutscene)
{
	exit;
}

// This is a basic enemy that hops around and occasionally does a jumping attack.


// Increase the event timer
if (AIState != eAIState.INACTIVE)
{
	AIEventTimer++;
}

// If this has been hit, go to hurt state
if (characterID.hitstun > 0)
{
	// Set the state
	AIState = eAIState.HURT;
	
	// Clear inputs
	controllerID.buttonLeft = false;
	controllerID.buttonRight = false;
	controllerID.buttonUp = false;
	controllerID.buttonDown = false;
	
	controllerID.buttonMedium = false;
			
	// Reset Timer
	AIEventTimer = 0;
	
	// Allow this enemy to attack
	hasJustAttacked = false;
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
			randomDelayTimer = irandom_range(0, 30);
		}
		
		// Wait a random amount of time
		randomDelayTimer--;
		
		// Once that timer runs out...
		if (randomDelayTimer <= 0)
		{
			// choose whether to walk or Jump
			var decideWalkOrAttack = irandom_range(0, 15);
			
			// 12/15 chance to choose jumping
			if (decideWalkOrAttack < 13)
			{
				// Set the state
				AIState = eAIState.JUMP;
				
				// Might as well Jump
				controllerID.buttonUp = true;
				
				// Set has just attacked
				hasJustAttacked = false;
		
				// Reset event timers
				AIEventTimer = 0;
				
				// determine which way to jump
				walkDirection = sign(characterID.opponent.x - characterID.x);
				
				// This enemy has a chance to jump backwards or forwards (always forwards if far away from player)
				if (decideWalkOrAttack <= jumpForwardsChance || (characterID.opponent.x - characterID.x) >= playerDistanceThreshold)
				{
					// Determine which way to jump
					if (walkDirection == 1)
					{
						controllerID.buttonRight = true;
						show_debug_message("Jumped Right");
					}
					else if (walkDirection == -1)
					{
						controllerID.buttonLeft = true;
						show_debug_message("Jumped Left");
					}
					
					// Check the area where we would land and see if there's ground there
					var safeLanding = collision_line(characterID.x + (bottomlessPitDetectionDistance * walkDirection), characterID.y + 20, characterID.x + (bottomlessPitDetectionDistance * walkDirection), characterID.y - 20, oCollisionParent, false, true);
					var foundBottomlessPit = collision_line(characterID.x + (bottomlessPitDetectionDistance * walkDirection), characterID.y, characterID.x + (bottomlessPitDetectionDistance * walkDirection), characterID.y + 300, oBottomlessPit, false, true);
					
					// If it's not safe and there's a bottomless pit, jump in place
					if (!safeLanding && foundBottomlessPit)
					{
						walkDirection = 0;
						
						controllerID.buttonLeft = false;
						controllerID.buttonRight = false;
					}
				}
				else
				{
					// Determine which way to jump (away from player)
					if (walkDirection == 1)
					{
						controllerID.buttonLeft = true;
						show_debug_message("Jumped Left (Backwards)");
					}
					else if (walkDirection == -1)
					{
						controllerID.buttonRight = true;
						show_debug_message("Jumped Right (Backwards)");
					}
					
					// Check the area where we would land and see if there's ground there
					var safeLanding = collision_line(characterID.x + (bottomlessPitDetectionDistance * -walkDirection), characterID.y + 20, characterID.x + (bottomlessPitDetectionDistance * -walkDirection), characterID.y - 20, oCollisionParent, false, true);
					var foundBottomlessPit = collision_line(characterID.x + (bottomlessPitDetectionDistance * -walkDirection), characterID.y, characterID.x + (bottomlessPitDetectionDistance * -walkDirection), characterID.y + 300, oBottomlessPit, false, true);
					
					// If it's not safe and there's a bottomless pit, jump in place
					if (!safeLanding && foundBottomlessPit)
					{
						walkDirection = 0;
						
						controllerID.buttonLeft = false;
						controllerID.buttonRight = false;
					}
				}
				
			}
			else if (!hasJustAttacked)// 3/15 chance to walk around for a bit
			{
				// Set the state
				AIState = eAIState.WALK;
		
				// Reset event timers
				AIEventTimer = 0;
				
				// Make sure this enemy can't attack twice in a row.
				hasJustAttacked = true;
				
				// Set walk duration timer
				currentWalkDuration = irandom_range(walkDurationLowerBound, walkDurationUpperBound);
			}
		}
		
	}
	break;
	
	case eAIState.WALK :
	{
		// Determine where we need to go (refresh every 5 frames)
		// In this case, our target either in front or behind us
		if (AIEventTimer mod 5 == 0)
		{
			if (irandom_range(0,1) == 1)
			{
				// Go Left
				setTargetPosition(characterID.x - 50, characterID.y);
			}
			else
			{
				// Go Right
				setTargetPosition(characterID.x + 50, characterID.y);
			}
		}
		
		// Determine which direction we need to walk in
		var walkDirection = sign(targetPositionX - characterID.x);
		
		// Floor collision check
		with (characterID)
		{
			// If our next position would make us close to walking over a pit in front of us, stop moving.
			if (!place_meeting(x + (other.platformWalkoffThreshold * walkDirection), y + 8, oCollisionParent))
			{
				// note, we are using the walkspeed of the enemy so that we can be the most accurate.
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
			// Clear inputs
			controllerID.buttonLeft = false;
			controllerID.buttonRight = false;
		}
		
		// After some time has passed, go back to the idle state.
		if (AIEventTimer >= currentWalkDuration)
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
	
	case eAIState.JUMP :
	{
		controllerID.buttonUp = true;
		
		
		if (AIEventTimer == 20)
		{
			//controllerID.buttonMedium = true;
		}
		else
		{
			controllerID.buttonMedium = false;
		}
		
		// Once we land, go back to idle
		if (AIEventTimer >= 10 && characterID.grounded)
		{
			// Set the state
			AIState = eAIState.IDLE;
			
			// Reset event timers
			AIEventTimer = 0;
			
			controllerID.buttonUp = false;
			controllerID.buttonLeft = false;
			controllerID.buttonRight = false;
			controllerID.buttonMedium = false;
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



