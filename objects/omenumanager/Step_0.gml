/// @description Insert description here
// You can write your code in this editor

// Hack-y way of disabling this object when the game is going into attract mode
if (instance_exists(oAttractMode) && oAttractMode.screenTransitionObject != noone)
{
	exit;
}

var slot0Controller = FindController(0); // Find the first gamepad ID

var controllerAnyButton = false;

if (slot0Controller != -1)
{
	controllerAnyButton = GamepadCheck(slot0Controller.controllerSlot);
}

var pressButton = keyboard_check(vk_anykey) || controllerAnyButton;

animTimer++;

if (!isTransitioning)
{
	if (pressButton && isAcceptingInputs)
	{
		isTransitioning = true;
		animTimer = 0;
	
		var transitionScreen = instance_create_depth(0, 0, -10000, oScreenTransition);
	
		with (transitionScreen)
		{
			screenTransitionType = eSCREENTRANSITIONS.WIPE;
		}
	
		audio_sound_gain(bgm_TitleScreen, 0, 750);
		audio_play_sound(sfx_UI_Select, 1, false);
		exit;
	}
	
	if (animTimer == musicStart)
	{
		audio_sound_gain(bgm_TitleScreen, global.musicVolume, 0);
		audio_play_sound(bgm_TitleScreen, 0, false);
	}
	
	if (animTimer > logoAppearEnd)
	{
		isAcceptingInputs = true;
	}
}
else
{	
	if (animTimer == titleTransitionPoint)
	{
		room_goto(rMainMenu);
		audio_stop_sound(bgm_TitleScreen);
	}
}





