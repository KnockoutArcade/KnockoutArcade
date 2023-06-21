// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CancelIntoMove(_prevState, _prevSprite, _animOffset)
{
	prevState = _prevState;
	prevSprite = _prevSprite;
	ds_list_clear(hitByGroup);
	if (target != noone)
	{
		ds_list_clear(target.hitByGroup);
	}
	animOffset = _animOffset;
	hitstopBuffer = true;
	isThrowable = true;

	// Iterates through every hurtbox in the scene and destroys each one that isn't a primary hurtbox
	for (var i = 0; i < instance_number(oPlayerHurtbox); i++;)
	{
		var hurtbox = instance_find(oPlayerHurtbox, i);
		
		if (!hurtbox.primary && hurtbox.owner == id)
		{ 
			instance_destroy(hurtbox);
		}
	}
	
	// Destroy all hitboxes that belong to this player
	for (var i = 0; i < instance_number(oHitbox); i++;)
	{
		var playerHitbox = instance_find(oHitbox, i);
		
		if (playerHitbox.owner == id)
		{ 
			instance_destroy(playerHitbox);
		}
	}
}