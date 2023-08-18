// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CheckChange(Move)
{
	var canChange = false;
	if (animTimer > Move.SpecialData[0].TransitionFrame)
	{
		canChange = true;
	}
	
	return canChange;
}