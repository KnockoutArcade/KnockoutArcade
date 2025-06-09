/// @description Insert description here
// You can write your code in this editor

screenTransitionType = eSCREENTRANSITIONS.WIPE;

enum eSCREENTRANSITIONS
{
	WIPE,
	FADE
}

// Vars dealing with screen fading
screenFadeTimer = 0;
screenFadeDuration = 100;
screenFadeDirection = 1; // 1 for fading in, 0 for holding, -1 for fading out
screenFadeHoldTimer = 0;
screenFadeHoldDuration = 30;
