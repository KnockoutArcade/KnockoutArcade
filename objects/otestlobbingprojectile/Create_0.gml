/// @description Insert description here
// You can write your code in this editor

event_inherited();

hsp = 2.5; // Keeping naming consistent for velocity-based variables
vsp = -5;

lifetime = 120;

fallSpeed = .5; // How fast this projectile accelerates downward
grounded = false; // Whether this projectile is on the ground or not
airTraction = 0; // How much this projectile slows down in the air
groundTraction = 0; // How much this projectile slows down on the ground

bounceOnFloor = true; // Whether this projectile should bounce on the floor
bounceOnWall = true; // Whether this projectile should bounce on the wall

numberOfBounces = 1; // How many times this projectile can bounce off of surfaces

transcendent = false; // Whether this projectile will phase through other projectiles
projectileHealth = 1; // How many hits from another projectile it takes to destroy this projectile

hitboxProperties = global.ProjectileBase_HitboxData; // Which hitbox properties should this projectile use?



