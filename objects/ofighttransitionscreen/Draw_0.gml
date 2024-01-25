/// @description Insert description here
// You can write your code in this editor


draw_self()

// Draw the character portaits
if (transitionTimer >= portaits_StartMoving)
{
	draw_sprite(p1Portait, 0, p1CharacterPortait_x, p1CharacterPortait_y);
	draw_sprite(p2Portait, 0, p2CharacterPortait_x, p2CharacterPortait_y);
}

