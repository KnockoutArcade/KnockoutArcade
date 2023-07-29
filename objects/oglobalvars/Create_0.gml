/// @description Insert description here
// You can write your code in this editor

audio_group_load(audiogroup_soundeffect);
audio_group_load(audiogroup_music);

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

global.completedLevels = ds_list_create();

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