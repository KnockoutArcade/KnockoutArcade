/// @description Insert description here
// You can write your code in this editor

if (global.game_paused)
{
	exit;
}

event_inherited();

if (hitstun != 0)
{
	canSpawnHitboxes = true;
}

// If we have been hit by the player who spawned this, create a hitbox
if (variable_struct_exists(hasBeenHitByIds, string(playerOwner.id)) && ds_list_size(hitboxID) <= 0 && canSpawnHitboxes)
{
	hasSpawnedHitboxes = false;
	
	PerformProjectile(id, spiritOwner);
	
	show_debug_message("Spawned a hitbox");
}

// If the opponent has hit this object, prompt the removal of hitboxes
var _hasBeenHitBy = variable_struct_get_names(hasBeenHitByIds);
if (array_length(_hasBeenHitBy) > 0)
{
	if (!variable_struct_exists(hasBeenHitByIds, string(playerOwner.id)))
	{
		isHitByOpponent = true;
	}
}


if (hasHitSomething || (hsp == 0 && vsp == 0) || isHitByOpponent)
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

gravityScaling = 0;

duration--;

if (duration <= 0)
{
	instance_destroy(hurtbox);
	instance_destroy();
}