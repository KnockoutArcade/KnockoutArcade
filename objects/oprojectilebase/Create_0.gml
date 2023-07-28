/// @description Insert description here
// You can write your code in this editor

animTimer = 0;
animOffset = 4; // How many frames to offset an animation by (specifically during hitstop)

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

hitboxProperties = {};
hitboxProperties.NumberOfHitboxes = selectedProjectile.NumberOfHitboxes;
hitboxProperties.AttackProperty = selectedProjectile.AttackProperty;
hitboxProperties.CounterHitProperty = selectedProjectile.CounterHitProperty;
hitboxProperties.RehitData = selectedProjectile.RehitData;

hitboxID = noone; // The ID of this projectile's hitbox

collidedWithProjectile = false; // Whether this projectile has collided with another