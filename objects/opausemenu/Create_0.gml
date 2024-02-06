/// @description Insert description here
// You can write your code in this editor

playerNumber = 0; // Which player is responsible for pausing (0 = player 1, 1 = player 2)

state = ePauseMenuState.MAIN;

enum ePauseMenuState
{
	MAIN,
	COMMAND_LISTS,
	OPTIONS,
	ARE_YOU_SURE
}

