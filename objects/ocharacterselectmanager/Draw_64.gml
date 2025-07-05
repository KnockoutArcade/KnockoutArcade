/// @description Insert description here
// You can write your code in this editor

// Debug stuff

draw_set_alpha(.5);
draw_set_color(c_black);
draw_rectangle(10, 0, 50, 100, false);
draw_set_alpha(1);
draw_set_color(c_white);
	
draw_text(20, 10, P1hasSelectedAlt);
draw_text(20, 30, P1hasSelectedChar);
draw_text(20, 50, P2hasSelectedAlt);
draw_text(20, 70, P2hasSelectedChar);
draw_text(20, 90, ds_list_size(oControllerManager.controllerUpdateNotifyList));