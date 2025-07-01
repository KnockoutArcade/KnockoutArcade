/// @description Controller Detection
// You can write your code in this editor


// Handle controller connect/disconnect
if (ds_map_find_value(async_load, "event_type") == "gamepad discovered")
{
	show_debug_message("Controller connected in slot " + string(ds_map_find_value(async_load, "pad_index")));
}

if (ds_map_find_value(async_load, "event_type") == "gamepad lost")
{
	show_debug_message("Controller lost in slot " + string(ds_map_find_value(async_load, "pad_index")));
}



