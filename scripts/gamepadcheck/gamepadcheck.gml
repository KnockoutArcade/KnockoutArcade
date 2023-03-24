// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GamepadCheck(controllerSlot)
{
	if (gamepad_button_check_pressed(controllerSlot, gp_face1))
	{
		global.lastControllerButton = gp_face1;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_face2))
	{
		global.lastControllerButton = gp_face2;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_face3))
	{
		global.lastControllerButton = gp_face3;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_face4))
	{
		global.lastControllerButton = gp_face4;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_shoulderl))
	{
		global.lastControllerButton = gp_shoulderl;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_shoulderlb))
	{
		global.lastControllerButton = gp_shoulderlb;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_shoulderr))
	{
		global.lastControllerButton = gp_shoulderr;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_shoulderrb))
	{
		global.lastControllerButton = gp_shoulderrb;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_select))
	{
		global.lastControllerButton = gp_select;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_start))
	{
		global.lastControllerButton = gp_start;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_stickl))
	{
		global.lastControllerButton = gp_stickl;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_stickr))
	{
		global.lastControllerButton = gp_stickr;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_padu))
	{
		global.lastControllerButton = gp_padu;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_padd))
	{
		global.lastControllerButton = gp_padd;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_padl))
	{
		global.lastControllerButton = gp_padl;
		return true;
	}
	if (gamepad_button_check_pressed(controllerSlot, gp_padr))
	{
		global.lastControllerButton = gp_padr;
		return true;
	}
	var gamepadLHValue = gamepad_axis_value(controllerSlot, gp_axislh);
	if (gamepadLHValue > 0.2 || gamepadLHValue < -0.2)
	{
		global.lastControllerButton = gp_axislh;
		return true;
	}
	var gamepadRHValue = gamepad_axis_value(controllerSlot, gp_axisrh);
	if (gamepadRHValue > 0.2 || gamepadRHValue < -0.2)
	{
		global.lastControllerButton = gp_axisrh;
		return true;
	}
	var gamepadLVValue = gamepad_axis_value(controllerSlot, gp_axislv);
	if (gamepadLVValue > 0.2 || gamepadLVValue < -0.2)
	{
		global.lastControllerButton = gp_axislv;
		return true;
	}
	var gamepadRVValue = gamepad_axis_value(controllerSlot, gp_axisrv);
	if (gamepadRVValue > 0.2 || gamepadRVValue < -0.2)
	{
		global.lastControllerButton = gp_axisrv;
		return true;
	}
	
	return false;
}

function GamepadCodeIsAxis(buttonCode)
{
	switch (buttonCode)
	{
		case gp_axislh:
		case gp_axisrh:
		case gp_axislv:
		case gp_axisrv:
			return true;
		default:
			return false;
	}
}