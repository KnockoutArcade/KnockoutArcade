/// @description Insert description here
// You can write your code in this editor

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


