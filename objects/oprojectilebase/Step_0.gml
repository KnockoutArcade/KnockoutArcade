/// @description Insert description here
// You can write your code in this editor

if (global.game_paused)
{
	exit;
}

if (!global.gameHalt && !global.freezeTimer && !canDestroySprite)
{
	animTimer++;
	
	if (hasLifetime)
	{
		lifetime--;
	}
	
	PerformProjectile(playerOwner, spiritOwner);
	
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
	
	#region // Handle Destroy
	if (place_meeting(x+(hsp * image_xscale), y, oWall))
	{
		if (destroyOnWall && numberOfBounces == 0)
		{
			for (var i = 0; i < ds_list_size(hitboxID); i++)
			{
				with (ds_list_find_value(hitboxID, i))
				{
					lifetime = 0;
				}
			}
			ds_list_clear(hitboxID);
			if (destroySprite != -1)
			{
				sprite_index = destroySprite;
				image_index = 0;
			}
			canDestroySprite = true;
		}
		else if (bounceOnWall)
		{
			numberOfBounces--;
			
			image_xscale = -image_xscale;
			
			for (var i = 0; i < ds_list_size(hitboxID); i++)
			{
				with (ds_list_find_value(hitboxID, i))
				{
					image_xscale *= -1;
				}
			}
		}
	}
	
	if (place_meeting(x, y+vsp, oWall))
	{
		if (destroyOnFloor && numberOfBounces == 0)
		{
			for (var i = 0; i < ds_list_size(hitboxID); i++)
			{
				with (ds_list_find_value(hitboxID, i))
				{
					lifetime = 0;
				}
			}
			ds_list_clear(hitboxID);
			if (destroySprite != -1)
			{
				sprite_index = destroySprite;
				image_index = 0;
			}
			canDestroySprite = true;
		}
		else if (bounceOnFloor)
		{
			vsp = -vsp * bounciness;
			
			numberOfBounces--;
		}
	}
	
	if (projectileHealth == 0)
	{
		for (var i = 0; i < ds_list_size(hitboxID); i++)
		{
			with (ds_list_find_value(hitboxID, i))
			{
				lifetime = 0;
			}
		}
		ds_list_clear(hitboxID);
		if (destroySprite != -1)
		{
			sprite_index = destroySprite;
			image_index = 0;
		}
		canDestroySprite = true;
	}
	
	if (place_meeting(x + (hsp * image_xscale), y, oProjectileBase) && !transcendent)
	{
		var collisionID = instance_place(x + (hsp * image_xscale), y, oProjectileBase);
		
		with (collisionID)
		{
			collidedWithProjectile = true;
		}
		
		collidedWithProjectile = true;
	}
	
	if (collidedWithProjectile)
	{
		for (var i = 0; i < ds_list_size(hitboxID); i++)
		{
			with (ds_list_find_value(hitboxID, i))
			{
				lifetime = 0;
			}
		}
		ds_list_clear(hitboxID);
		if (destroySprite != -1)
		{
			sprite_index = destroySprite;
			image_index = 0;
		}
		canDestroySprite = true;
	}
	
	if (lifetime == 0 && hasLifetime)
	{
		for (var i = 0; i < ds_list_size(hitboxID); i++)
		{
			with (ds_list_find_value(hitboxID, i))
			{
				lifetime = 0;
			}
		}
		ds_list_clear(hitboxID);
		if (destroySprite != -1)
		{
			sprite_index = destroySprite;
			image_index = 0;
		}
		canDestroySprite = true;
	}
	
	#endregion
	
	x += hsp * image_xscale;
	y += vsp;
}
else if (!global.gameHalt && !global.freezeTimer && canDestroySprite)
{
	if (image_index > (image_number - 1)) 
	{
		instance_destroy();
	}
}