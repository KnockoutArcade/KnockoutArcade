// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function JayDownSpecial_AirSlowdown()
{
	if (animTimer == 16 && !grounded)
	{
		jumpHsp *= 0.75;
		hsp *= 0.75;
	}
}