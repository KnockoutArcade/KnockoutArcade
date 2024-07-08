/// @description Insert description here
// You can write your code in this editor

animTimer = 0;
animOffset = 4; // How many frames to offset an animation by (specifically during hitstop)

destroySprite = selectedProjectile.Sprites.Destroy;
canDestroySprite = false; // Plays the destroy sprite 

copyCharacterPalette = selectedProjectile.CopyCharacterPalette;

hsp = selectedProjectile.HorizontalSpeed; // Keeping naming consistent for velocity-based variables
vsp = selectedProjectile.VerticalSpeed;

hasLifetime = selectedProjectile.HasLifetime;
lifetime = selectedProjectile.Lifetime; // How long this projectile lasts in frames
animationSpeed = selectedProjectile.AnimationSpeed;
if (!hasLifetime)
{
	sprite_set_speed(object_get_sprite(object_index), animationSpeed, spritespeed_framespersecond);
}

fallSpeed = selectedProjectile.FallSpeed; // How fast this projectile accelerates downward
grounded = false; // Whether this projectile is on the ground or not
airTraction = selectedProjectile.AirTraction; // How much this projectile slows down in the air
groundTraction = selectedProjectile.GroundTraction; // How much this projectile slows down on the ground

destroyOnFloor = selectedProjectile.DestroyOnFloor; // Whether this projectile should despawn when colliding with a floor
destroyOnWall = selectedProjectile.DestroyOnWall;  // Whether this projectile should despawn when colliding with a wall

bounceOnFloor = selectedProjectile.BounceOnFloor; // Whether this projectile should bounce on the floor
bounceOnWall = selectedProjectile.BounceOnWall; // Whether this projectile should bounce on the wall

numberOfBounces = selectedProjectile.NumberOfBounces; // How many times this projectile can bounce off of surfaces
bounciness = selectedProjectile.Bounciness; // How much velocity does this projectile lose when it bounces?

transcendent = selectedProjectile.Transcendent; // Whether this projectile will phase through other projectiles
projectileHealth = selectedProjectile.Health; // How many hits from another projectile it takes to destroy this projectile

playerOwner = noone; // Who fired this projectile
spiritOwner = noone; // If spirit fired a projectile
target = noone; // The thing this projectile hit

hitboxProperties = {};
hitboxProperties.NumberOfHitboxes = selectedProjectile.NumberOfHitboxes;
hitboxProperties.AttackProperty = selectedProjectile.AttackProperty;
hitboxProperties.CounterHitProperty = selectedProjectile.CounterHitProperty;
hitboxProperties.RehitData = selectedProjectile.RehitData;

hitboxID = ds_list_create(); // The IDs of this projectile's hitboxes

collidedWithProjectileList = ds_list_create(); // The list of projectiles this has recently hit
processedWithProjectileList = ds_list_create(); // The list of projectiles we have processed collisions for

objectsHitList = ds_list_create();

hitstopTimer = 0; // How long this projectile is in hitstop for

// The script to run when a projectile destroys itself
destroyScript = function ProjectileDestroyScript()
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
	
	// Create destroy sprite
	var particle = instance_create_layer(x + hsp, y + vsp, "Particles", oParticles);
	with (particle)
	{
		lifetime = 30;
		sprite_index = other.selectedProjectile.Sprites.Destroy;
		image_xscale = other.image_xscale;
		image_angle = other.image_angle;
	}
}

// When two projectiles meet, each one needs to run this script at the moment of impact
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
	hitstopTimer = 10;
	
	// Say that we've processed this object
	ds_list_add(processedWithProjectileList, collisionID);
	
	ClearVictimHitByGroups();
	
	// Decrease projectile health
	projectileHealth -= 1;
	
	// If we need to create a collision particle, do so
	if (createCollisionParticle)
	{
		var particle = instance_create_layer((x + collisionID.x) / 2, (y + collisionID.y) / 2, "Particles", oParticles);
		with (particle)
		{
			lifetime = 30;
			sprite_index = sFireballCollision;
		}
	}
	
	
	if (projectileHealth <= 0)
	{
		destroyScript();
	}

}