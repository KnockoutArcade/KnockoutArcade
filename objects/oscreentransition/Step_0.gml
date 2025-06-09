/// @description Insert description here
// You can write your code in this editor

depth = -10000;

if (image_index >= image_number - 1 && screenTransitionType == eSCREENTRANSITIONS.WIPE)
{
	instance_destroy();
}

if (screenTransitionType == eSCREENTRANSITIONS.FADE)
{
	// Update fade timers based off of which direction we should be fading (in, out, or hold)
	if (screenFadeDirection == 1)
	{
		screenFadeTimer++;
	}
	else if (screenFadeDirection == -1)
	{
		screenFadeTimer--;
	}
	else
	{
		screenFadeHoldTimer++;
	}
	
	// If we're done fading in, set state to hold
	if (screenFadeTimer >= screenFadeDuration && screenFadeDirection == 1)
	{
		screenFadeDirection = 0;
	}
	
	// If we're done holding, set state to fade out
	if (screenFadeDirection == 0 && screenFadeHoldTimer >= screenFadeHoldDuration)
	{
		screenFadeDirection = -1;
	}
	
	// If we're done fading out, die :)
	if (screenFadeDirection == -1 && screenFadeTimer <= 0)
	{
		instance_destroy();
		show_debug_message("Screen Transition Destroyed");
	}
}
