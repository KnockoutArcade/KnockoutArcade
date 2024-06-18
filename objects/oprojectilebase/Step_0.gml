/// @description Insert description here
// You can write your code in this editor

if (global.game_paused)
{
	exit;
}

if (!global.gameHalt && !global.freezeTimer)
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
	
	var previousAngle = image_angle;
	image_angle = 0;
	
	// Slopes
	if (place_meeting(x, y + vsp, oSlope) && sign(vsp) != -1)
	{
		if (destroyOnFloor && numberOfBounces <= 0)
		{
			for (var i = 0; i < ds_list_size(hitboxID); i++)
			{
				with (ds_list_find_value(hitboxID, i))
				{
					lifetime = 0;
				}
			}
			ds_list_clear(hitboxID);
			if (target != noone)
			{
				ds_list_clear(target.hitByGroup);
			}
			instance_destroy();
		}
		else if (bounceOnFloor)
		{
			vsp = -vsp * bounciness;
			
			numberOfBounces--;
		}
	}
	
	// Wall Collision
	if (place_meeting(x+(hsp * image_xscale), y, oWall))
	{
		if (destroyOnWall && numberOfBounces <= 0)
		{
			for (var i = 0; i < ds_list_size(hitboxID); i++)
			{
				with (ds_list_find_value(hitboxID, i))
				{
					lifetime = 0;
				}
			}
			ds_list_clear(hitboxID);
			if (target != noone)
			{
				ds_list_clear(target.hitByGroup);
			}
			instance_destroy();
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
		if (destroyOnFloor && numberOfBounces <= 0)
		{
			for (var i = 0; i < ds_list_size(hitboxID); i++)
			{
				with (ds_list_find_value(hitboxID, i))
				{
					lifetime = 0;
				}
			}
			ds_list_clear(hitboxID);
			if (target != noone)
			{
				ds_list_clear(target.hitByGroup);
			}
			instance_destroy();
		}
		else if (bounceOnFloor)
		{
			vsp = -vsp * bounciness;
			
			numberOfBounces--;
		}
	}
	
	// SemiSolids
	if (place_meeting(x, y + vsp, oSemiSolid) && sign(vsp) != -1)
	{
		var semiSolid = instance_place(x, y + vsp, oSemiSolid)
		// Check if we're on the surface of the semiSolid
		if (floor(y) <= semiSolid.y)
		{
			if (destroyOnFloor && numberOfBounces <= 0)
			{
				for (var i = 0; i < ds_list_size(hitboxID); i++)
				{
					with (ds_list_find_value(hitboxID, i))
					{
						lifetime = 0;
					}
				}
				ds_list_clear(hitboxID);
				if (target != noone)
				{
					ds_list_clear(target.hitByGroup);
				}
				instance_destroy();
			}
			else if (bounceOnFloor)
			{
				vsp = -vsp * bounciness;
			
				numberOfBounces--;
			}
		}
	}
	
	
	if (projectileHealth <= 0)
	{
		for (var i = 0; i < ds_list_size(hitboxID); i++)
		{
			with (ds_list_find_value(hitboxID, i))
			{
				lifetime = 0;
			}
		}
		ds_list_clear(hitboxID);
		if (target != noone)
		{
			ds_list_clear(target.hitByGroup);
		}
		instance_destroy();
	}
	
	if (place_meeting(x + (hsp * image_xscale), y, oProjectileBase) && !transcendent)
	{
		var collisionID = instance_place(x + (hsp * image_xscale), y, oProjectileBase);
		
		// If the projectile has no spirit, then it doesn't need to worry about it's spirit owner
		if (spiritOwner == noone)
		{
			if (playerOwner != collisionID.playerOwner)
			{
				with (collisionID)
				{
					collidedWithProjectile = true;
				}
			
				collidedWithProjectile = true;
			}
		}
		else if (playerOwner != collisionID.playerOwner && spiritOwner != collisionID.spiritOwner)
		{
			with (collisionID)
			{
				collidedWithProjectile = true;
			}
			
			collidedWithProjectile = true;
		}
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
		if (target != noone)
		{
			ds_list_clear(target.hitByGroup);
		}
		instance_destroy();
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
		if (target != noone)
		{
			ds_list_clear(target.hitByGroup);
		}
		instance_destroy();
	}
	
	image_angle = previousAngle;
	
	#endregion
	
	x += hsp * image_xscale;
	y += vsp;
}