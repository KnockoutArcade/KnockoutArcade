/// @description Insert description here
// You can write your code in this editor

if (owner != noone)
{
	if (image_xscale < 8)
	{
		image_xscale += 1;
		image_yscale += 1;
	}
	image_alpha = 1;
}
else
{
	image_xscale -= 0.8;
	image_yscale -= 0.8;
	if (image_xscale <= 0)
	{
		instance_destroy();
	}
}