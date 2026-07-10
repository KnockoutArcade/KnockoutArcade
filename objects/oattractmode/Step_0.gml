/// @description Insert description here
// You can write your code in this editor

attractModeTimer++;

if (keyboard_check(vk_anykey)) attractModeTimer = 0;

for (var i = 0; i < gamepad_get_device_count(); i++)
{
	for (var j = gp_face1; j < gp_axisrv; j++) {    
		if (gamepad_button_check(i, j)) {
		    attractModeTimer = 0;
		}
	}
	
	for (var j = gp_axislh; j < gp_axisrv; j++) {    
		if (gamepad_axis_value(i, j)) {
		    attractModeTimer = 0;
		}
	}
}

if (attractModeTimer >= attractModeWait && screenTransitionObject == noone)
{
	screenTransitionObject = instance_create_depth(0, 0, -10000, oScreenTransition);
	
	if (audio_is_playing(bgm_MainMenu)) audio_sound_gain(bgm_MainMenu, 0, 1000);
}

if (screenTransitionObject != noone)
{	
	// Transition To other screens
	if (screenTransitionObject.image_index >= 15)
	{
		global.gameMode = GAMEMODE.VERSUS;
		global.isAttractMode = true;
		
		global.player1ControllerSlot = -1;
		global.player2ControllerSlot = -1;
		
		var rng = irandom(2);
		var selectedStage = rRusselStage;
		global.currentBGM = bgm_Russel_Stage;
		
		if (rng == 1)
		{
			selectedStage = rBeverlyStage;
			global.currentBGM = bgm_Beverly_Stage;
		}
		else if (rng == 2)
		{
			selectedStage = rJayStage;
		}
		
		global.p1SelectedCharacter = oRussel;
		global.p2SelectedCharacter = oRussel;
		
		rng = irandom(1);
		if (rng == 1)
		{
			global.p1SelectedCharacter = oBeverly;
		}
		
		rng = irandom(1);
		if (rng == 1)
		{
			global.p2SelectedCharacter = oBeverly;
		}
		
		global.p1PaletteID = irandom(11);
		global.p2PaletteID = irandom(11);
		
		if (global.p1SelectedCharacter == global.p2SelectedCharacter && global.p1PaletteID == global.p2PaletteID)
		{
			global.p2PaletteID++;
			
			if (global.p2PaletteID > 11) global.p2PaletteID = 0;
		}
		
		if (audio_is_playing(bgm_MainMenu)) audio_stop_sound(bgm_MainMenu);
		room_goto(selectedStage);
	}
}