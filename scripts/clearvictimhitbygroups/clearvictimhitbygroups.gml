// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ClearVictimHitByGroups()
{
	if (target != noone)
	{
		ds_list_clear(target.hitByGroup);
	}
	
	// For each object we hit, clear it's hitByGroup
	for (var i = 0; i < ds_list_size(objectsHitList); i++;)
	{
		if (instance_exists(objectsHitList[| i]))
		{
			ds_list_clear(objectsHitList[| i].hitByGroup);
		}
	}
	
	ds_list_clear(objectsHitList);
}