/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Trigger Opening
if (isOpened)
{
	image_speed = 1;
	
	// Stop animation if we are at the last frame
	if (image_index > (image_number - 1))
	{
		image_speed = 0;
	}
}