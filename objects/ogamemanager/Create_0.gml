/// @description Insert description here
// You can write your code in this editor

global.frameskip = 0;
global.game_paused = 0;
global.freezeTimer = false; // For SCREEN_FREEZE

global.hitstop = 0;

global.toggleHitboxVisibility = false;

global.currentRound = 0;

global.hasCompletedIntros = false;

p1 = noone;
p2 = noone;
global.camObj = noone;

healthbar1 = noone;
healthbar1 = noone;
TimerObject = noone;
hudObject = noone;

calculateFrameData = false;
frameAdvantage = 0;
victim = 0;
nonVictim = 0;

SetupGame();

global.p1Rounds = 0;
p1RoundCounter = instance_create_layer(70, 4, "UI", oRoundCounter);
with (p1RoundCounter) 
{
	owner = 1;
	ui_xOffset = 70;
}

global.p2Rounds = 0;
p2RoundCounter = instance_create_layer(90, 4, "UI", oRoundCounter);
with (p2RoundCounter) 
{
	image_xscale = -1;
	owner = 2;
	ui_xOffset = 90;
}
