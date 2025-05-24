// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PerformLandingBuffer()
{
	// Landing Buffer
	if (landingBufferAttack != 0)
	{
		// Transition into the landing attack
		PressAttackButton(landingBufferAttack);
		
		// Reset landing buffer vars
		landingBufferAttack = 0;
		landingBufferTimer = 0;
		
		// Also reset general input buffer just in case
		bufferAttackInput = 0;
		
		// Turn around to face opponent
		if (opponent != noone)
		{
			if (x < opponent.x)
			{
				image_xscale = 1;
			}
			else if (x != opponent.x)
			{
				image_xscale = -1;
			}
		}
		
		// Destroy any extraneous hit/hurtboxes
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
					
		// Destroy all hitboxes that belong to this player or the grabbed victim
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
}