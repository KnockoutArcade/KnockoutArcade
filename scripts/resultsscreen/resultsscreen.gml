// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ResultsScreen()
{
	var P1menuUp = global.p1ButtonMenuUp;
	var P1menuDown = global.p1ButtonMenuDown;
	var P1menuRowMove = P1menuUp + P1menuDown;
	var P1menuConfirm = global.p1ButtonMenuConfirm;
	var P1menuDeny = global.p1ButtonMenuDeny;
	var P1menuConfirmBuffer = false;
	
	var P2menuUp = global.p2ButtonMenuUp;
	var P2menuDown = global.p2ButtonMenuDown;
	var P2menuRowMove = P2menuUp + P2menuDown;
	var P2menuConfirm = global.p2ButtonMenuConfirm;
	var P2menuDeny = global.p2ButtonMenuDeny;
	var P2menuConfirmBuffer = false;
	
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

    if (P1menuConfirm)
	{
		P1hasSelectedresult = true;
		
		audio_play_sound(sfx_UI_Select, 0, false);
	}
	
	if (P1menuDeny)
	{
		P1hasSelectedresult = false;
		
		audio_play_sound(sfx_UI_Exit, 0, false);
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

    if (P2menuConfirm)
	{
		P2hasSelectedresult = true;
		
		audio_play_sound(sfx_UI_Select, 0, false);
	}
	
	if (P2menuDeny)
	{
		P2hasSelectedresult = false;
		
		audio_play_sound(sfx_UI_Exit, 0, false);
	}
	
	if (P1hasSelectedresult && P2hasSelectedresult)
	{
		var prioritySelection = max(P1resultSelRow, P2resultSelRow);
		
		font_delete(victoryFont);
		
		switch (prioritySelection)
		{
			case 0:
				room_restart();
			break;
			case 1:
				room_goto(rCharacterSelectScreen);
			break;
			case 2:
				room_goto(rMainMenu);
			break;
		}
	}
}