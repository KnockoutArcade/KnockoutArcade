/// @description Insert description here
// You can write your code in this editor

if (primary && owner.state != eState.HITSTOP)
{
	if (spirit == noone)
	{
		x = owner.x + (owner.hurtboxOffset * sign(owner.image_xscale));
		y = owner.y;
	}
	else
	{
		show_debug_message(string(owner.x) + ", " + string(spiritX));
		x = spiritX + (spiritHurtboxOffset * sign(spiritXScale));
		y = spiritY;
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
		// And for some reason the position is stored properly here...
		x = spirit.x + hurtboxProperty.WidthOffset * sign(spiritXScale);
		y = spirit.y - hurtboxProperty.HeightOffset * sign(spiritYScale);
	}
	
	if (!owner.inAttackState)
	{
		instance_destroy();
	}
}
image_xscale = abs(image_xscale) * sign(owner.image_xscale);


