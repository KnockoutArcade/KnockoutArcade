/// @description Insert description here
// You can write your code in this editor
var pressButton = keyboard_check(vk_anykey) || gamepad_button_check(global.player1ControllerSlot, gp_start);

startTextTimer++;

if (pressButton)
{
	room = rMainMenu;
}