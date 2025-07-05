/// @description Insert description here
// You can write your code in this editor

if (controllerSlot != -1)
{
	var assignedController = FindController(controllerSlot);
	
	if (assignedController != -1)
	{
		menuLeft = assignedController.buttonMenuLeft;
		menuRight = assignedController.buttonMenuRight;
		menuColMove = menuLeft + menuRight;

		menuUp = assignedController.buttonMenuUp;
		menuDown = assignedController.buttonMenuDown;
		menuRowMove = menuUp + menuDown;

		menuConfirmA = assignedController.buttonMenuConfirm_hold;
		menuCancelB = assignedController.buttonMenuDeny_hold;
		menuSwitchX = assignedController.buttonMenuSwitch_hold;
		menuChangeControlsY = assignedController.buttonMenuSetControls_hold;
	
		menuPageRightRB = assignedController.buttonMenuPageRight_hold;
		menuTriggerRightRT = assignedController.buttonMenuTriggerRight_hold;
	}
}
else if (useAllControllers)
{
	var allPlayersControls = {
		menuLeft : false,
		menuRight : false,
			
		menuUp : false,
		menuDown : false,
			
		menuConfirmA : false,
		menuCancelB : false,
		menuSwitchX : false,
		menuChangeControlsY : false,
		menuPageRightRB : false,
		menuTriggerRightRT : false
	}

	// For each input, if any controller is pressing that button, set that button to true
	for (var i = 0; i < ds_list_size(oControllerManager.controllers); i++;)
	{
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuLeft == -1) allPlayersControls.menuLeft = oControllerManager.controllers[| i].controllerInstance.buttonMenuLeft;
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuRight) allPlayersControls.menuRight = oControllerManager.controllers[| i].controllerInstance.buttonMenuRight;
		
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuUp) allPlayersControls.menuUp = oControllerManager.controllers[| i].controllerInstance.buttonMenuUp;
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuDown == -1) allPlayersControls.menuDown = oControllerManager.controllers[| i].controllerInstance.buttonMenuDown;
		
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuConfirm_hold) allPlayersControls.menuConfirmA = true;
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuDeny_hold) allPlayersControls.menuCancelB = true;
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuSwitch_hold) allPlayersControls.menuSwitchX = true;
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuSetControls_hold) allPlayersControls.menuChangeControlsY = true;
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuPageRight_hold) allPlayersControls.menuPageRightRB = true;
		if (oControllerManager.controllers[| i].controllerInstance.buttonMenuTriggerRight_hold) allPlayersControls.menuTriggerRightRT = true;
	}
	
	menuLeft = allPlayersControls.menuLeft;
	menuRight = allPlayersControls.menuRight;
	menuColMove = menuLeft + menuRight;

	menuUp = allPlayersControls.menuUp;
	menuDown = allPlayersControls.menuDown;
	menuRowMove = menuUp + menuDown;

	menuConfirmA = allPlayersControls.menuConfirmA;
	menuCancelB = allPlayersControls.menuCancelB;
	menuSwitchX = allPlayersControls.menuSwitchX;
	menuChangeControlsY = allPlayersControls.menuChangeControlsY;
	
	menuPageRightRB = allPlayersControls.menuPageRightRB;
	menuTriggerRightRT = allPlayersControls.menuTriggerRightRT;
}

/*
if (playerNumber == 0)
{
	// Player 1 input vars
	menuLeft = global.p1ButtonMenuLeft;
	menuRight = global.p1ButtonMenuRight;
	menuColMove = menuLeft + menuRight;

	menuUp = global.p1ButtonMenuUp;
	menuDown = global.p1ButtonMenuDown;
	menuRowMove = menuUp + menuDown;

	menuConfirmA = global.p1ButtonMenuConfirm_Hold;
	menuCancelB = global.p1ButtonMenuDeny_Hold;
	menuSwitchX = global.p1ButtonMenuSwitch_Hold;
	menuChangeControlsY = global.p1ButtonMenuSetControls_Hold;
	
	menuPageRightRB = global.p1ButtonMenuPageRight_Hold;
	menuTriggerRightRT = global.p1ButtonMenuTriggerRight_Hold;
}
else
{
	// Player 2 input vars
	menuLeft = global.p2ButtonMenuLeft;
	menuRight = global.p2ButtonMenuRight;
	menuColMove = menuLeft + menuRight;

	menuUp = global.p2ButtonMenuUp;
	menuDown = global.p2ButtonMenuDown;
	menuRowMove = menuUp + menuDown;

	menuConfirmA = global.p2ButtonMenuConfirm_Hold;
	menuCancelB = global.p2ButtonMenuDeny_Hold;
	menuSwitchX = global.p2ButtonMenuSwitch_Hold;
	menuChangeControlsY = global.p2ButtonMenuSetControls_Hold;
	
	menuPageRightRB = global.p2ButtonMenuPageRight_Hold;
	menuTriggerRightRT = global.p2ButtonMenuTriggerRight_Hold;
}


