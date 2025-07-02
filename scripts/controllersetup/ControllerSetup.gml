// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ControllerSetup(_list, _id, _controllerType)
{
	
	var controllerSlotData = {
		controllerInstance : instance_create_depth(0, 0, 0, oController),
		controllerSlotID : _id,
		controllerType : _controllerType,
	}
	
	with (controllerSlotData.controllerInstance)
	{
		// Assume player 1 as the default
		controlMappings = SetPlayerButtons(controlMappings, 0);
		
		// Controller Type
		controllerType = _controllerType;
		// Controller Slot
		controllerSlot = _id;
	}
	
	ds_list_add(_list, controllerSlotData);
}