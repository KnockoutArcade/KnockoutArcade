// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function CheckChange(Move){
	var canChange = false;
	if (Move.SpecialData[0].TransitionImmediately)
	{
		if (animTimer > Move.SpecialData[0].TransitionFrame)
		{
			if (target != noone)
			{
				if (framesSinceHitstun == 0)
				{
					canChange = true;
				}
			}
			else
			{
				canChange = true;
			}
		}
	}
	else
	{
		if (animTimer > Move.SpecialData[0].TransitionFrame)
		{
			canChange = true;
		}
	}
	
	return canChange;
}