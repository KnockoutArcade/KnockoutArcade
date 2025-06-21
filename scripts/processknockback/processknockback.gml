// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ProcessKnockback()
{
	if (knockbackVel != 0)
	{
		knockbackVelTimer++;
		
		var knockbackdistance = log10((9/knockbackVelDuration) * knockbackVelTimer + 1) - log10((9/knockbackVelDuration) * (knockbackVelTimer - 1) + 1)
		
		environmentDisplacement = knockbackdistance * knockbackVel * -sign(image_xscale);
	}
			
	if (knockbackVelTimer >= knockbackVelDuration)
	{
		knockbackVel = 0;
		knockbackVelTimer = 0;
	}
}