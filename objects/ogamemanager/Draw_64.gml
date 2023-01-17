/// @description Insert description here
// You can write your code in this editor

if global.toggleHitboxVisibility {
	draw_set_alpha(.5);
	draw_set_color(c_black);
	draw_rectangle(195, 195, 220, 220, false);
	draw_set_alpha(1);
	draw_set_color(c_white);

	draw_text(200, 200, frameAdvantage);
}