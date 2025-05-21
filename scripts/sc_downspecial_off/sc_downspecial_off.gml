// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SC_DownSpecial_OFF()
{
	if (hostObject.animTimer == 1)
	{
		// away
		if (hostObject.movedir == sign(hostObject.image_xscale))
		{
			x = hostObject.x + 90 * sign(hostObject.image_xscale);
		}
		else if (hostObject.movedir == -sign(hostObject.image_xscale))
		{
			x = hostObject.x + 25 * sign(hostObject.image_xscale);
		}
	}
}