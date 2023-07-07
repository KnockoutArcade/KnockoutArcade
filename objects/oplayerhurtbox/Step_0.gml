/// @description Insert description here
// You can write your code in this editor

if (owner != noone)
{
	if (owner.hitstun > 0 && !primary)
	{
		instance_destroy();
	}

	visible = global.toggleHitboxVisibility;

	if (lifetime < 1 && !primary)
	{
		instance_destroy();
	}

	if (!primary && !global.game_paused && owner.hitstop < 1 && owner.state != eState.HITSTOP)
	{
		lifetime--;
	}

	if (!owner.inAttackState && !primary)
	{
		instance_destroy();
	}

	if (!owner.inAttackState && !primary)
	{
		instance_destroy();
	}
}