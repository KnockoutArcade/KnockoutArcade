/// @description Insert description here
// You can write your code in this editor

if (global.game_paused)
{
	exit;
}

// This object needs to run a copy of the oDestructibleObject Step event
event_perform_object(oDestructibleObject, ev_step, 0);

gravityScaling = 0;

// If the owner stops existing, exit
if (!instance_exists(playerOwner))
{
	playerOwner = noone;
}

if (hitstun != 0)
{
	canSpawnHitboxes = true;
}

// If we have been hit, create a hitbox
if (variable_struct_names_count(hasBeenHitByIds) > 0 && ds_list_size(hitboxID) <= 0 && canSpawnHitboxes)
{
	hasSpawnedHitboxes = false;
	playerOwner = mostRecentIDHitBy;
	
	show_debug_message(mostRecentIDHitBy);
	
	PerformProjectile(id, spiritOwner);
}


if (hsp == 0 && vsp == 0) || (playerOwner == noone)
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
	
	//ClearOwnerHitByGroups();
	
	hasHitSomething = false;
	canSpawnHitboxes = false;
	isHitByOpponent = false;
	hitstun = 0;
}



/*
duration--;

if (duration <= 0)
{
	instance_destroy(hurtbox);
	instance_destroy();
}	