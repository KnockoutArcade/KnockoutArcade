/// @description Insert description here
// You can write your code in this editor

// We need to resolve hitstop before the main step event in order for collisions to work
if (!global.game_paused && !global.gameHalt && !global.freezeTimer)
{
	hitstopTimer--;
	
	if (hitstopTimer <= 0)
	{
		animTimer++;
	
		if (hasLifetime)
		{
			lifetime--;
		}
		
		// Calculate Traction
		if (grounded)
		{
			if (abs(hsp) - groundTraction >= 0)
			{
				hsp += groundTraction * -sign(hsp);
			}
			else
			{
				hsp = 0;
			}
		}
		else
		{
			if (abs(hsp) - airTraction >= 0)
			{
				hsp += airTraction * -sign(hsp);
			}
			else
			{
				hsp = 0;
			}
		}
		
		// Calculate Gravity
		vsp += fallSpeed;
		
		// With each of the things we've collided with, clear it's projectileHitBy list
		for (var i = 0; i < ds_list_size(collidedWithProjectileList); i++;)
		{
			var objectToSearchFor = ds_list_find_value(collidedWithProjectileList, i);
			
			if (variable_instance_exists(objectToSearchFor, "projectileHitByGroup"))
			{
				ds_list_clear(objectToSearchFor.projectileHitByGroup);
			}
		}
		
		// With all our hitboxes, clear out their hasHit lists
		for (var i = 0; i < ds_list_size(hitboxID); i++)
		{
			with (ds_list_find_value(hitboxID, i))
			{
				ds_list_clear(hasHit);
			}
		}
		
		// reset collision Lists
		ds_list_clear(collidedWithProjectileList);
		ds_list_clear(processedWithProjectileList);
		
		
		
		image_speed = 1;
		
		hitstopTimer = 0;
	}
	else
	{
		image_speed = 0;
	}
}
