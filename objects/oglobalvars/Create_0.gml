/// @description Insert description here
// You can write your code in this editor

audio_group_load(audiogroup_soundeffect);
audio_group_load(audiogroup_music);
audio_group_load(audiogroup_voices);

global.p1PaletteID = 0;
global.p2PaletteID = 1;

global.p1SelectedCharacter = 0;
global.p2SelectedCharacter = 0;

global.gameMode = 0;

// Where to start in a single player level
global.p1StartingPositionX = 32;
global.p1StartingPositionY = 104;

// Where to put the player on the campaign map
global.campaignMapLocationX = 0;
global.campaignMapLocationY = 0;

// What room to put the player in after exiting a singleplayer level
global.campaignMapRoom = 0;

// How long until the level start text appears
global.campaignStartLevelDelay = 0;

// How much money the player has earned in the most recent level
global.campaignMoneyScore = 0;
global.campaignTimeScore = 0;

// List of comleted levels
global.completedLevels = ds_list_create();

// Trigger for end of level sequence
global.hasCompletedLevel = false;

// Rush Cancel global variables (both players use them)
global.rcForwardSpeed = 4;
global.rcForwardDuration = 12;
global.rcUpSpeed = 5;
global.rcUpForwardSpeed = 2;
global.rcUpFallSpeed = 0.4;
global.rcAirSpeed = 10;
global.rcAirHorizontalSpeed = 2;

// Volume Vars
global.musicVolume = 0.5;
global.sfxVolume = 0.5;
global.voicesVolume = 0.5;