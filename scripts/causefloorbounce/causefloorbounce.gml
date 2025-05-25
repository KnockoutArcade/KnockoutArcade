// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CauseFloorBounce(_victim)
{
	// TODO: Put this in the character editor instead
	
	if (!_victim.hasUsedFloorBounce)
	{
		_victim.floorBouncing = true;
	}
}