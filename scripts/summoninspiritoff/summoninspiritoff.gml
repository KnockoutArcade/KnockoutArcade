// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SummonInSpiritOff(moveToDo)
{
	spiritObject.spiritState = eSpiritState.ATTACK;
	
	spiritObject.x += moveToDo.SpiritData.StartXOffset * image_xscale;
	spiritObject.y += moveToDo.SpiritData.StartYOffset;
	
	// If this move doesn't summon the spirit afterwards...
	if (!moveToDo.SpiritData.SummonSpirit)
	{
		spiritON = false;
		spiritObject.inSpiritOff = true;
		if ((selectedCharacter.JumpType & 1) != 1)
		{
			canDoubleJump = false;
		}
	}
	else // If it does put you in spirit ON...
	{
		if (selectedCharacter.UniqueData.LinkMovesetsWithSpirits)
		{
			currentMovesetID = selectedCharacter.UniqueData.SpiritOnMoveset;
			OverwriteMoveset();
		}
		spiritObject.inSpiritOff = false;
		spiritON = true;
	}
	
	with (spiritObject)
	{
		OverwriteSpiritMoveset(true);
	}
	pendingToggle = false;
}