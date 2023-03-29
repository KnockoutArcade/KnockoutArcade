/// @description Insert description here
// You can write your code in this editor

hsp = 5; // Keeping naming consistent for velocity-based variables
vsp = 0;

fallSpeed = 0; // How fast this projectile accelerates downward
grounded = false; // Whether this projectile is on the ground or not
airTraction = 0; // How much this projectile slows down in the air
groundTraction = 0; // How much this projectile slows down on the ground

destroyOnFloor = true; // Whether this projectile should despawn when colliding with a floor
destoryOnWall = true;  // Whether this projectile should despawn when colliding with a wall

transcendent = false; // Whether this projectile will phase through other projectiles
projectileHealth = 1; // How many hits from another projectile it takes to destroy this projectile