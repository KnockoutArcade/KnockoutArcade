/// @description Insert description here
// You can write your code in this editor

event_inherited();

randomDelayTimer = irandom_range(0, 60);

reactTimer = 0;
reactionTime = 15;

willReactToGrab = irandom_range(0,1);

willRun = false;
willJump = false;

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