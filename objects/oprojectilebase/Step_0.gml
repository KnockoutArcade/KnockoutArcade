/// @description Insert description here
// You can write your code in this editor

if (global.game_paused)
{
	exit;
}

if (!global.gameHalt && !global.freezeTimer)
{
	
	if (hitstopTimer <= 0)
	{
		PerformProjectile(playerOwner, spiritOwner);
	}
	
	
	#region // Handle Destroy
	
	var previousAngle = image_angle;
	image_angle = 0;
	
	// Slopes
	if (place_meeting(x, y + vsp, oSlope) && sign(vsp) != -1)
	{
		if (destroyOnFloor && numberOfBounces <= 0)
		{
			destroyScript();
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
			destroyScript();
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
			destroyScript();
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
				destroyScript();
			}
			else if (bounceOnFloor)
			{
				vsp = -vsp * bounciness;
			
				numberOfBounces--;
			}
		}
	}
	
	// Collision with other projectiles
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
					projectileMeetingScript(other.id);
				}
			
				projectileMeetingScript(collisionID, true);
			}
		}
		else if (playerOwner != collisionID.playerOwner && spiritOwner != collisionID.spiritOwner)
		{
			with (collisionID)
			{
				projectileMeetingScript(other.id);
			}
			
			projectileMeetingScript(collisionID, true);
		}
	}
	
	// Lifetime Runs out
	if (lifetime == 0 && hasLifetime)
	{
		destroyScript();
	}
	
	image_angle = previousAngle;
	
	#endregion
	
	if (hitstopTimer <= 0)
	{
		x += hsp * image_xscale;
		y += vsp;
	}
	
}