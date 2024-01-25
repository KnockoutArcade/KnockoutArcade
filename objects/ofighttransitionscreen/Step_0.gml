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

// Start making the KO layers move in
if (transitionTimer > transitionKOText_StartScrolling && transitionTimer < transitionKOText_EndScrolling)
{
	// Make the bottom layer move up by 1 pixel per frame
	layer_y(transitionKOText_bottom, layer_get_y(transitionKOText_bottom) - 1);
	
	// make the top layer move down by 1 pixel per frame
	layer_y(transitionKOText_top, layer_get_y(transitionKOText_top) + 1);
}

// Move the portaits, names, and hint sheets
if (transitionTimer >= portaits_StartMoving && transitionTimer < portaits_EndMoving)
{
	p1CharacterPortait_x = lerp(p1CharacterPortait_x, p1CharacterPortait_EndingPosition[0], 0.1);
	p2CharacterPortait_x = lerp(p2CharacterPortait_x, p2CharacterPortait_EndingPosition[0], 0.1);
	
	p1PortaitName_x = lerp(p1PortaitName_x, p1PortaitName_EndingPosition[0], 0.1);
	p2PortaitName_x = lerp(p2PortaitName_x, p2PortaitName_EndingPosition[0], 0.1);
	
	p1HintSheet_y = lerp(p1HintSheet_y, p1HintSheet_EndingPosition[1], 0.1);
	p2HintSheet_y = lerp(p2HintSheet_y, p2HintSheet_EndingPosition[1], 0.1);
}