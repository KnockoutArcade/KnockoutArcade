// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetPlayerInputs() 
{
	// This code handles all of the inputs for the game
	// Left and Down return -1 instead of 1 because they are the opposite directions
	if (global.player1ControllerType == "KEYBOARD") 
	{
		global.p1ButtonLeft = keyboard_check(global.player1Controls.buttonLeft) * -1;
		global.p1ButtonRight = keyboard_check(global.player1Controls.buttonRight);
		global.p1ButtonUp = keyboard_check(global.player1Controls.buttonUp);
		global.p1ButtonDown = keyboard_check(global.player1Controls.buttonDown) * -1;
		global.p1ButtonLight = keyboard_check_pressed(global.player1Controls.buttonLight);
		global.p1ButtonMedium = keyboard_check_pressed(global.player1Controls.buttonMedium);
		global.p1ButtonHeavy = keyboard_check_pressed(global.player1Controls.buttonHeavy);
		global.p1ButtonGrab = keyboard_check_pressed(global.player1Controls.buttonGrab);
		global.p1ButtonSpecial = keyboard_check_pressed(global.player1Controls.buttonSpecial);
		global.p1ButtonSuper = keyboard_check_pressed(global.player1Controls.buttonSuper);
		global.p1ButtonRun = keyboard_check_pressed(global.player1Controls.buttonRun);
	} 
	else
	{
		global.p1ButtonLeft = (gamepad_axis_value(global.player1ControllerSlot, global.player1Controls.buttonLeft) < -.2) * -1;
		global.p1ButtonRight = (gamepad_axis_value(global.player1ControllerSlot, global.player1Controls.buttonRight) > .2);
		global.p1ButtonUp = (gamepad_axis_value(global.player1ControllerSlot, global.player1Controls.buttonUp) < -.4);
		global.p1ButtonDown = (gamepad_axis_value(global.player1ControllerSlot, global.player1Controls.buttonDown) > .4) * -1;
		global.p1ButtonLight = gamepad_button_check_pressed(global.player1ControllerSlot, global.player1Controls.buttonLight);
		global.p1ButtonMedium = gamepad_button_check_pressed(global.player1ControllerSlot, global.player1Controls.buttonMedium);
		global.p1ButtonHeavy = gamepad_button_check_pressed(global.player1ControllerSlot, global.player1Controls.buttonHeavy);
		global.p1ButtonGrab = gamepad_button_check_pressed(global.player1ControllerSlot, global.player1Controls.buttonGrab);
		global.p1ButtonSpecial = gamepad_button_check_pressed(global.player1ControllerSlot, global.player1Controls.buttonSpecial);
		global.p1ButtonSuper = gamepad_button_check_pressed(global.player1ControllerSlot, global.player1Controls.buttonSuper);
		global.p1ButtonRun = gamepad_button_check(global.player1ControllerSlot, global.player1Controls.buttonRun);
	};

	if global.player2ControllerType = "KEYBOARD" {
		global.p2ButtonLeft = keyboard_check(global.player2Controls.buttonLeft) * -1;
		global.p2ButtonRight = keyboard_check(global.player2Controls.buttonRight);
		global.p2ButtonUp = keyboard_check(global.player2Controls.buttonUp);
		global.p2ButtonDown = keyboard_check(global.player2Controls.buttonDown) * -1;
		global.p2ButtonLight = keyboard_check_pressed(global.player2Controls.buttonLight);
		global.p2ButtonMedium = keyboard_check_pressed(global.player2Controls.buttonMedium);
		global.p2ButtonHeavy = keyboard_check_pressed(global.player2Controls.buttonHeavy);
		global.p2ButtonGrab = keyboard_check_pressed(global.player2Controls.buttonGrab);
		global.p2ButtonSpecial = keyboard_check_pressed(global.player2Controls.buttonSpecial);
		global.p2ButtonSuper = keyboard_check_pressed(global.player2Controls.buttonSuper);
		global.p2ButtonRun = keyboard_check_pressed(global.player2Controls.buttonRun);
	} 
	else 
	{
		global.p2ButtonLeft = (gamepad_axis_value(global.player2ControllerSlot, global.player2Controls.buttonLeft) < -.2) * -1;
		global.p2ButtonRight = (gamepad_axis_value(global.player2ControllerSlot, global.player2Controls.buttonRight) > .2);
		global.p2ButtonUp = (gamepad_axis_value(global.player2ControllerSlot, global.player2Controls.buttonUp) < -.4);
		global.p2ButtonDown = (gamepad_axis_value(global.player2ControllerSlot, global.player2Controls.buttonDown) > .4) * -1;
		global.p2ButtonLight = gamepad_button_check_pressed(global.player2ControllerSlot, global.player2Controls.buttonLight);
		global.p2ButtonMedium = gamepad_button_check_pressed(global.player2ControllerSlot, global.player2Controls.buttonMedium);
		global.p2ButtonHeavy = gamepad_button_check_pressed(global.player2ControllerSlot, global.player2Controls.buttonHeavy);
		global.p2ButtonGrab = gamepad_button_check_pressed(global.player2ControllerSlot, global.player2Controls.buttonGrab);
		global.p2ButtonSpecial = gamepad_button_check_pressed(global.player2ControllerSlot, global.player2Controls.buttonSpecial);
		global.p2ButtonSuper = gamepad_button_check_pressed(global.player2ControllerSlot, global.player2Controls.buttonSuper);
		global.p2ButtonRun = gamepad_button_check(global.player2ControllerSlot, global.player2Controls.buttonRun);
	};

}