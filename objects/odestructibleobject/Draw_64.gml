/// @description Insert description here
// You can write your code in this editor

draw_set_alpha(.5);
draw_set_color(c_black);
draw_rectangle(740, 0, 800, 100, false);
draw_set_alpha(1);
draw_set_color(c_white);
	
//draw_text(750, 10, duration);
draw_text(750, 30, ds_list_size(hitByGroup));
draw_text(750, 50, state);
//draw_text(750, 70, grounded);
//draw_text(750, 90, comboScaling);


