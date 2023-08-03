// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CancelIntoMove(_prevState, _prevSprite, _animOffset)
{
	prevState = _prevState;
	prevSprite = _prevSprite;
	animOffset = _animOffset;
	hitstopBuffer = true;
	isThrowable = true;
	
	ds_list_clear(hitByGroup);
	if (target != noone)
	{
		ds_list_clear(target.hitByGroup);
	}
	
	// Iterate through every hurtbox in the scene and destroy each nonprimary hurtbox
	var allHurtboxes = [];

	for (var i = 0; i < instance_number(oPlayerHurtbox); i++;) 
	{
		allHurtboxes[i] = instance_find(oPlayerHurtbox, i);
	}
	
	for (var i = 0; i < array_length(allHurtboxes); i++;)
	{
		if (!allHurtboxes[i].primary && allHurtboxes[i].owner.id == id)
		{ 
			instance_destroy(allHurtboxes[i]);
		}
	}
	
	// Destroy all hitboxes that belong to this player
	var allHitboxes = [];
	
	for (var i = 0; i < instance_number(oHitbox); i++;)
	{
		allHitboxes[i] = instance_find(oHitbox, i);
		
	}
	
	for (var i = 0; i < array_length(allHitboxes); i++;)
	{
		if (allHitboxes[i].owner == id)
		{ 
			instance_destroy(allHitboxes[i]);
		}
	}
}