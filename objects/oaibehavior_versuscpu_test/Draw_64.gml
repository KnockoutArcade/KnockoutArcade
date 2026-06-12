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
	
	#region Draw direction inputs
	
	draw_set_color(c_dkgrey);
	if (controllerID.buttonLeft) draw_set_color(c_white);
	draw_rectangle(100, 480, 110, 490, false);
	
	draw_set_color(c_dkgrey);
	if (controllerID.buttonRight) draw_set_color(c_white);
	draw_rectangle(130, 480, 140, 490, false);
	
	draw_set_color(c_dkgrey);
	if (controllerID.buttonUp) draw_set_color(c_white);
	draw_rectangle(115, 465, 125, 475, false);
	
	draw_set_color(c_dkgrey);
	if (controllerID.buttonDown) draw_set_color(c_white);
	draw_rectangle(115, 495, 125, 505, false);
	
	#endregion
	
	draw_set_color(c_dkgrey);
	if (controllerID.buttonLight) draw_set_color(c_white);
	draw_circle(150, 480, 5, false);
	
	draw_set_color(c_dkgrey);
	if (controllerID.buttonMedium) draw_set_color(c_white);
	draw_circle(165, 480, 5, false);
	
	draw_set_color(c_dkgrey);
	if (controllerID.buttonSpecial) draw_set_color(c_white);
	draw_circle(150, 495, 5, false);
	
	draw_set_color(c_dkgrey);
	if (controllerID.buttonHeavy) draw_set_color(c_white);
	draw_circle(165, 495, 5, false);
	
	draw_set_color(c_dkgrey);
	if (controllerID.buttonGrab) draw_set_color(c_white);
	draw_circle(180, 480, 5, false);
	
	draw_set_color(c_dkgrey);
	if (controllerID.buttonRun) draw_set_color(c_white);
	draw_circle(180, 495, 5, false);
	
	draw_set_color(c_dkgrey);
	if (controllerID.buttonSuper) draw_set_color(c_white);
	draw_circle(195, 480, 5, false);
}

