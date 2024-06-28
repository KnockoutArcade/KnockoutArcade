/// @description Insert description here
// You can write your code in this editor

if (global.game_paused)
{
	exit;
}

if (hitstop <= 0 && hasHitSomething)
{
	// With each of the things we've collided with, clear it's projectileHitBy list
	for (var i = 0; i < ds_list_size(collidedWithProjectileList); i++;)
	{
		var objectToSearchFor = ds_list_find_value(collidedWithProjectileList, i);
			
		if (variable_instance_exists(objectToSearchFor, "projectileHitByGroup"))
		{
			ds_list_clear(objectToSearchFor.projectileHitByGroup);
		}
	}
		
	// With all our hitboxes, destroy them
	for (var i = 0; i < ds_list_size(hitboxID); i++)
	{
		with (ds_list_find_value(hitboxID, i))
		{
			ds_list_clear(hasHit);
			
			instance_destroy();
		}
	}
	ds_list_clear(hitboxID);
		
	// reset collision Lists
	ds_list_clear(collidedWithProjectileList);
	ds_list_clear(processedWithProjectileList);
	
	hasHitSomething = false;
}

event_inherited();

PerformProjectile(id, spiritOwner);

gravityScaling = 0;

duration--;

if (duration <= 0)
{
	instance_destroy(hurtbox);
	instance_destroy();
}