// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function UpSpecialDeepBreathing()
{
	if (animTimer <= 1) && ((hasSpecialCharge) || (downUpChargeTimer >= timeToCharge && superMeter >= 25))
	{
		// If we inputted this move via charge motion
		if (downUpChargeTimer >= timeToCharge)
		{
			superMeter -= 25;
		}
		else
		{
			hasSpecialCharge = false;
		}
		
		isEXFlash = true;
		
		invincible = true;
		
		bufferCharge = false;
		
		state = eState.ENHANCED_UP_SPECIAL;
		sprite_index = selectedCharacter.EnhancedUpSpecial.SpriteId;
		CancelIntoMove(eState.ENHANCED_UP_SPECIAL, selectedCharacter.EnhancedUpSpecial.SpriteId, 1);
		inputSet = false;
		ds_list_clear(listOfInputs);
		progressInInputs = [];
		inputWindowStart = [];
		inputWindowEnd = [];
		requireSpecialButton = false;
		for (var j = 0; j < array_length(enhanced); j++;)
		{
			enhanced[j] = false;
		}
		SetSpiritMoveData(true, selectedCharacter.EnhancedUpSpecial, 0);
		if (spiritObject != noone)
		{
			with (spiritObject)
			{
				sprite_index = selectedCharacter.EnhancedUpSpecial.SpriteId;
				CancelIntoMove(eState.ENHANCED_UP_SPECIAL, selectedCharacter.EnhancedUpSpecial.SpriteId, 1);
			}
		}
		
		animTimer = 0;
		image_index = 0;
	}
}