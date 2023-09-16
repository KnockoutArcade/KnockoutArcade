/// @description Insert description here
// You can write your code in this editor

event_inherited();

if (hp <= 0 && state == eState.IDLE)
{
	instance_create_depth(x, y, depth - 1, oFallingGirder);
	
	instance_destroy(hurtbox);
	if (hasWallCollision)
	{
		instance_destroy(wallCollisionBox);
	}
	ds_list_destroy(hitByGroup);
	instance_destroy();
	oPlayerController.target = noone;
}


