// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ResultsScreen()
{
	var P1menuUp = global.p1ButtonUp;
	var P1menuDown = global.p1ButtonDown;
	var P1menuRowMove = P1menuUp + P1menuDown;
	var P1menuConfirm = global.p1ButtonLight;
	var P1menuConfirmBuffer = false;
	
	var P2menuUp = global.p2ButtonUp;
	var P2menuDown = global.p2ButtonDown;
	var P2menuRowMove = P2menuUp + P2menuDown;
	var P2menuConfirm = global.p2ButtonLight;
	var P2menuConfirmBuffer = false;
	
	P1cursorCooldown--;
	P2cursorCooldown--;
	
	// Handle result selection (Player 1)
    if (P1menuRowMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedresult)
    {
        P1resultSelRow -= P1menuRowMove;
        P1cursorCooldown = 10;
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
	
	P1cursorY = 69 * P1resultSelRow + 240; 

    if (P1menuConfirm)
	{
		P1hasSelectedresult = true;
	}
	
	// Handle result selection (Player 2)
    if (P2menuRowMove != 0 && P2cursorCooldown < 1 && !P2hasSelectedresult)
    {
        P2resultSelRow -= P2menuRowMove;
        P2cursorCooldown = 10;
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
	
	//P2cursorY = 69 * P2resultSelRow + 240; 

    if (P2menuConfirm)
	{
		P2hasSelectedresult = true;
	}
	
	if (P1hasSelectedresult && P2hasSelectedresult)
	{
		var prioritySelection = max(P1resultSelRow, P2resultSelRow);
		
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