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
			var decideWalkOrAttack = irandom_range(0, 12);
			
			//show_debug_message(decideWalkOrAttack);
			
			// 12/15 chance to choose jumping
			if (decideWalkOrAttack < 13)
			{
				// Set the state
				AIState = eAIState.JUMP;
				
				controllerID.buttonUp = true;
		
				// Reset event timers
				AIEventTimer = 0;
				
				// determine which way to jump
				walkDirection = sign(characterID.opponent.x - characterID.x);
				show_debug_message(walkDirection);
				
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
				AIState = eAIState.ATTACK;
		
				// Reset event timers
				AIEventTimer = 0;
				
				// Set the attack substate to 0
				attackSubstate = 0;
				
				// Make sure this enemy can't attack twice in a row.
				hasJustAttacked = true;
			}
		}
		
	}
	break;
	
	case eAIState.WALK :
	{
		// Determine where we need to go (refresh every 5 frames)
		// In this case, our target is some distance away from the player (based on the direction this is facing)
		//if (AIEventTimer mod 5 == 0)
		//{
		//	setTargetPosition(opponent.x + ((idealRangeFromPlayer + idealRangeChosenVariation)) * -sign(characterID.image_xscale), characterID.y);
		//}
		
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



