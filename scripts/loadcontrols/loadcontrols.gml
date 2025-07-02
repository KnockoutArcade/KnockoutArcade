// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function LoadControls()
{
	if (file_exists("1PlayerControls.save"))
	{
		var controlBuffer = buffer_load("1PlayerControls.save");
		var controlString = buffer_read(controlBuffer, buffer_string);
		buffer_delete(controlBuffer);
		
		var loadedControls = json_parse(controlString);
		
		global.player1Controls = loadedControls;
		
		
		if (!variable_struct_exists(global.player1Controls, "versionNumber") || global.player1Controls.versionNumber < 2)
		{
			RestorePlayer1DefaultControls();
			SaveControls();
	
			show_debug_message("Updated old control data");
		}
	}
	else
	{
		RestorePlayer1DefaultControls();
		
		SaveControls();
	}
	
	if (file_exists("2PlayerControls.save"))
	{
		var p2controlBuffer = buffer_load("2PlayerControls.save");
		var p2controlString = buffer_read(p2controlBuffer, buffer_string);
		buffer_delete(p2controlBuffer);
		
		var p2loadedControls = json_parse(p2controlString);
		
		global.player2Controls = p2loadedControls;
		
		
		if (!variable_struct_exists(global.player2Controls, "versionNumber") || global.player2Controls.versionNumber < 2)
		{
			RestorePlayer2DefaultControls();
			SaveControls();
	
			show_debug_message("Updated old control data");
		}
	}
	else
	{
		RestorePlayer2DefaultControls();
		
		SaveControls();
	}
}