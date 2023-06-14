/// @description Insert description here
// You can write your code in this editor

if (!initialized)
{
	image_alpha = startingOpacity;
}
else 
{
	// Fade the sprite
	if (!global.freezeTimer)
	{
		image_alpha = clamp(image_alpha - fadeSpeed, 0, 1);
	}
	
	// Destroy the sprite once completely invisible
	if (image_alpha <= 0)
	{
		instance_destroy();
	}
}