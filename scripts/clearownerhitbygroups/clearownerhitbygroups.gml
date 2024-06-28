// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ClearOwnerHitByGroups()
{
	// Clean up our hasBeenHitByIds
	var hitByIDs = variable_struct_get_names(hasBeenHitByIds);
			
	for (var j = 0; j < array_length(hitByIDs); j++)
	{
	    // Get the name of the current index
		var _ID = hitByIDs[j];
	
		// Does the ID match this hitbox's owner?
		if (_ID == string(id)) 
		{
			ds_list_destroy(hasBeenHitByIds[$ _ID]);
	
			variable_struct_remove(hasBeenHitByIds, _ID);
		}
	}
}