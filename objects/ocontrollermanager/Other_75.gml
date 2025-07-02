/// @description Controller Detection
// You can write your code in this editor


// Handle controller connect/disconnect
if (ds_map_find_value(async_load, "event_type") == "gamepad discovered")
{
	show_debug_message("Controller connected in slot " + string(ds_map_find_value(async_load, "pad_index")));
	
	ControllerSetup(controllers, ds_map_find_value(async_load, "pad_index"), CONTROLLER_TYPES.PAD);
	
	show_debug_message(string(ds_list_size(controllers)) + " controllers left");
}




if (ds_map_find_value(async_load, "event_type") == "gamepad lost")
{
	show_debug_message("Controller lost in slot " + string(ds_map_find_value(async_load, "pad_index")));
	
	// Remove it from the list
	for (var i = 0; i < ds_list_size(controllers); i++;)
	{
		if (controllers[| i].controllerSlotID == string(ds_map_find_value(async_load, "pad_index")))
		{
			instance_destroy(controllers[| i].controllerInstance);
			ds_list_delete(controllers, i);
		}
	}
	
	show_debug_message(string(ds_list_size(controllers)) + " controllers left");
}



