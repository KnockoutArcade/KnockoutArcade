// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SaveControls()
{
	// Save Player 1 Controls
	var savedControls = json_stringify(global.player1Controls);
	
	var controlBuffer = buffer_create(string_byte_length(savedControls) + 1, buffer_fixed, 1);
	
	buffer_write(controlBuffer, buffer_string, savedControls);
	buffer_save(controlBuffer, "1PlayerControls.save");
	buffer_delete(controlBuffer);
	
	// Save Player 2 Controls
	var p2savedControls = json_stringify(global.player2Controls);
	
	var p2controlBuffer = buffer_create(string_byte_length(p2savedControls) + 1, buffer_fixed, 1);
	
	buffer_write(p2controlBuffer, buffer_string, p2savedControls);
	buffer_save(p2controlBuffer, "2PlayerControls.save");
	buffer_delete(p2controlBuffer);
}