// Find the first controller
var slot0Controller = FindController(0); // Find the first gamepad ID
var wasdController = FindController(13); // Find the WASD controller object

// Both the first controller slot and the WASD controller can control the title screen

// initialize the inputs
var P1menuUp = 0;
var P1menuDown = 0;
var P1menuConfirm = 0;

// Handle detecting controller inputs
if (slot0Controller != -1)
{
	if (slot0Controller.buttonMenuConfirm)
	{
		P1menuConfirm = true;
	}
	
	if (slot0Controller.buttonMenuUp)
	{
		P1menuUp = 1;
	}
	
	if (slot0Controller.buttonMenuDown == -1)
	{
		P1menuDown = -1;
	}
}
// Handle detecting WASD inputs
if (wasdController != -1)
{
	if (wasdController.buttonMenuConfirm)
	{
		P1menuConfirm = true;
	}
	
	if (wasdController.buttonMenuUp)
	{
		P1menuUp = 1;
	}
	
	if (wasdController.buttonMenuDown == -1)
	{
		P1menuDown = -1;
	}
}


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
else if (P1menuUp == 0 && P1menuDown == 0)
{
	menuCooldown = 0;
}

if (image_index == 0 && P1menuConfirm)
{
	audio_play_sound(sfx_UI_Select, 0, false);
	
	screenTransitionObject = instance_create_depth(0, 0, -10000, oScreenTransition);
	
	roomToTransitionTo = rCampaignFileSelect;
	audio_sound_gain(bgm_MainMenu, 0, 750);
	global.currentBGM = bgm_Russel_Stage;
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
	global.gameMode = GAMEMODE.VERSUS;
	room_goto(rCharacterSelectScreen);
	
	audio_play_sound(sfx_UI_Select, 0, false);
	
	audio_stop_sound(bgm_MainMenu);
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

// Training
if (image_index == 2 && P1menuConfirm)
{
	global.gameMode = GAMEMODE.TRAINING;
	
	room_goto(rCharacterSelectScreen);
	
	audio_play_sound(sfx_UI_Select, 0, false);
	
	audio_stop_sound(bgm_MainMenu);
	/*
	global.gameMode = GAMEMODE.PLATFORMING;
	
	global.currentBGM = bgm_Russel_Stage;
	
	global.p1SelectedCharacter = oRussel;
	global.p1PaletteID = 0;
	
	global.p1StartingPositionX = 32;
	global.p1StartingPositionY = 104; // Set back to 0 when testing other levels
	//global.p1StartingPositionY = 552; // Set back to 0 when testing other levels
	
	// Set up controller
	if (slot0Controller != -1 && slot0Controller.buttonMenuConfirm)
	{
		global.player1ControllerSlot = 0;
	}
	else
	{
		global.player1ControllerSlot = 13;
	}
	
	room_goto(rLevelTransitionTest1);
	
	audio_play_sound(sfx_UI_Select, 0, false);
	audio_stop_sound(bgm_MainMenu);
	*/
	
	
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
/*
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

