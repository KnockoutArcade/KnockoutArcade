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
