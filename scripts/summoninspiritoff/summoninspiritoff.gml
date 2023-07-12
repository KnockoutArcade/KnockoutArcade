// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SummonInSpiritOff(moveToDo)
{
	SummonSpirit();
	spiritObject.x += moveToDo.SpiritData.StartXOffset * image_xscale;
	spiritObject.y += moveToDo.SpiritData.StartYOffset;
	if (!moveToDo.SpiritData.SummonSpirit)
	{
		spiritState = false;
	}
	else
	{
		if (selectedCharacter.UniqueData.LinkMovesetsWithSpirits)
		{
			currentMovesetID = selectedCharacter.UniqueData.SpiritOnMoveset;
			OverwriteMoveset();
		}
	}
	
	with (spiritObject)
	{
		OverwriteSpiritMoveset(true);
	}
	spiritObject.inSpiritOff = true;
	spiritObject.state = state;
	spiritObject.startingMove = state;
	pendingToggle = false;
}