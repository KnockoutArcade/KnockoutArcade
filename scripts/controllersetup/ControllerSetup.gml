// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ControllerSetup(){
	// This script sets the player's controls according to the type of input device they're using,
	// and also sets the buttons to default controls.
	
	global.player1ControllerSlot = -1;
	global.player2ControllerSlot = -1;
	
	global.player1ControllerType = "KEYBOARD";
	global.player2ControllerType = "KEYBOARD";
	
	var gp_num = gamepad_get_device_count();
	var numOfControllers = 0;
	for (var i = 0; i < gp_num; i++;)	
	{
	    if gamepad_is_connected(i) {
			numOfControllers++;
			if numOfControllers == 0 {
				global.player1ControllerType = "KEYBOARD";
				global.player2ControllerType = "KEYBOARD";
				
				SetPlayerButtons();
			}
			if numOfControllers == 1 {
				global.player1ControllerSlot = i;
				global.player1ControllerType = "PAD";
				global.player2ControllerType = "KEYBOARD";
				
				SetPlayerButtons();
			}
			if numOfControllers == 2 {
				global.player2ControllerSlot = i;
				global.player2ControllerType = "PAD";
				
				SetPlayerButtons();
			}
		}
	}
}