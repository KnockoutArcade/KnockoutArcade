/// @description Insert description here
// You can write your code in this editor

draw_set_alpha(.5);
draw_set_color(c_black);
draw_rectangle(55, 0, 105, 100, false);
draw_set_alpha(1);
draw_set_color(c_white);
	
draw_text(75, 10, spiritState);
draw_text(75, 30, animTimer);
draw_text(75, 50, hostObject.id);
//draw_text(20, 70, meterPenalty);
//draw_text(20, 90, spiritObject);


