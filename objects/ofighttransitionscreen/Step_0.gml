/// @description Insert description here
// You can write your code in this editor

transitionTimer++;

// Terminate
if (transitionTimer >= transitionLength)
{
	instance_destroy();
}

// Loop lightning animation
if (image_index >= image_number - 1)
{
	image_index = 14;
}

// start making the KO layers move in
if (transitionTimer > transitionKOText_StartScrolling && transitionTimer < transitionKOText_EndScrolling)
{
	// Make the bottom layer move up by 1 pixel per frame
	layer_y(transitionKOText_bottom, layer_get_y(transitionKOText_bottom) - 1);
	
	// make the top layer move down by 1 pixel per frame
	layer_y(transitionKOText_top, layer_get_y(transitionKOText_top) + 1);
}