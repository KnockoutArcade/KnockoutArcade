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

// Command List
commandListCurrentTab = 0; // Which tab of the command list we are on (ranges from 0 - 3)
commandListMaxTabs = 4; // The maximum number of tabs on the command list
commandListCurrentPage = 0; // Which "page" of a tab we are currently on
commandListCharacter = 0; // Which Character's command list to show
// 0 = Russel
// 1 = Beverly
// anything else = TBD page;

// Options
audio_group_set_gain(audiogroup_music, global.musicVolume, 0); // Set the volume
optionsMusicVolume = global.musicVolume; // Store our current volume
audio_group_set_gain(audiogroup_soundeffect, global.sfxVolume, 0);
optionsSFXVolume = global.sfxVolume;
audio_group_set_gain(audiogroup_voices, global.voicesVolume, 0);
optionsVoicesVolume = global.voicesVolume;