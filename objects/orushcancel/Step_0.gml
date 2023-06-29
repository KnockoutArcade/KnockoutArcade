/// @description Insert description here
// You can write your code in this editor

image_xscale += 0.4;
image_yscale += 0.4;

fadeTimer++;
if (fadeTimer >= 10)
{
	// Fade the sprite
	image_alpha = clamp(image_alpha - 0.1, 0, 1);
	
	// Destroy the sprite once completely invisible
	if (image_alpha <= 0)
	{
		instance_destroy();
	}
}