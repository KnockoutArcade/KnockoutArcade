// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DeepBreathingScript()
{
	if (animTimer <= 1 && hasSpecialCharge)
	{
		hasSpecialCharge = false;
		isEXFlash = true;
		
		state = eState.ENHANCED_DOWN_SPECIAL;
		sprite_index = selectedCharacter.EnhancedDownSpecial.SpriteId;
		CancelIntoMove(eState.ENHANCED_DOWN_SPECIAL, selectedCharacter.EnhancedDownSpecial.SpriteId, 1);
		inputSet = false;
		ds_list_clear(listOfInputs);
		progressInInputs = [];
		inputWindowStart = [];
		inputWindowEnd = [];
		requireSpecialButton = false;
		SetSpiritMoveData(true, selectedCharacter.EnhancedDownSpecial, 0);
		if (spiritObject != noone)
		{
			with (spiritObject)
			{
				sprite_index = selectedCharacter.EnhancedDownSpecial.SpriteId;
				CancelIntoMove(eState.ENHANCED_DOWN_SPECIAL, selectedCharacter.EnhancedDownSpecial.SpriteId, 1);
			}
		}
		
		animTimer = 0;
		image_index = 0;
	}
}