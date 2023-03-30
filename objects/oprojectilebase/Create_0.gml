/// @description Insert description here
// You can write your code in this editor

hsp = 2.5; // Keeping naming consistent for velocity-based variables
vsp = 0;

lifetime = 60; // How long this projectile lasts in frames

fallSpeed = 0; // How fast this projectile accelerates downward
grounded = false; // Whether this projectile is on the ground or not
airTraction = 0; // How much this projectile slows down in the air
groundTraction = 0; // How much this projectile slows down on the ground

destroyOnFloor = true; // Whether this projectile should despawn when colliding with a floor
destroyOnWall = true;  // Whether this projectile should despawn when colliding with a wall

bounceOnFloor = false; // Whether this projectile should bounce on the floor
bounceOnWall = false; // Whether this projectile should bounce on the wall

numberOfBounces = 0; // How many times this projectile can bounce off of surfaces
bounciness = .5; // How much velocity does this projectile lose when it bounces?

transcendent = false; // Whether this projectile will phase through other projectiles
projectileHealth = 1; // How many hits from another projectile it takes to destroy this projectile

playerOwner = noone; // Who fired this projectile

hitboxProperties = global.ProjectileBase_HitboxData; // Which hitbox properties should this projectile use?
hitboxID = noone; // The ID of this projectile's hitbox

collidedWithProjectile = false; // Whether this projectile has collided with another