// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ResultsScreen()
{
	// If both players are CPUs, then any player is allowed to control the P1 side
	if (global.player1ControllerSlot == -1 && global.player2ControllerSlot == -1)
	{
		var allPlayersControls = {
			menuUp : 0,
			menuDown : 0,
			menuConfirm : 0,
			menuDeny : 0,
		}
		
		for (var i = 0; i < ds_list_size(oControllerManager.controllers); i++)
		{
			if (oControllerManager.controllers[| i].controllerInstance.buttonMenuUp) allPlayersControls.menuUp = oControllerManager.controllers[| i].controllerInstance.buttonMenuUp;
			if (oControllerManager.controllers[| i].controllerInstance.buttonMenuDown == -1) allPlayersControls.menuDown = oControllerManager.controllers[| i].controllerInstance.buttonMenuDown;
		
			if (oControllerManager.controllers[| i].controllerInstance.buttonMenuConfirm) allPlayersControls.menuConfirm = true;
			if (oControllerManager.controllers[| i].controllerInstance.buttonMenuDeny) allPlayersControls.menuDeny = true;
		}
	}
	
	var p1ControllerInstance = FindController(global.player1ControllerSlot);
	var P1menuUp = 0;
	var P1menuDown = 0;
	var P1menuRowMove = P1menuUp + P1menuDown;
	var P1menuConfirm = 0;
	var P1menuDeny = 0;
	var P1menuConfirmBuffer = false;
	
	if (p1ControllerInstance != -1)
	{
		P1menuUp = p1ControllerInstance.buttonMenuUp;
		P1menuDown = p1ControllerInstance.buttonMenuDown;
		P1menuRowMove = P1menuUp + P1menuDown;
		P1menuConfirm = p1ControllerInstance.buttonMenuConfirm;
		P1menuDeny = p1ControllerInstance.buttonMenuDeny;
		P1menuConfirmBuffer = false;
	}
	else if (global.player1ControllerSlot == -1 && global.player2ControllerSlot == -1) // If both players are CPUs, listen for any controllers
	{
		P1menuUp = allPlayersControls.menuUp;
		P1menuDown = allPlayersControls.menuDown;
		P1menuRowMove = P1menuUp + P1menuDown;
		P1menuConfirm = allPlayersControls.menuConfirm;
		P1menuDeny = allPlayersControls.menuDeny;
		P1menuConfirmBuffer = false;
	}
	else if (global.player1ControllerSlot == -1) // If just this is a CPU, automatically select rematch
	{
		P1hasSelectedresult = true;
	}
	
	var p2ControllerInstance = FindController(global.player2ControllerSlot);
	var P2menuUp = 0;
	var P2menuDown = 0;
	var P2menuRowMove = P2menuUp + P2menuDown;
	var P2menuConfirm = 0;
	var P2menuDeny = 0;
	var P2menuConfirmBuffer = false;
	
	if (p2ControllerInstance != -1)
	{
		P2menuUp = p2ControllerInstance.buttonMenuUp;
		P2menuDown = p2ControllerInstance.buttonMenuDown;
		P2menuRowMove = P2menuUp + P2menuDown;
		P2menuConfirm = p2ControllerInstance.buttonMenuConfirm;
		P2menuDeny = p2ControllerInstance.buttonMenuDeny;
		P2menuConfirmBuffer = false;
	}
	else if (global.player2ControllerSlot == -1) // If this is a CPU, automatically select rematch
	{
		P2hasSelectedresult = true;
	}
	
	P1cursorCooldown--;
	P2cursorCooldown--;
	
	// Handle result selection (Player 1)
    if (P1menuRowMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedresult)
    {
        P1resultSelRow -= P1menuRowMove;
        P1cursorCooldown = 10;
		
		audio_play_sound(sfx_CharSel_Hover, 0, false);
    }

    if (P1menuRowMove == 0)
    {
        P1cursorCooldown = 0;
    }

    if (P1resultSelRow >= P1resultSelRowMax)
    {
        P1resultSelRow = 0;
    }

    if (P1resultSelRow < 0)
    {
        P1resultSelRow = P1resultSelRowMax - 1;
    }

    if (P1menuDeny)
	{
		P1hasSelectedresult = false;
		
		audio_play_sound(sfx_UI_Exit, 0, false);
	}
	else if (P1menuConfirm)
	{
		P1hasSelectedresult = true;
		
		audio_play_sound(sfx_UI_Select, 0, false);
	}
	
	
	
	// Handle result selection (Player 2)
    if (P2menuRowMove != 0 && P2cursorCooldown < 1 && !P2hasSelectedresult)
    {
        P2resultSelRow -= P2menuRowMove;
        P2cursorCooldown = 10;
		
		audio_play_sound(sfx_CharSel_Hover, 0, false);
    }

    if (P2menuRowMove == 0)
    {
        P2cursorCooldown = 0;
    }

    if (P2resultSelRow >= P2resultSelRowMax)
    {
        P2resultSelRow = 0;
    }

    if (P2resultSelRow < 0)
    {
        P2resultSelRow = P2resultSelRowMax - 1;
    }

    if (P2menuDeny)
	{
		P2hasSelectedresult = false;
		
		audio_play_sound(sfx_UI_Exit, 0, false);
	}
	else if (P2menuConfirm)
	{
		P2hasSelectedresult = true;
		
		audio_play_sound(sfx_UI_Select, 0, false);
	}
	
	
	
	if (P1hasSelectedresult && P2hasSelectedresult)
	{
		var prioritySelection = max(P1resultSelRow, P2resultSelRow);
		
		switch (prioritySelection)
		{
			case 0:
				font_delete(victoryFont);
				global.isDoingRematch = true;
				audio_stop_sound(bgm_VictoryScreen_Loop);
				audio_stop_sound(bgm_VictoryScreen_Russel);
				room_restart();
			break;
			case 1:
				font_delete(victoryFont);
				audio_stop_sound(bgm_VictoryScreen_Loop);
				audio_stop_sound(bgm_VictoryScreen_Russel);
				room_goto(rCharacterSelectScreen);
			break;
			case 2:
				screenTransitionObject = instance_create_depth(0, 0, -10000, oScreenTransition);
				audio_sound_gain(bgm_VictoryScreen_Loop, 0, 800);
				audio_sound_gain(bgm_VictoryScreen_Russel, 0, 800);
			break;
		}
	}
}