/// @description Insert description here
// You can write your code in this editor
if (!audio_is_playing(bgm_VictoryScreen_Russel) && !audio_is_playing(bgm_VictoryScreen_Loop))
{
	audio_play_sound(bgm_VictoryScreen_Loop, 0, true);
}

animTimer++;
returnToMainMenuTimer++;

if (keyboard_check(vk_anykey)) returnToMainMenuTimer = 0;

for (var i = 0; i < gamepad_get_device_count(); i++)
{
	for (var j = gp_face1; j < gp_axisrv; j++) {    
		if (gamepad_button_check(i, j)) {
		    returnToMainMenuTimer = 0;
		}
	}
	
	for (var j = gp_axislh; j < gp_axisrv; j++) {    
		if (gamepad_axis_value(i, j)) {
		    returnToMainMenuTimer = 0;
		}
	}
}

if (screenTransitionObject != noone)
{
	if (screenTransitionObject.image_index >= 15)
	{
		audio_stop_sound(bgm_VictoryScreen_Loop);
		audio_stop_sound(bgm_VictoryScreen_Russel);
		room_goto(rMainMenu);
	}
	exit;
}

switch (state)
{
	case eVictoryScreenState.OPENING_ANIMATION:
	{
		if (image_index >= image_number - 1)
		{
			image_index = 7;
		}
		
		if (animTimer >= portaits_StartMoving && animTimer < portaits_EndMoving)
		{
			p1CharacterPortait_x = lerp(p1CharacterPortait_x, p1CharacterPortait_EndingPosition[0], 0.1);
		}
		
		if (image_index >= 7 && animTimer >= portaits_EndMoving)
		{
			state = eVictoryScreenState.DISPLAY_WIN_QUOTE;
		}
	}
	break;
	
	case eVictoryScreenState.DISPLAY_WIN_QUOTE:
	{
		image_speed = 0;
		
		// Print text
		if (animTimer mod 2 == 0)
		{
			if (quotePrintingLength < quoteLength)
			{
				quotePrintingLength += 1;
				displayQuote = string_copy(winQuote, 1, quotePrintingLength);
				
				returnToMainMenuTimer = 0;
			}
		}
		
		// If we press any button
		var anyButtonPressed = false;
		
		for (var i = 0; i < ds_list_size(oControllerManager.controllers); i++)
		{
			if (GamepadCheck(oControllerManager.controllers[| i].controllerSlotID)) 
			{
				anyButtonPressed = true;
				show_debug_message("pressed any button")
			}
		}
		
		if (keyboard_check_pressed(vk_anykey) || anyButtonPressed)
		{
			// If we still printing the quote, instantly complete it.
			if (quotePrintingLength < quoteLength)
			{
				displayQuote = winQuote;
				quotePrintingLength = quoteLength;
			}
			else
			{
				// Otherwise, transition into the options state.
				state = eVictoryScreenState.OPTIONS;
				returnToMainMenuTimer = 0;
			}
		}
		else if (returnToMainMenuTimer >= returnToMainMenuWait)
		{
			// Otherwise, transition into the options state.
			state = eVictoryScreenState.OPTIONS;
			returnToMainMenuTimer = 0;
		}
	}
	break;
	
	case eVictoryScreenState.OPTIONS:
	{
		image_speed = 0;
		
		if (returnToMainMenuTimer >= returnToMainMenuWait && screenTransitionObject == noone)
		{
			screenTransitionObject = instance_create_depth(0, 0, -10000, oScreenTransition);
			audio_sound_gain(bgm_VictoryScreen_Loop, 0, 800);
			audio_sound_gain(bgm_VictoryScreen_Russel, 0, 800);
			exit;
		}
		
		ResultsScreen();
	}
	break;
}
