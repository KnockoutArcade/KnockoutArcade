/// @description Insert description here
// You can write your code in this editor

// Reset controller inputs
controllerID.buttonLeft = false;
controllerID.buttonRight = false;
controllerID.buttonUp = false;
controllerID.buttonDown = false;

controllerID.buttonLight = false;
controllerID.buttonMedium = false;
controllerID.buttonHeavy = false;
controllerID.buttonSpecial = false;
controllerID.buttonGrab = false;
controllerID.buttonSuper = false;
controllerID.buttonRun = false;

if (characterID.isInCutscene || global.game_paused)
{
	exit;
}

// Calculate distance from player (can be negative)
var distanceFromPlayer = opponent.x - characterID.x;

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
	controllerID.buttonLight = false;
			
	// Reset Timer
	AIEventTimer = 0;
}

switch (AIState)
{
	case (eAIState.IDLE):
	{
		controllerID.buttonDown = true;
		
		if (!opponent.grounded && abs(distanceFromPlayer) <= 45)
		{
			reactTimer++;
			
			if (reactTimer >= reactionTime)
			{
				controllerID.buttonDown = false;
			}
		}
		else
		{
			reactTimer = 0;
		}
		
		if (sign(distanceFromPlayer) == 1)
		{
			controllerID.buttonLeft = true;
			controllerID.buttonRight = false;
		}
		else
		{
			controllerID.buttonLeft = false;
			controllerID.buttonRight = true;
		}
		
		if (opponent.state == eState.GRAB && willReactToGrab && abs(distanceFromPlayer) <= 30)
		{
			controllerID.buttonGrab = true;
			willReactToGrab = irandom_range(0,1);
		}
		
		#region State Transition
		
		if (AIEventTimer >= randomDelayTimer)
		{
			AIEventTimer = 0;
			
			var chooseNextState = irandom_range(0, 99);
			
			if (chooseNextState < 5)
			{
				AIState = eAIState.WAIT;
				randomDelayTimer = irandom_range(10,30);
			}
			else if (chooseNextState < 40)
			{
				CPUTransitionToAdvance();
			}
			else if (chooseNextState < 60)
			{
				CPUTransitionToRetreat();
			}
			else if ((abs(distanceFromPlayer) <= 30) && chooseNextState < 95)
			{
				AIState = eAIState.PRESSURE;
				randomDelayTimer = irandom_range(0, 100);
				AIEventTimer = 0;
			}
			else if (chooseNextState < 95)
			{
				AIState = eAIState.POKE;
				randomDelayTimer = irandom_range(0, 100);
				AIEventTimer = 0;
			}
			else
			{
				randomDelayTimer = irandom_range(0, 10);
			}
		}
		
		#endregion
	}
	break;
	
	case (eAIState.ADVANCE):
	{
		if (sign(distanceFromPlayer) == 1)
		{
			controllerID.buttonLeft = false;
			controllerID.buttonRight = true;
		}
		else
		{
			controllerID.buttonLeft = true;
			controllerID.buttonRight = false;
		}
		
		if (willRun)
		{
			controllerID.buttonRun = true;
		}
		
		if (willJump)
		{
			controllerID.buttonUp = true;
		}
		
		if (abs(distanceFromPlayer) <= 28)
		{
			AIState = eAIState.PRESSURE;
			randomDelayTimer = irandom_range(0, 100);
			AIEventTimer = 0;
		}
		
		if (AIEventTimer >= randomDelayTimer)
		{
			AIEventTimer = 0;
			
			var chooseNextState = irandom_range(0, 99);
			
			if (chooseNextState < 25)
			{
				CPUTransitionToRetreat();
			}
			else if (chooseNextState < 80)
			{
				AIState = eAIState.POKE;
				randomDelayTimer = irandom_range(0, 100);
				AIEventTimer = 0;
			}
			else
			{
				AIState = eAIState.IDLE;
				randomDelayTimer = irandom_range(0, 25);
			}
		}
	}
	break;
	
	case (eAIState.RETREAT):
	{
		if (sign(distanceFromPlayer) == 1)
		{
			controllerID.buttonLeft = true;
			controllerID.buttonRight = false;
		}
		else
		{
			controllerID.buttonLeft = false;
			controllerID.buttonRight = true;
		}
		
		if (willRun && AIEventTimer <= 1)
		{
			controllerID.buttonRun = true;
		}
		
		if (willJump)
		{
			controllerID.buttonUp = true;
		}
		
		if (abs(distanceFromPlayer) <= 28)
		{
			AIState = eAIState.PRESSURE;
			randomDelayTimer = irandom_range(0, 100);
			AIEventTimer = 0;
		}
		
		if (AIEventTimer >= randomDelayTimer)
		{
			AIEventTimer = 0;
			
			var chooseNextState = irandom_range(0, 99);
			
			if (chooseNextState < 25)
			{
				CPUTransitionToAdvance();
			}
			else if (chooseNextState < 80)
			{
				AIState = eAIState.POKE;
				randomDelayTimer = irandom_range(0, 100);
				AIEventTimer = 0;
			}
			else
			{
				AIState = eAIState.IDLE;
				randomDelayTimer = irandom_range(0, 25);
			}
		}
	}
	break;
	
	case (eAIState.PRESSURE):
	{
		if (AIEventTimer <= 1)
		{
			CPUChooseAttack(pressureAttacks);
		}
		else if (!characterID.inAttackState)
		{
			AIEventTimer = 0;
			
			var chooseNextState = irandom_range(0, 99);
			
			if (chooseNextState < 10)
			{
				CPUTransitionToRetreat();
			}
			else if (chooseNextState < 20)
			{
				AIState = eAIState.IDLE;
				randomDelayTimer = irandom_range(0, 25);
				AIEventTimer = 0;
				willRun = false;
				willJump = false;
			}
			else if (abs(distanceFromPlayer) > 28)
			{
				CPUTransitionToAdvance();
			}
		}
		
	}
	break;
	
	case (eAIState.POKE):
	{
		if (AIEventTimer <= 1)
		{
			CPUChooseAttack(pokeAttacks);
		}
		else if (!characterID.inAttackState)
		{
			AIEventTimer = 0;
			
			var chooseNextState = irandom_range(0, 99);
			
			if (chooseNextState < 40)
			{
				CPUTransitionToRetreat();
			}
			else if (chooseNextState < 50)
			{
				AIState = eAIState.IDLE;
				randomDelayTimer = irandom_range(0, 25);
				AIEventTimer = 0;
				willRun = false;
				willJump = false;
			}
			else if (abs(distanceFromPlayer) > 28)
			{
				CPUTransitionToAdvance();
			}
			else
			{
				AIState = eAIState.PRESSURE;
				randomDelayTimer = irandom_range(0, 100);
				AIEventTimer = 0;
			}
		}
	}
	break;
	
	case (eAIState.WAIT):
	{
		if (AIEventTimer >= randomDelayTimer)
		{
			AIState = eAIState.IDLE;
			randomDelayTimer = irandom_range(0, 25);
			AIEventTimer = 0;
			willRun = false;
			willJump = false;
		}
	}
	break;
	
	case (eAIState.HURT):
	{
		// Return to Walk once we've recovered
		if (characterID.state == eState.IDLE)
		{
			// Set the state
			AIState = eAIState.IDLE;
			
			// Reset event timers
			AIEventTimer = 0;
			
			// Update getting grabbed
			willReactToGrab = irandom_range(0,1);
			willRun = false;
			willJump = false;
		}
	}
	break;
	
	default: 
	{
		AIState = eAIState.IDLE;
		randomDelayTimer = irandom_range(0, 60);
		AIEventTimer = 0;
		willRun = false;
		willJump = false;
	}
	break;
}


