/// @description Insert description here
// You can write your code in this editor

initInteractScreenTimer++;

if (initInteractScreenTimer == initInteractScreenTransitionPoint)
{
	var transitionScreen = instance_create_depth(0, 0, -10000, oScreenTransition);
	
	with (transitionScreen)
	{
		screenTransitionType = eSCREENTRANSITIONS.FADE;
		screenFadeDuration = 45;
		screenFadeHoldDuration = 15;
	}
}

if (initInteractScreenTimer == initInteractScreenSoundPoint)
{
	audio_play_sound(sfx_CharSel_Ready, 0, false);
}

if (initInteractScreenTimer >= initInteractScreenDuration)
{
	room_goto(rTitleScreen);
}

if (image_index > image_number - 1)
{
	image_speed = 0;
}

