// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ProcessPushback()
{
	if (pushbackVel != 0)
	{
		pushbackVelTimer++;
		
		var pushbackdistance = log10((9/pushbackVelDuration) * pushbackVelTimer + 1) - log10((9/pushbackVelDuration) * (pushbackVelTimer - 1) + 1)
		
		environmentDisplacement = pushbackdistance * pushbackVel * -sign(image_xscale);
	}
			
	if (pushbackVelTimer >= pushbackVelDuration)
	{
		pushbackVel = 0;
		pushbackVelTimer = 0;
	}
}