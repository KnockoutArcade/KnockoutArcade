/// @description Insert description here
// You can write your code in this editor

image_xscale += 0.001;
image_yscale += 0.001;

// Fade the sprite
image_alpha = clamp(timer / 60, 0, 1);

timer--;
if (timer <= 0)
{
	instance_destroy();
}