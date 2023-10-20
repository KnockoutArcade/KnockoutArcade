// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetPlayerInputs() 
{
	// This code handles all of the inputs for the game
	// Left and Down return -1 instead of 1 because they are the opposite directions
	if (global.player1ControllerType == "KEYBOARD") 
	{
		global.p1ButtonLeft = keyboard_check(global.player1Controls.Keyboard.buttonLeft) * -1;
		global.p1ButtonRight = keyboard_check(global.player1Controls.Keyboard.buttonRight);
		global.p1ButtonUp = keyboard_check(global.player1Controls.Keyboard.buttonUp);
		global.p1ButtonDown = keyboard_check(global.player1Controls.Keyboard.buttonDown) * -1;
		global.p1ButtonLight = keyboard_check_pressed(global.player1Controls.Keyboard.buttonLight);
		global.p1ButtonMedium = keyboard_check_pressed(global.player1Controls.Keyboard.buttonMedium);
		global.p1ButtonHeavy = keyboard_check_pressed(global.player1Controls.Keyboard.buttonHeavy);
		global.p1ButtonGrab = keyboard_check_pressed(global.player1Controls.Keyboard.buttonGrab);
		global.p1ButtonSpecial = keyboard_check_pressed(global.player1Controls.Keyboard.buttonSpecial);
		global.p1ButtonSuper = keyboard_check_pressed(global.player1Controls.Keyboard.buttonSuper);
		global.p1ButtonRun = keyboard_check(global.player1Controls.Keyboard.buttonRun);
		
		// Menu Controls
		global.p1ButtonMenuLeft = keyboard_check(global.player1Controls.Keyboard.buttonMenuLeft) * -1;
		global.p1ButtonMenuRight = keyboard_check(global.player1Controls.Keyboard.buttonMenuRight);
		global.p1ButtonMenuUp = keyboard_check(global.player1Controls.Keyboard.buttonMenuUp);
		global.p1ButtonMenuDown = keyboard_check(global.player1Controls.Keyboard.buttonMenuDown) * -1;
		global.p1ButtonMenuConfirm = keyboard_check(global.player1Controls.Keyboard.buttonMenuConfirm) * -1;
		global.p1ButtonMenuDeny = keyboard_check(global.player1Controls.Keyboard.buttonMenuDeny) * -1;
	} 
	else
	{
		if (GamepadCodeIsAxis(global.player1Controls.Controller.buttonLeft))
		{
			global.p1ButtonLeft = (gamepad_axis_value(global.player1ControllerSlot, global.player1Controls.Controller.buttonLeft) < -.25) * -1;
		}
		else
		{
			global.p1ButtonLeft = gamepad_button_check(global.player1ControllerSlot, global.player1Controls.Controller.buttonLeft) * -1;
		}
		if (GamepadCodeIsAxis(global.player1Controls.Controller.buttonRight))
		{
			global.p1ButtonRight = (gamepad_axis_value(global.player1ControllerSlot, global.player1Controls.Controller.buttonRight) > .25);
		}
		else
		{
			global.p1ButtonRight = gamepad_button_check(global.player1ControllerSlot, global.player1Controls.Controller.buttonRight);
		}
		if(GamepadCodeIsAxis(global.player1Controls.Controller.buttonUp))
		{
			global.p1ButtonUp = (gamepad_axis_value(global.player1ControllerSlot, global.player1Controls.Controller.buttonUp) < -.25);
		}
		else
		{
			global.p1ButtonUp = gamepad_button_check(global.player1ControllerSlot, global.player1Controls.Controller.buttonUp);
		}
		if(GamepadCodeIsAxis(global.player1Controls.Controller.buttonDown))
		{
			global.p1ButtonDown = (gamepad_axis_value(global.player1ControllerSlot, global.player1Controls.Controller.buttonDown) > .25) * -1;
		}
		else
		{
			global.p1ButtonDown = gamepad_button_check(global.player1ControllerSlot, global.player1Controls.Controller.buttonDown) * -1;
		}
		global.p1ButtonLight = gamepad_button_check_pressed(global.player1ControllerSlot, global.player1Controls.Controller.buttonLight);
		global.p1ButtonMedium = gamepad_button_check_pressed(global.player1ControllerSlot, global.player1Controls.Controller.buttonMedium);
		global.p1ButtonHeavy = gamepad_button_check_pressed(global.player1ControllerSlot, global.player1Controls.Controller.buttonHeavy);
		global.p1ButtonGrab = gamepad_button_check_pressed(global.player1ControllerSlot, global.player1Controls.Controller.buttonGrab);
		global.p1ButtonSpecial = gamepad_button_check_pressed(global.player1ControllerSlot, global.player1Controls.Controller.buttonSpecial);
		global.p1ButtonSuper = gamepad_button_check_pressed(global.player1ControllerSlot, global.player1Controls.Controller.buttonSuper);
		global.p1ButtonRun = gamepad_button_check(global.player1ControllerSlot, global.player1Controls.Controller.buttonRun);
	};

	if global.player2ControllerType = "KEYBOARD" {
		global.p2ButtonLeft = keyboard_check(global.player2Controls.Keyboard.buttonLeft) * -1;
		global.p2ButtonRight = keyboard_check(global.player2Controls.Keyboard.buttonRight);
		global.p2ButtonUp = keyboard_check(global.player2Controls.Keyboard.buttonUp);
		global.p2ButtonDown = keyboard_check(global.player2Controls.Keyboard.buttonDown) * -1;
		global.p2ButtonLight = keyboard_check_pressed(global.player2Controls.Keyboard.buttonLight);
		global.p2ButtonMedium = keyboard_check_pressed(global.player2Controls.Keyboard.buttonMedium);
		global.p2ButtonHeavy = keyboard_check_pressed(global.player2Controls.Keyboard.buttonHeavy);
		global.p2ButtonGrab = keyboard_check_pressed(global.player2Controls.Keyboard.buttonGrab);
		global.p2ButtonSpecial = keyboard_check_pressed(global.player2Controls.Keyboard.buttonSpecial);
		global.p2ButtonSuper = keyboard_check_pressed(global.player2Controls.Keyboard.buttonSuper);
		global.p2ButtonRun = keyboard_check(global.player2Controls.Keyboard.buttonRun);
	} 
	else 
	{
		if (GamepadCodeIsAxis(global.player2Controls.Controller.buttonLeft))
		{
			global.p2ButtonLeft = (gamepad_axis_value(global.player2ControllerSlot, global.player2Controls.Controller.buttonLeft) < -.4) * -1;
		}
		else
		{
			global.p2ButtonLeft = gamepad_button_value(global.player2ControllerSlot, global.player2Controls.Controller.buttonLeft) * -1;
			show_debug_message(global.p2ButtonLeft);
		}
		if (GamepadCodeIsAxis(global.player2Controls.Controller.buttonRight))
		{
			global.p2ButtonRight = (gamepad_axis_value(global.player2ControllerSlot, global.player2Controls.Controller.buttonRight) > .4);
		}
		else
		{
			global.p2ButtonRight = gamepad_button_value(global.player2ControllerSlot, global.player2Controls.Controller.buttonRight);
		}
		if (GamepadCodeIsAxis(global.player2Controls.Controller.buttonUp))
		{
			global.p2ButtonUp = (gamepad_axis_value(global.player2ControllerSlot, global.player2Controls.Controller.buttonUp) < -.4);
		}
		else
		{
			global.p2ButtonUp = gamepad_button_value(global.player2ControllerSlot, global.player2Controls.Controller.buttonUp);
		}
		if (GamepadCodeIsAxis(global.player2Controls.Controller.buttonDown))
		{
			global.p2ButtonDown = (gamepad_axis_value(global.player2ControllerSlot, global.player2Controls.Controller.buttonDown) > .4) * -1;
		}
		else
		{
			global.p2ButtonDown = gamepad_button_value(global.player2ControllerSlot, global.player2Controls.Controller.buttonDown) * -1;
		}
		global.p2ButtonLight = gamepad_button_check_pressed(global.player2ControllerSlot, global.player2Controls.Controller.buttonLight);
		global.p2ButtonMedium = gamepad_button_check_pressed(global.player2ControllerSlot, global.player2Controls.Controller.buttonMedium);
		global.p2ButtonHeavy = gamepad_button_check_pressed(global.player2ControllerSlot, global.player2Controls.Controller.buttonHeavy);
		global.p2ButtonGrab = gamepad_button_check_pressed(global.player2ControllerSlot, global.player2Controls.Controller.buttonGrab);
		global.p2ButtonSpecial = gamepad_button_check_pressed(global.player2ControllerSlot, global.player2Controls.Controller.buttonSpecial);
		global.p2ButtonSuper = gamepad_button_check_pressed(global.player2ControllerSlot, global.player2Controls.Controller.buttonSuper);
		global.p2ButtonRun = gamepad_button_check(global.player2ControllerSlot, global.player2Controls.Controller.buttonRun);
	};
}