/// @description Insert description here
// You can write your code in this editor
if (global.toggleHitboxVisibility)
{
	if (controllerID != noone)
	{
		draw_text(20, 110, controllerID.buttonLight);
	}

if (playerID == 1)
{
	draw_set_alpha(.5);
	draw_set_color(c_black);
	draw_rectangle(10, 0, 50, 100, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	draw_text(20, 10, state);
	draw_text(20, 30, grounded);
	draw_text(20, 50, animTimer);
	draw_text(20, 70, coinScore);
	draw_text(20, 90, storedComboDamage);
} 
else 
{
	draw_set_alpha(.5);
	draw_set_color(c_black);
	draw_rectangle(740, 0, 800, 100, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	draw_text(750, 10, state);
	draw_text(750, 30, grounded);
	draw_text(750, 50, animTimer);
	draw_text(750, 70, storedComboDamage);
	draw_text(750, 90, y);
	
	
}

	if (hitstun > 0)
	{
		draw_text(400, 550, "TRUE COMBO");
	}
}
