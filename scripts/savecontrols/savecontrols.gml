// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SaveControls()
{
	var savedControls = json_stringify(global.player1Controls);
	
	var controlBuffer = buffer_create(string_byte_length(savedControls) + 1, buffer_fixed, 1);
	
	buffer_write(controlBuffer, buffer_string, savedControls);
	buffer_save(controlBuffer, "1PlayerControls.save");
	buffer_delete(controlBuffer);
}