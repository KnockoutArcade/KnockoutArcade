/// @description Insert description here
// You can write your code in this editor

if (global.game_paused)
{
	exit;
}

if (!global.gameHalt)
{
	lifetime--;
	
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
			if (hitboxID != noone)
			{
				instance_destroy(hitboxID);
			}
			instance_destroy();
		}
		else if (bounceOnWall)
		{
			numberOfBounces--;
			
			image_xscale = -image_xscale;
			
			hitboxID.image_xscale *= -1;
		}
	}
	
	if (place_meeting(x, y+vsp, oWall))
	{
		if (destroyOnFloor && numberOfBounces == 0)
		{
			if (hitboxID != noone)
			{
				instance_destroy(hitboxID);
			}
			instance_destroy();
		}
		else if (bounceOnFloor)
		{
			vsp = -vsp * bounciness;
			
			numberOfBounces--;
		}
	}
	
	if (projectileHealth == 0)
	{
		if (hitboxID != noone)
		{
			instance_destroy(hitboxID);
		}
		instance_destroy();
	}
	
	if (place_meeting(x + (hsp * image_xscale), y, oProjectileBase) && !transcendent)
	{
		var collisionID = instance_place(x + (hsp * image_xscale), y, oProjectileBase);
		
		with collisionID
		{
			collidedWithProjectile = true;
		}
		
		collidedWithProjectile = true;
	}
	
	if (collidedWithProjectile)
	{
		if (hitboxID != noone)
		{
			instance_destroy(hitboxID);
		}
		instance_destroy();
	}
	
	if (lifetime == 0)
	{
		if (hitboxID != noone)
		{
			instance_destroy(hitboxID);
		}
		instance_destroy();
	}
	
	#endregion
	
	x += hsp * image_xscale;
	y += vsp;
}
