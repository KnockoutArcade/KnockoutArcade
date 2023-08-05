/// @description Insert description here
// You can write your code in this editor

if (lifetimeSet)
{
	if (lifetime <= 0)
	{
		instance_destroy();
	}
	else
	{
		image_xscale += 1;
		image_yscale += 1;
		
		if (lifetime <= 50)
		{
			image_alpha -= 0.02;
		}
		
		lifetime--;
	}
}