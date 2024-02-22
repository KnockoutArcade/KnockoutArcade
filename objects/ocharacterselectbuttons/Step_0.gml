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

	menuConfirmA = global.p1ButtonMenuConfirm;
	menuCancelB = global.p1ButtonMenuDeny;
	menuSwitchX = global.p1ButtonMenuSwitch;
	menuChangeControlsY = global.p1ButtonMenuSetControls;
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

	menuConfirmA = global.p2ButtonMenuConfirm;
	menuCancelB = global.p2ButtonMenuDeny;
	menuSwitchX = global.p2ButtonMenuSwitch;
	menuChangeControlsY = global.p2ButtonMenuSetControls;
}


