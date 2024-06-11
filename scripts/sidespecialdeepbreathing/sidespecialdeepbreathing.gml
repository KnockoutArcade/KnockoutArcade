// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SideSpecialDeepBreathing()
{
	if (animTimer <= 1 && hasSpecialCharge)
	{
		hasSpecialCharge = false;
		isEXFlash = true;
		
		state = eState.REKKA_LAUNCHER;
		sprite_index = selectedCharacter.RekkaLauncher.SpriteId;
		CancelIntoMove(eState.REKKA_LAUNCHER, selectedCharacter.RekkaLauncher.SpriteId, 1);
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
		SetSpiritMoveData(true, selectedCharacter.RekkaLauncher, 0);
		if (spiritObject != noone)
		{
			with (spiritObject)
			{
				sprite_index = selectedCharacter.RekkaLauncher.SpriteId;
				CancelIntoMove(eState.REKKA_LAUNCHER, selectedCharacter.RekkaLauncher.SpriteId, 1);
			}
		}
		
		animTimer = 0;
		image_index = 0;
	}
}