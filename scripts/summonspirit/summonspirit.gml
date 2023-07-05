// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SummonSpirit(spiritToSummon)
{
	if (spirit.Name == "SmoothCriminal")
	{
		spiritObject = instance_create_layer(x, y, "Instances", oSmoothCriminal);
		spiritObject.host = selectedCharacter;
		spiritObject.playerID = playerID;
	}
	spiritSummoned = true;
}