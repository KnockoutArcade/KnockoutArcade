var P1menuUp = global.p1ButtonMenuUp;
var P1menuDown = global.p1ButtonMenuDown;
var P1menuConfirm = global.p1ButtonMenuConfirm;

if (screenTransitionObject != noone)
{
	P1menuUp = false;
	P1menuDown = false;
	P1menuConfirm = false;
	
	// Transition To other screens
	if (screenTransitionObject.image_index >= 15)
	{
		room_goto(roomToTransitionTo);
	}
	else
	{
		exit;
	}
}

menuCooldown--;

if (P1menuUp && menuCooldown < 1 )
{
	image_index--;
	menuCooldown = menuCooldownBuffer;
	drawInitialText = false;
	
	audio_play_sound(sfx_UI_Hover, 0, false);
} 
else if (P1menuDown == -1 && menuCooldown < 1)
{
	image_index++;
	menuCooldown = menuCooldownBuffer;
	drawInitialText = false;
	
	audio_play_sound(sfx_UI_Hover, 0, false);
}
else if (P1menuUp + P1menuDown == 0)
{
	menuCooldown = 0;
}

if (image_index == 0 && P1menuConfirm)
{
	audio_play_sound(sfx_UI_Select, 0, false);
	
	screenTransitionObject = instance_create_depth(0, 0, -10000, oScreenTransition);
	
	roomToTransitionTo = rCampaignFileSelect;
}

if (image_index == 1 && P1menuConfirm)
{
	
	// TEMPORARY DEBUG STUFF
	/*
	global.p1SelectedCharacter = oGunther;
	global.p2SelectedCharacter = oGunther;
	
	global.gameMode = GAMEMODE.VERSUS;
	
	room_goto(rJayStage);
	*/
	
	// ORIGINAL CODE - GO BACK TO THIS AFTER TESTING
	
	room_goto(rCharacterSelectScreen);
	
	audio_play_sound(sfx_UI_Select, 0, false);
}

if (image_index == 3 && P1menuConfirm)
{
	room_goto(rOptions);
	
	audio_play_sound(sfx_UI_Select, 0, false);
}

if (image_index == 4 && P1menuConfirm)
{
	room_goto(rCredits);
	
	audio_play_sound(sfx_UI_Select, 0, false);
}

// Testing out Single-Player Mechanics. This takes you to the test level
if (image_index == 2 && P1menuConfirm)
{
	global.gameMode = GAMEMODE.PLATFORMING;
	
	global.p1SelectedCharacter = oRussel;
	global.p1PaletteID = 0;
	
	global.p1StartingPositionX = 32;
	global.p1StartingPositionY = 0;
	
	room_goto(rPlatformingStage_Russel1);
	
	audio_play_sound(sfx_UI_Select, 0, false);
}

// Control Percy's Blinking
percyBlinkTimer++;
if (percyBlinkTimer >= percyEyesOpenTimerCap) && (!isPercyEyesClosed)
{
	percyBlinkTimer = 0;
	isPercyEyesClosed = true;
}
else if (percyBlinkTimer >= percyEyesClosedTimerCap) && (isPercyEyesClosed)
{
	percyBlinkTimer = 0;
	isPercyEyesClosed = false;
}

// Enable no-Numpad mode
if (keyboard_check_pressed(vk_backspace))
{
	if (global.noNumpadMode)
	{
		RestorePlayer2DefaultControls();
		global.noNumpadMode = false;
	}
	else
	{
		SetNoNumpadButtons();
		global.noNumpadMode = true;
	}
	
	audio_play_sound(sfx_UI_Select, 0, false);
}

