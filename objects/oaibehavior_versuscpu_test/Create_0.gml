/// @description Insert description here
// You can write your code in this editor

event_inherited();

randomDelayTimer = irandom_range(0, 60);

reactTimer = 0;
reactionTime = 15;

willReactToGrab = irandom_range(0,1);

willRun = false;
willJump = false;

// What moves to use for pressuring the opponent
// [direction, attack, weight (probability), condition()]
pressureAttacks = [
[5, 1, 50],[2, 1, 50],
[5, 2, 30],[2, 2, 30],[6, 2, 20],
[2, 3, 30],
[5, 4, 20],[2, 4, 20],
[6, 5, 30],[4, 5, 30]
];

pokeAttacks = [
[5, 2, 50], [8, 2, 20],
[5, 3, 40], [2, 3, 10],
[6, 4, 40], [5, 4, 20]
];

function CPUTransitionToAdvance()
{
	AIState = eAIState.ADVANCE;
	randomDelayTimer = irandom_range(15, 45);
				
	willRun = false;
	willJump = false;
				
	if (irandom_range(0, 9) <= 2)
	{
		willRun = true;
	}
	if (irandom_range(0, 9) <= 3)
	{
		willJump = true;
	}
}

function CPUTransitionToRetreat()
{
	AIState = eAIState.RETREAT;
	randomDelayTimer = irandom_range(6, 30);
				
	willRun = false;
	willJump = false;
				
	if (irandom_range(0, 9) <= 3)
	{
		willRun = true;
	}
	if (irandom_range(0, 9) <= 2)
	{
		willJump = true;
	}
}

function CPUChooseAttack(attackSet)
{
	var totalWeight = 0;
	var runningTotal = 0;
	var attackDir = 0;
	var attackMove = 0;
	var distanceFromPlayer = opponent.x - characterID.x;
	
	for (var i = 0; i < array_length(attackSet); i++)
	{
		totalWeight += attackSet[i][2];
	}
	
	var rng = irandom(totalWeight);
	
	for (var j = 0; j < array_length(attackSet); j++)
	{
		runningTotal += attackSet[j][2];
		
		if (rng <= runningTotal)
		{
			attackDir = attackSet[j][0];
			attackMove = attackSet[j][1];
			break;
		}
	}
	
	// Handle attack direction
	if (attackDir == 1 || attackDir == 4 || attackDir == 7)
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
		
		if (attackDir == 1) controllerID.buttonDown = true;
		else if (attackDir == 7) controllerID.buttonUp = true;
	}
	else if (attackDir == 2)
	{
		controllerID.buttonDown = true;
	}
	else if (attackDir == 8)
	{
		controllerID.buttonUp = true;
	}
	if (attackDir == 3 || attackDir == 6 || attackDir == 9)
	{
		if (sign(distanceFromPlayer) == -1)
		{
			controllerID.buttonLeft = true;
			controllerID.buttonRight = false;
		}
		else
		{
			controllerID.buttonLeft = false;
			controllerID.buttonRight = true;
		}
		
		if (attackDir == 3) controllerID.buttonDown = true;
		else if (attackDir == 9) controllerID.buttonUp = true;
	}
	
	// Handle attack input
	if (attackMove == 1)
	{
		controllerID.buttonLight = true;
	}
	else if (attackMove == 2)
	{
		controllerID.buttonMedium = true;
	}
	else if (attackMove == 3)
	{
		controllerID.buttonHeavy = true;
	}
	else if (attackMove == 4)
	{
		controllerID.buttonSpecial = true;
	}
	else if (attackMove == 5)
	{
		controllerID.buttonGrab = true;
	}
	else if (attackMove == 6)
	{
		controllerID.buttonSuper = true;
	}
}