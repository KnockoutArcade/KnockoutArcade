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
	draw_text(20, 30, animTimer);
	draw_text(20, 50, storedComboDamage);
	draw_text(20, 70, downUpChargeTimer);
	draw_text(20, 90, chargePartitionTimer);
	
} 
else 
{
	draw_set_alpha(.5);
	draw_set_color(c_black);
	draw_rectangle(740, 0, 800, 100, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	draw_text(750, 10, state);
	draw_text(750, 30, animTimer);
	draw_text(750, 50, hsp);
	draw_text(750, 70, comboScaling);
	draw_text(750, 90, ds_list_size(projectileHitByGroup));
	
	
}

	if (hitstun > 0)
	{
		draw_text(400, 550, "TRUE COMBO");
	}
}
