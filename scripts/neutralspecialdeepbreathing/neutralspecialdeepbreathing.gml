// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NeutralSpecialDeepBreathing()
{
	if (animTimer <= 1 && hasSpecialCharge)
	{
		hasSpecialCharge = false;
		isEXFlash = true;
		
		state = eState.ENHANCED_NEUTRAL_SPECIAL;
		sprite_index = selectedCharacter.EnhancedNeutralSpecial.SpriteId;
		CancelIntoMove(eState.ENHANCED_NEUTRAL_SPECIAL, selectedCharacter.EnhancedNeutralSpecial.SpriteId, 1);
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
		SetSpiritMoveData(true, selectedCharacter.EnhancedNeutralSpecial, 0);
		if (spiritObject != noone)
		{
			with (spiritObject)
			{
				sprite_index = selectedCharacter.EnhancedNeutralSpecial.SpriteId;
				CancelIntoMove(eState.ENHANCED_NEUTRAL_SPECIAL, selectedCharacter.EnhancedNeutralSpecial.SpriteId, 1);
			}
		}
		
		animTimer = 0;
		image_index = 0;
	}
}