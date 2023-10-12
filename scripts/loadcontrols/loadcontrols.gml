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
	}
	
	if (file_exists("2PlayerControls.save"))
	{
		var controlBuffer = buffer_load("2PlayerControls.save");
		var controlString = buffer_read(controlBuffer, buffer_string);
		buffer_delete(controlBuffer);
		
		var loadedControls = json_parse(controlString);
		
		global.player2Controls = loadedControls;
	}
}