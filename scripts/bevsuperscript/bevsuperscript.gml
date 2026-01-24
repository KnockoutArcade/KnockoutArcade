// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function BevSuperScript()
{
	if (animTimer == 1)
	{
		// Destroy all supers that belong to this player
		var allSuperProjectiles = [];
	
		for (var i = 0; i < instance_number(oSuperExerciseBall); i++;)
		{
			allSuperProjectiles[i] = instance_find(oSuperExerciseBall, i);
		
		}
	
		for (var i = 0; i < array_length(allSuperProjectiles); i++;)
		{
			if (allSuperProjectiles[i].playerOwner == id)
			{ 
				instance_destroy(allSuperProjectiles[i]);
			}
		}
	}
}