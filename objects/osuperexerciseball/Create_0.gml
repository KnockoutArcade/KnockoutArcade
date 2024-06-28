/// @description Insert description here
// You can write your code in this editor

// We can get the data of a projectile by getting the data from an index of projectileData. Since the index
// of each projectile may be different from build to build, I've set up this code that will iterate
// through each index to find the name of each index, with which we can use to access the correct
// projectile data
selectedProjectile = -1;
for (var i = 0; i < global.numberOfProjectiles; i++;)
{
	if (global.projectileData[i].Name == "BeverlySuperBall")
	{
		selectedProjectile = global.projectileData[i];
		break;
	}
}

event_inherited();

playerOwner = noone; // Who fired this projectile
spiritOwner = noone; // If spirit fired a projectile
target = noone; // The thing this projectile hit

// The properties of this attack
hitboxProperties = {};
hitboxProperties.NumberOfHitboxes = selectedProjectile.NumberOfHitboxes;
hitboxProperties.AttackProperty = selectedProjectile.AttackProperty;
hitboxProperties.CounterHitProperty = selectedProjectile.CounterHitProperty;
hitboxProperties.RehitData = selectedProjectile.RehitData;

hitboxID = ds_list_create(); // The IDs of this projectile's hitboxes

hasSpawnedHitboxes = false; // Whether this objects has spawned it's hitboxes yet or not.
hasHitSomething = false; // Whether this object has hit something recently

copyCharacterPalette = false;
hasLifetime = false;
projectileHealth = 999;

duration = 60 * 99; // The amount of time (in frames) that this object exists for

collidedWithProjectileList = ds_list_create(); // The list of projectiles this has recently hit
processedWithProjectileList = ds_list_create(); // The list of projectiles we have processed collisions for

// The script that runs when this collides with something (copied and modified from oProjectileBase)
projectileMeetingScript = function ProjectileMeetingScript(collisionID, createCollisionParticle = false)
{
	// If we've already processed this object, exit
	if (ds_list_find_index(processedWithProjectileList, collisionID) != -1)
	{
		exit;
	}
	
	// If we have already collided with this projectile recently exit
	if (ds_list_find_index(collidedWithProjectileList, collisionID) != -1)
	{
		exit;
	}
	
	// Add the projectile to a list of projectiles we've hit
	ds_list_add(collidedWithProjectileList, collisionID); 

	// Refresh the lifetimes of all hitboxes
	for (var j = 0; j < ds_list_size(hitboxID); j++)
	{
		with (ds_list_find_value(hitboxID, j))
		{
			lifetime = other.hitboxProperties.AttackProperty[j].Lifetime + other.hitboxProperties.AttackProperty[j].AttackHitStop;
		}
	}
	
	if (target != noone)
	{
		ds_list_clear(target.hitByGroup);
	}
	
	// Enter hitstop
	hitstop = 10;
	state = eState.HITSTOP;
	
	// Say that we've processed this object
	ds_list_add(processedWithProjectileList, collisionID);
	
	hasHitSomething = true;

}