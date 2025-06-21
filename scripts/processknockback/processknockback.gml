// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ProcessKnockback()
{
	if (knockbackVel != 0)
	{
		environmentDisplacement = (-2 * ( knockbackVelTimer / sqr(knockbackVelDuration) ) + (2 / knockbackVelDuration)) * knockbackVel * -sign(image_xscale);
		
		knockbackVelTimer++;
	}
			
	if (knockbackVelTimer >= knockbackVelDuration)
	{
		knockbackVel = 0;
		knockbackTimer = 0;
	}
}