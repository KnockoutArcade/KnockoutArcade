/// @description Insert description here
// You can write your code in this editor

if (lifetime < 1)
{
	instance_destroy();
}

lifetime--;
image_xscale += 8;
image_yscale += 8;