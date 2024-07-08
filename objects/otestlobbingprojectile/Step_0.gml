/// @description Insert description here
// You can write your code in this editor

event_inherited();

if (global.game_paused)
{
	exit;
}

// Make the fireball point in the direction of its velocity
image_angle = point_direction(0, 0, hsp, vsp * image_xscale);

image_speed = 1;