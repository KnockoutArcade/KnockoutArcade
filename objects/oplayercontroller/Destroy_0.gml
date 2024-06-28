/// @description Insert description here
// You can write your code in this editor

// Clean up any lists left over
ds_list_destroy(listOfInputs);
listOfInputs = -1;

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

ds_list_destroy(objectsHitList);
objectsHitList = -1;

