/// @description Insert description here
// You can write your code in this editor

other.coinScore += coinValue;

// Display Particle Effect
var particle = instance_create_layer(x, y, "Particles", oParticles);
with(particle)
{
	lifetime = 25;
	sprite_index = sCollectionSparkle;
}

instance_destroy();


