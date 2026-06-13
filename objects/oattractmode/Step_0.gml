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
}

if (attractModeTimer >= attractModeWait && screenTransitionObject == noone)
{
	screenTransitionObject = instance_create_depth(0, 0, -10000, oScreenTransition);
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
		
		global.p1SelectedCharacter = oRussel;
		global.p2SelectedCharacter = oRussel;
		
		global.p1PaletteID = 0;
		global.p2PaletteID = 1;
		
		room_goto(rRusselStage);
	}
}