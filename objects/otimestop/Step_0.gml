/// @description Insert description here
// You can write your code in this editor

if (owner != noone)
{
	image_xscale += 1;
	image_yscale += 1;
	image_alpha = 1;
}
else
{
	image_alpha -= 0.05;
	if (image_alpha <= 0)
	{
		instance_destroy();
	}
}