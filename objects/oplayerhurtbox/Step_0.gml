/// @description Insert description here
// You can write your code in this editor


if (owner.hitstun > 0 && !primary) instance_destroy(); 

visible = global.toggleHitboxVisibility;

if (lifetime < 1 && !primary) instance_destroy();

if (!primary && !global.game_paused && global.hitstop < 1) lifetime--;

if owner.inAttackState == false && !primary {
	instance_destroy();
}

if primary && owner.state != eState.HITSTOP {
	x = owner.x+(owner.hurtboxOffset*sign(owner.image_xscale));
	y = owner.y;
} 
if !primary {
	x = owner.x + hurtboxProperty.widthOffset[hurtboxID] * sign(owner.image_xscale);
	y = owner.y - hurtboxProperty.heightOfset[hurtboxID] * sign(owner.image_yscale);
	if owner.inAttackState == false {
		instance_destroy();
	}
}
image_xscale = abs(image_xscale) * sign(owner.image_xscale);