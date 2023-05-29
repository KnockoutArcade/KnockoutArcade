// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function CheckChange(){
	var canChange = false;
	if (changeImmediately)
	{
		if (animTimer > changeFrame)
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
		if (animTimer > changeFrame)
		{
			canChange = true;
		}
	}
	
	return canChange;
}