/// @description Insert description here
// You can write your code in this editor
if (global.toggleHitboxVisibility)
{
	draw_set_alpha(.5);
	draw_set_color(c_black);
	draw_rectangle(90, 390, 150, 500, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	draw_text(100, 400, AIState);
	draw_text(100, 410, comboStep);
	draw_text(100, 420, currentComboRoute);
	//draw_text(20, 30, animTimer);
	//draw_text(20, 50, gravityScaling);
	//draw_text(20, 70, comboScaling);
	//draw_text(20, 90, controllerSlot);

}

