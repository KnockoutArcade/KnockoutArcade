// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SummonInSpiritOff(moveToDo)
{
	if (selectedCharacter.UniqueData.SpiritData == 1 && !spiritState && moveToDo.SpiritData.PerformInSpiritOff && !spiritBroken)
	{
		if (!spiritSummoned)
		{
			SummonSpirit(spirit);
			spiritObject.image_xscale = image_xscale;
			spiritObject.x += moveToDo.SpiritData.StartXOffset * image_xscale;
			spiritObject.y += moveToDo.SpiritData.StartYOffset;
			var spiritFire = instance_create_layer(spiritObject.x, spiritObject.y, "Instances", oSpiritFire);
			spiritFire.depth = depth + 1;
		}
		if (moveToDo.SpiritData.SummonSpirit)
		{
			spiritState = true;
			if (selectedCharacter.UniqueData.DoubleJump)
			{
				canDoubleJump = true;
			}
			if (selectedCharacter.UniqueData.LinkMovesetsWithSpirits)
			{
				currentMovesetID = selectedCharacter.UniqueData.SpiritOnMoveset;
				OverwriteMoveset();
			}
		}
		spiritObject.state = state;
		pendingToggle = false;
	}
}