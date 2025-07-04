/// @description Controller Detection
// You can write your code in this editor

// Handle controller connect/disconnect
if (ds_map_find_value(async_load, "event_type") == "gamepad discovered")
{
	show_debug_message("Controller connected in slot " + string(ds_map_find_value(async_load, "pad_index")));
	
	ControllerSetup(controllers, ds_map_find_value(async_load, "pad_index"), CONTROLLER_TYPES.PAD);
	
	show_debug_message(string(ds_list_size(controllers)) + " controllers left");
	/*
	for (var ii = 0; ii < ds_list_size(controllers); ii++;)
	{
		show_debug_message(string(controllers[| ii].controllerInstance) + " type " + string(controllers[| ii].controllerType));
	}
	*/
	
	// Find the controller ID we just added
	var addedControllerId = controllers[| ds_list_size(controllers) - 1].controllerInstance;
	
	
	// Notify objects that controllers have been updated
	var objectsToRemove = [];
	
	for (var j = 0; j < ds_list_size(controllerUpdateNotifyList); j++;)
	{
		if (instance_exists(controllerUpdateNotifyList[| j]))
		{
			controllerUpdateNotifyList[| j].controllerUpdate(true, addedControllerId);
		}
		else
		{
			array_push(objectsToRemove, controllerUpdateNotifyList[| j]);
		}
	}

	// Remove objects from the notify list that do not exist anymore
	for (var k = 0; k < array_length(objectsToRemove); k++;)
	{
		var objectIndex = ds_list_find_index(controllerUpdateNotifyList, objectsToRemove[k]);
	
		ds_list_delete(controllerUpdateNotifyList, objectIndex);
	}
	
	//show_debug_message(string(ds_list_size(controllerUpdateNotifyList)) + " objects to update");
}

if (ds_map_find_value(async_load, "event_type") == "gamepad lost")
{
	show_debug_message("Controller lost in slot " + string(ds_map_find_value(async_load, "pad_index")));
	
	var destroyedControllerId = -1;
	
	// Remove it from the list
	for (var i = 0; i < ds_list_size(controllers); i++;)
	{
		if (controllers[| i].controllerSlotID == string(ds_map_find_value(async_load, "pad_index")))
		{
			destroyedControllerId = controllers[| i].controllerInstance;
			instance_destroy(controllers[| i].controllerInstance);
			ds_list_delete(controllers, i);
		}
	}
	
	show_debug_message(string(ds_list_size(controllers)) + " controllers left");
	/*
	for (var ii = 0; ii < ds_list_size(controllers); ii++;)
	{
		show_debug_message(string(controllers[| ii].controllerInstance) + " type " + string(controllers[| ii].controllerType));
	}
	*/
	
	// Notify objects that controllers have been updated
	var objectsToRemove = [];

	for (var j = 0; j < ds_list_size(controllerUpdateNotifyList); j++;)
	{
		if (instance_exists(controllerUpdateNotifyList[| j]))
		{
			controllerUpdateNotifyList[| j].controllerUpdate(false, destroyedControllerId);
		}
		else
		{
			array_push(objectsToRemove, controllerUpdateNotifyList[| j]);
		}
	}

	// Remove objects from the notify list that do not exist anymore
	for (var k = 0; k < array_length(objectsToRemove); k++;)
	{
		var objectIndex = ds_list_find_index(controllerUpdateNotifyList, objectsToRemove[k]);
	
		ds_list_delete(controllerUpdateNotifyList, objectIndex);
	}
	
	//show_debug_message(string(ds_list_size(controllerUpdateNotifyList)) + " objects to update");
}


