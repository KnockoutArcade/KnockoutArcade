/// @description Insert description here
// You can write your code in this editor

owner = noone; // The object that spawned this menu

playerNumber = 0; // Which player is responsible for pausing (0 = player 1, 1 = player 2)

state = ePauseMenuState.MAIN;
areYouSureAction = eAreYouSureAction.RESTART; // What to do after selecting "Yes" on Are You Sure?

enum ePauseMenuState
{
	MAIN,
	COMMAND_LISTS,
	OPTIONS,
	ARE_YOU_SURE
}

enum eAreYouSureAction
{
	RESTART,
	CHARACTER_SELECT,
	MAIN_MENU
}

cursorCooldown = 0; // The cooldown on the cursor
cursorCooldownAmount = 13; // How long a direction must be held in order to keep moving the cursor

currentRow = 0; // Which row we are on
previousRow = 0; // The previous row we were highlighting before entering the most recent state

mainRowMax = 6; // How many rows are on the main pause menu
optionsRowMax = 6; // How many rows are on the options menu
areYouSureRowMax = 2; // How many rows are on the Are You Sure? screen