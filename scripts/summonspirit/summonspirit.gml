// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SummonSpirit(spiritToSummon)
{
	if (spirit.Name == "SmoothCriminal")
	{
		spiritObject = instance_create_layer(x + (10 * image_xscale), y, "Instances", oSmoothCriminal);
	}
	spiritObject.host = selectedCharacter;
	spiritObject.hostObject = self;
	spiritObject.playerID = playerID;
	spiritObject.opponent = opponent;
	spiritSummoned = true;
}