// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ProcessEnhancers(Special) {
	if (Special.NumberOfEnhancements > 0 && animTimer <= Special.Duration)
	{
		for (var i = 0; i < Special.NumberOfEnhancements; i++)
		{
			motionInput[i] = Special.SpecialData[i].NumpadInput;
		}
	
		SetMotionInputs(motionInput, array_length(motionInput), Special.SpecialData[0].StartingFrame, Special.SpecialData[0].EndingFrame, Special.SpecialData[0].TransitionFrame, Special.SpecialData[0].TransitionImmediately, Special.SpecialData[0].ButtonPressRequired);
	
		// Checks to see if the special move can be changed
		if (CheckChange(Special) && inputSet)
		{
			// Iterate through each enhancement
			for (var i = 0; i < Special.NumberOfEnhancements; i++;)
			{
				if (enhanced[i])
				{
					// Which move should we switch to?
					switch (Special.SpecialData[i].EnhancementMove)
					{
						case 1: // Enhanced Neutral
						{
							state = eState.ENHANCED_NEUTRAL_SPECIAL;
							sprite_index = selectedCharacter.EnhancedNeutralSpecial.SpriteId;
							CancelIntoMove(eState.ENHANCED_NEUTRAL_SPECIAL, selectedCharacter.EnhancedNeutralSpecial.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
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
						}
						break;
					
						case 2: // Enhanced Side
						{
							state = eState.ENHANCED_SIDE_SPECIAL;
							sprite_index = selectedCharacter.EnhancedSideSpecial.SpriteId;
							CancelIntoMove(eState.ENHANCED_SIDE_SPECIAL, selectedCharacter.EnhancedSideSpecial.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
							requireSpecialButton = false;
							SetSpiritMoveData(true, selectedCharacter.EnhancedSideSpecial, 0);
							if (spiritObject != noone)
							{
								with (spiritObject)
								{
									sprite_index = selectedCharacter.EnhancedSideSpecial.SpriteId;
									CancelIntoMove(eState.ENHANCED_SIDE_SPECIAL, selectedCharacter.EnhancedSideSpecial.SpriteId, 1);
								}
							}
						}
						break;
						
						case 4: // Enhanced Up
						{
							state = eState.ENHANCED_UP_SPECIAL;
							sprite_index = selectedCharacter.EnhancedUpSpecial.SpriteId;
							CancelIntoMove(eState.ENHANCED_UP_SPECIAL, selectedCharacter.EnhancedUpSpecial.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
							requireSpecialButton = false;
							SetSpiritMoveData(true, selectedCharacter.EnhancedUpSpecial, 0);
							if (spiritObject != noone)
							{
								with (spiritObject)
								{
									sprite_index = selectedCharacter.EnhancedUpSpecial.SpriteId;
									CancelIntoMove(eState.ENHANCED_UP_SPECIAL, selectedCharacter.EnhancedUpSpecial.SpriteId, 1);
								}
							}
						}
						break;
						
						case 8: // Enhanced Down
						{
							state = eState.ENHANCED_DOWN_SPECIAL;
							sprite_index = selectedCharacter.EnhancedDownSpecial.SpriteId;
							CancelIntoMove(eState.ENHANCED_DOWN_SPECIAL, selectedCharacter.EnhancedDownSpecial.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
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
						}
						break;
						
						case 16: // Enhanced Neutral 2
						{
							state = eState.ENHANCED_NEUTRAL_SPECIAL_2;
							sprite_index = selectedCharacter.EnhancedNeutralSpecial2.SpriteId;
							CancelIntoMove(eState.ENHANCED_NEUTRAL_SPECIAL_2, selectedCharacter.EnhancedNeutralSpecial2.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
							requireSpecialButton = false;
							SetSpiritMoveData(true, selectedCharacter.EnhancedNeutralSpecial2, 0);
							if (spiritObject != noone)
							{
								with (spiritObject)
								{
									sprite_index = selectedCharacter.EnhancedNeutralSpecial2.SpriteId;
									CancelIntoMove(eState.ENHANCED_NEUTRAL_SPECIAL_2, selectedCharacter.EnhancedNeutralSpecial2.SpriteId, 1);
								}
							}
						}
						break;
						
						case 32: // Enhanced Side 2
						{
							state = eState.ENHANCED_SIDE_SPECIAL_2;
							sprite_index = selectedCharacter.EnhancedSideSpecial2.SpriteId;
							CancelIntoMove(eState.ENHANCED_SIDE_SPECIAL_2, selectedCharacter.EnhancedSideSpecial2.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
							requireSpecialButton = false;
							SetSpiritMoveData(true, selectedCharacter.EnhancedSideSpecial2, 0);
							if (spiritObject != noone)
							{
								with (spiritObject)
								{
									sprite_index = selectedCharacter.EnhancedSideSpecial2.SpriteId;
									CancelIntoMove(eState.ENHANCED_SIDE_SPECIAL_2, selectedCharacter.EnhancedSideSpecial2.SpriteId, 1);
								}
							}
						}
						break;
						
						case 64: // Enhanced Up 2
						{
							state = eState.ENHANCED_UP_SPECIAL_2;
							sprite_index = selectedCharacter.EnhancedUpSpecial2.SpriteId;
							CancelIntoMove(eState.ENHANCED_UP_SPECIAL_2, selectedCharacter.EnhancedUpSpecial2.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
							requireSpecialButton = false;
							SetSpiritMoveData(true, selectedCharacter.EnhancedUpSpecial2, 0);
							if (spiritObject != noone)
							{
								with (spiritObject)
								{
									sprite_index = selectedCharacter.EnhancedUpSpecial2.SpriteId;
									CancelIntoMove(eState.ENHANCED_UP_SPECIAL_2, selectedCharacter.EnhancedUpSpecial2.SpriteId, 1);
								}
							}
						}
						break;
						
						case 128: // Enhanced Down 2
						{
							state = eState.ENHANCED_DOWN_SPECIAL_2;
							sprite_index = selectedCharacter.EnhancedDownSpecial2.SpriteId;
							CancelIntoMove(eState.ENHANCED_DOWN_SPECIAL_2, selectedCharacter.EnhancedDownSpecial2.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
							requireSpecialButton = false;
							SetSpiritMoveData(true, selectedCharacter.EnhancedDownSpecial2, 0);
							if (spiritObject != noone)
							{
								with (spiritObject)
								{
									sprite_index = selectedCharacter.EnhancedDownSpecial2.SpriteId;
									CancelIntoMove(eState.ENHANCED_DOWN_SPECIAL_2, selectedCharacter.EnhancedDownSpecial2.SpriteId, 1);
								}
							}
						}
						break;
						
						case 256: // Rekka Launcher
						{
							state = eState.REKKA_LAUNCHER;
							sprite_index = selectedCharacter.RekkaLauncher.SpriteId;
							CancelIntoMove(eState.REKKA_LAUNCHER, selectedCharacter.RekkaLauncher.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
							requireSpecialButton = false;
							for (var j = 0; j < array_length(enhanced); j++;)
							{
								enhanced[j] = false;
							}
							SetSpiritMoveData(true, selectedCharacter.RekkaLauncher, 0);
							if (spiritObject != noone)
							{
								with (spiritObject)
								{
									sprite_index = selectedCharacter.RekkaLauncher.SpriteId;
									CancelIntoMove(eState.REKKA_LAUNCHER, selectedCharacter.RekkaLauncher.SpriteId, 1);
								}
							}
						}
						break;
						
						case 512: // Rekka Finisher
						{
							state = eState.REKKA_FINISHER;
							sprite_index = selectedCharacter.RekkaFinisher.SpriteId;
							CancelIntoMove(eState.REKKA_FINISHER, selectedCharacter.RekkaFinisher.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
							requireSpecialButton = false;
							for (var j = 0; j < array_length(enhanced); j++;)
							{
								enhanced[j] = false;
							}
							SetSpiritMoveData(true, selectedCharacter.RekkaFinisher, 0);
							if (spiritObject != noone)
							{
								with (spiritObject)
								{
									sprite_index = selectedCharacter.RekkaFinisher.SpriteId;
									CancelIntoMove(eState.REKKA_FINISHER, selectedCharacter.RekkaFinisher.SpriteId, 1);
								}
							}
						}
						break;
						
						case 1024: // Rekka Connecter
						{
							state = eState.REKKA_CONNECTER;
							sprite_index = selectedCharacter.RekkaConnecter.SpriteId;
							CancelIntoMove(eState.REKKA_CONNECTER, selectedCharacter.RekkaConnecter.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
							requireSpecialButton = false;
							for (var j = 0; j < array_length(enhanced); j++;)
							{
								enhanced[j] = false;
							}
							SetSpiritMoveData(true, selectedCharacter.RekkaConnecter, 0);
							if (spiritObject != noone)
							{
								with (spiritObject)
								{
									sprite_index = selectedCharacter.RekkaConnecter.SpriteId;
									CancelIntoMove(eState.REKKA_CONNECTER, selectedCharacter.RekkaConnecter.SpriteId, 1);
								}
							}
						}
						break;
						
						case 2048: // Rekka Low
						{
							state = eState.REKKA_LOW;
							sprite_index = selectedCharacter.RekkaLow.SpriteId;
							CancelIntoMove(eState.REKKA_LOW, selectedCharacter.RekkaLow.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
							requireSpecialButton = false;
							for (var j = 0; j < array_length(enhanced); j++;)
							{
								enhanced[j] = false;
							}
							SetSpiritMoveData(true, selectedCharacter.RekkaLow, 0);
							if (spiritObject != noone)
							{
								with (spiritObject)
								{
									sprite_index = selectedCharacter.RekkaLow.SpriteId;
									CancelIntoMove(eState.REKKA_LOW, selectedCharacter.RekkaLow.SpriteId, 1);
								}
							}
						}
						break;
						
						case 4096: // Rekka High
						{
							state = eState.REKKA_HIGH;
							sprite_index = selectedCharacter.RekkaHigh.SpriteId;
							CancelIntoMove(eState.REKKA_HIGH, selectedCharacter.RekkaHigh.SpriteId, 1);
							inputSet = false;
							ds_list_clear(listOfInputs);
							progressInInputs = [];
							inputWindowStart = 0;
							inputWindowEnd = 0;
							requireSpecialButton = false;
							for (var j = 0; j < array_length(enhanced); j++;)
							{
								enhanced[j] = false;
							}
							SetSpiritMoveData(true, selectedCharacter.RekkaHigh, 0);
							if (spiritObject != noone)
							{
								with (spiritObject)
								{
									sprite_index = selectedCharacter.RekkaHigh.SpriteId;
									CancelIntoMove(eState.REKKA_HIGH, selectedCharacter.RekkaHigh.SpriteId, 1);
								}
							}
						}
						break;
						
					}
					animTimer = 0;
					image_index = 0;
					isEXFlash = true;
				}
			}
		}
	}
}