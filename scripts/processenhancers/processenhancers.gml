// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ProcessEnhancers(Special) {
	if (Special.NumberOfEnhancements > 0)
	{
		for (var i = 0; i < Special.NumberOfEnhancements; i++)
		{
			motionInput[i] = Special.SpecialData[i].NumpadInput;
		}
	
		SetMotionInputs(motionInput, array_length(motionInput), Special.SpecialData[0].StartingFrame, Special.SpecialData[0].EndingFrame, Special.SpecialData[0].TransitionFrame, Special.SpecialData[0].TransitionImmediately);
	
		// Checks to see if the special move can be changed
		if (CheckChange(Special))
		{
			// Iterate through each enhancement
			for (var i = 0; i < Special.NumberOfEnhancements; i++;)
			{
				if (enhanced[i])
				{
					animTimer = 1;
				
					// Which move should we switch to?
					switch (Special.SpecialData[i].EnhancementMove)
					{
						case 1: // Enhanced Neutral
						{
							state = eState.ENHANCED_NEUTRAL_SPECIAL;
							sprite_index = selectedCharacter.EnhancedNeutralSpecial.SpriteId
							CancelIntoMove(eState.ENHANCED_NEUTRAL_SPECIAL, selectedCharacter.EnhancedNeutralSpecial.SpriteId, 1);
						}
						break;
					
						case 2: // Enhanced Side
						{
							state = eState.ENHANCED_SIDE_SPECIAL;
							sprite_index = selectedCharacter.EnhancedSideSpecial.SpriteId
							CancelIntoMove(eState.ENHANCED_SIDE_SPECIAL, selectedCharacter.EnhancedSideSpecial.SpriteId, 1);
						}
						break;
					}
				}
			}
		}
	}
}