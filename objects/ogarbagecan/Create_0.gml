/// @description Insert description here
// You can write your code in this editor

event_inherited();

knockbackMultiplier = 1; // Multiplier for how much knockback this object takes.
launchable = true; // Whether this object can be launched or not
isThrowable = true; // whether we can throw this object around or not

hasWallCollision = false;

sprite_index = sGarbageCan;

hitstun = 0;
inAttackState = false;

with (hurtbox) 
{
	primary = true;
	owner = other.id;
	image_xscale = 21;
	image_yscale = 32;
}
hurtboxOffset = -11;

CharacterSprites = {
	idle_Sprite : sprite_index,
	hurt_Sprite : sprite_index,
	grab_Sprite : sprite_index,
	hold_Sprite : sprite_index,
	launched_Sprite : sprite_index,
	knockdown_Sprite : sprite_index,
	getup_Sprite : sprite_index,
}
