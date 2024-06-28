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
	draw_text(20, 30, combo);
	draw_text(20, 50, storedComboDamage);
	draw_text(20, 70, target);
	draw_text(20, 90, ds_list_size(objectsHitList));
	
	var hitByIDs = variable_struct_get_names(hasBeenHitByIds);
			
	for (var j = 0; j < array_length(hitByIDs); j++)
	{
	   for (var k = 0; k < ds_list_size(hasBeenHitByIds[$ hitByIDs[j]]); k++;)
	   {
			draw_text(20 + (20 * k), 110 + (20 * j), hasBeenHitByIds[$ hitByIDs[j]][| k]);
	   }
	}
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
	draw_text(750, 50, canBlock);
	draw_text(750, 70, hitstop);
	draw_text(750, 90, comboScaling);
	
	
}

	if (hitstun > 0)
	{
		draw_text(400, 550, "TRUE COMBO");
	}
}
