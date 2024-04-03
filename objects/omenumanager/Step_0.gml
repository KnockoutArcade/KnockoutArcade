/// @description Insert description here
// You can write your code in this editor
var pressButton = keyboard_check(vk_anykey) || global.p1ButtonMenuPause;

startTextTimer++;

if (pressButton)
{
	room = rMainMenu;
}