// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ClearVictimHitByGroups()
{
	// For each object we hit, clear it's hasBeenHitByIds
	for (var i = 0; i < ds_list_size(objectsHitList); i++;)
	{
		if (instance_exists(objectsHitList[| i]))
		{
			// Create an array full of the IDs that the object has been hit by (stored as strings)
			var hitByIDs = variable_struct_get_names(objectsHitList[| i].hasBeenHitByIds);
			
			for (var j = 0; j < array_length(hitByIDs); j++)
			{
			    // Get the name of the current index
				var _ID = hitByIDs[j];
				
				// Does the ID match this hitbox's owner?
			    if (_ID == string(id)) 
				{
					ds_list_destroy(objectsHitList[| i].hasBeenHitByIds[$ _ID]);
					
					variable_struct_remove(objectsHitList[| i].hasBeenHitByIds, _ID);
				}
			}
		}
	}
	
	ds_list_clear(objectsHitList);
}