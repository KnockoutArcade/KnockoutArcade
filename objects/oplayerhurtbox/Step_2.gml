/// @description Insert description here
// You can write your code in this editor

visible = global.toggleHitboxVisibility;

// If the thing that spawned this hurtbox stops existing, destroy this
if (!instance_exists(owner))
{
	instance_destroy()
	exit;
}

if (primary && owner.inAttackState && owner.animTimer > 0)
{
	// Hide if the owner is in an attack state
	image_xscale = 0;
	image_yscale = 0;

}

if (primary && owner.state != eState.HITSTOP)
{
	if (spirit == noone)
	{
		x = owner.x + (owner.hurtboxXOffset * sign(owner.image_xscale));
		y = owner.y + owner.hurtboxYOffset;
	}
	else
	{
		if (sign(owner.image_xscale) == sign(spirit.image_xscale))
		{
			x = spirit.x + (spirit.hurtboxOffset * sign(spirit.image_xscale));
		}
		else
		{
			x = spirit.x + (spirit.hurtboxOffset * sign(-spirit.image_xscale));
		}
		y = spirit.y;
	}
} 

if (!primary)
{
	if (spirit == noone)
	{
		x = owner.x + hurtboxProperty.WidthOffset * sign(owner.image_xscale);
		y = owner.y - hurtboxProperty.HeightOffset * sign(owner.image_yscale);
	}
	else
	{
		x = spirit.x + hurtboxProperty.WidthOffset * sign(spirit.image_xscale);
		y = spirit.y - hurtboxProperty.HeightOffset * sign(spirit.image_yscale);
	}
	
	if (!global.game_paused && owner.hitstop < 1 && owner.state != eState.HITSTOP && owner.state != eState.SCREEN_FREEZE)
	{
		lifetime--;
	}
	
	// If the owner is ever not in an attack state and also isn't frozen, destroy this.
	if (!owner.inAttackState && owner.state != eState.SCREEN_FREEZE)
	{
		instance_destroy();
	}
	
	if (lifetime < 0)
	{
		instance_destroy();
	}
}
image_xscale = abs(image_xscale) * sign(owner.image_xscale);


