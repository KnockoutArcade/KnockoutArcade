/// @description Insert description here
// You can write your code in this editor

event_inherited();

gravityScaling = 0;

duration--;

if (duration <= 0)
{
	instance_destroy(hurtbox);
	instance_destroy();
}