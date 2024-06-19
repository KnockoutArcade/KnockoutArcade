/// @description Insert description here
// You can write your code in this editor

// If the owner ever stops existing, destroy this hurtbox
if (!instance_exists(owner))
{
	instance_destroy();
	exit;
}

visible = global.toggleHitboxVisibility;

if (attackProperty.AttackType == eAttackType.GRAB)
{
	sprite_index = sGrabBox;
}

if (spirit == noone)
{
	x = owner.x + attackProperty.WidthOffset * sign(owner.image_xscale);
	y = owner.y - attackProperty.HeightOffset * sign(owner.image_yscale);
}
else
{
	x = spirit.x + attackProperty.WidthOffset * sign(spirit.image_xscale);
	y = spirit.y - attackProperty.HeightOffset * sign(spirit.image_yscale);
}

// Destoy if expired
if (lifetime < 1)
{
	if (isProjectile)
	{
		with (owner)
		{
			ds_list_delete(hitboxID, ds_list_find_index(hitboxID, other.id));
		}
	}
	instance_destroy();
}

// Handle non-projectiles
if (!isProjectile)
{
	HandleHitboxCollision(owner);
}
else if (!global.freezeTimer)
{
	HandleHitboxCollision(owner.playerOwner);
}
