/// @description Insert description here
// You can write your code in this editor

var slot0Controller = FindController(0); // Find the first gamepad ID

var controllerAnyButton = false;

if (slot0Controller != -1)
{
	controllerAnyButton = GamepadCheck(slot0Controller.controllerSlot);
}

var pressButton = keyboard_check(vk_anykey) || controllerAnyButton;

if (pressButton && isAcceptingInputs)
{
	room = rMainMenu;
	exit;
}


animTimer++;

if (animTimer > logoAppearEnd)
{
	isAcceptingInputs = true;
}
