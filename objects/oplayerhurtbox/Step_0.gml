/// @description Insert description here
// You can write your code in this editor

if (owner != noone)
{
	// If the owner ever stops existing, destroy this hurtbox
	if (!instance_exists(owner))
	{
		instance_destroy();
	}
	
	// If owner is hit and this isn't their primary hurtbox
	if (owner.hitstun > 0 && !primary)
	{
		instance_destroy();
	}
}