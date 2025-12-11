/// @description Insert description here
// You can write your code in this editor

// Handle blinking at low duration
if (duration <= 180 && duration > 60 && duration mod 10 <= 3 && hitstop <= 0)
{
	exit;
}
if (duration <= 60 && duration mod 4 <= 1 && hitstop <= 0)
{
	exit;
}

draw_self();

// Draw the collision box
//draw_rectangle_color(bbox_left, bbox_bottom, bbox_right, bbox_top, c_green, c_green, c_green, c_green, true);


