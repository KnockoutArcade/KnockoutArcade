/// @description Insert description here
// You can write your code in this editor

if (global.game_paused)
{
	exit;
}

if (!global.gameHalt)
{
	if (place_meeting(x+(hsp * image_xscale), y, oWall))
	{
		if (hitboxID != noone)
		{
			instance_destroy(hitboxID);
		}
		instance_destroy();
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
		
		if (hitboxID != noone)
		{
			instance_destroy(hitboxID);
		}
		instance_destroy();
	}
	
	if (collidedWithProjectile)
	{
		if (hitboxID != noone)
		{
			instance_destroy(hitboxID);
		}
		instance_destroy();
	}
	
	x += hsp * image_xscale;
}
