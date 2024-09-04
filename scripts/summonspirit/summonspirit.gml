// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SummonSpirit()
{
	spiritObject.spiritState = eSpiritState.ACTIVE;
	spiritObject.createSpiritFire();
	spiritObject.inSpiritOff = false;
	
	// Make sure the spirit uses the Spirit ON versions of moves
	with (spiritObject)
	{
		OverwriteSpiritMoveset(false);
	}

	spiritON = true;
	pendingToggle = false;
	if (selectedCharacter.UniqueData.DoubleJump)
	{
		canDoubleJump = true;
	}
}