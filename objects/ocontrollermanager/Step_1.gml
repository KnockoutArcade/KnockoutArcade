/// @description Insert description here
// You can write your code in this editor

// Iterate through each active controller and make sure it's using the correct button mappings
for (var i = 0; i < ds_list_size(controllers); i++;)
{
	if (controllers[| i].controllerSlotID == global.player1ControllerSlot)
	{
		controllers[| i].controllerInstance.controlMappings = SetPlayerButtons(controllers[| i].controllerInstance.controlMappings, 0);
	}
	
	if (controllers[| i].controllerSlotID == global.player2ControllerSlot)
	{
		controllers[| i].controllerInstance.controlMappings = SetPlayerButtons(controllers[| i].controllerInstance.controlMappings, 1);
	}
}

