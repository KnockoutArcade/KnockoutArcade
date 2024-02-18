/// @description Insert description here
// You can write your code in this editor

if (primary && owner.inAttackState)
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
	
	if (!owner.inAttackState)
	{
		instance_destroy();
	}
}
image_xscale = abs(image_xscale) * sign(owner.image_xscale);


