// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function FindController(_slotToFind)
{
	for (var i = 0; i < ds_list_size(oControllerManager.controllers); i++;)
	{
		if (oControllerManager.controllers[| i].controllerSlotID == _slotToFind)
		{
			return oControllerManager.controllers[| i].controllerInstance;
		}
	}
	
	return -1;
}