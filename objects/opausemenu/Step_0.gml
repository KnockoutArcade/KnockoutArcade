/// @description Insert description here
// You can write your code in this editor


#region Handle Inputs

// Determine which player's inputs to use
if (playerNumber == 0)
{
	var menuUp = global.p1ButtonMenuUp;
	var menuDown = global.p1ButtonMenuDown;
	var menuRowMove = menuUp + menuDown;
	var menuConfirm = global.p1ButtonMenuConfirm;
	var menuConfirmBuffer = false;
}
else
{
	var menuUp = global.p2ButtonMenuUp;
	var menuDown = global.p2ButtonMenuDown;
	var menuRowMove = menuUp + menuDown;
	var menuConfirm = global.p2ButtonMenuConfirm;
	var menuConfirmBuffer = false;
}

// Decrease the cursor cooldown
cursorCooldown--;

// If the cursor isn't moving, reset the cooldown
if (menuRowMove == 0)
{
	cursorCooldown = 0;
}

#endregion

switch (state)
{
	case (ePauseMenuState.MAIN) :
	{
		// If we are using the opening animation and we have reached the end, switch to the pause menu backdrop
		if ((sprite_index == sPauseMenu_Open_P1 || sprite_index == sPauseMenu_Open_P2) && image_index >= image_number - 1)
		{
			sprite_index = sPauseMenu_MainBackdrop;
			image_index = playerNumber;
		}
		
		// Handle Cursor
		if (menuRowMove != 0 && cursorCooldown <= 0)
		{
			currentRow -= menuRowMove;
			
			if (currentRow < 0)
			{
				currentRow = mainRowMax - 1;
			}
			
			if (currentRow >= mainRowMax)
			{
				currentRow = 0;
			}
			
			cursorCooldown = cursorCooldownAmount;
		}
		
		// Handle Selecting Options
		if (menuConfirm && !menuConfirmBuffer) // If we pressed confirm
		{
			switch (currentRow)
			{
				case 0:
				{
					owner.pauseMenuObject = noone;
					
					global.game_paused = false;
					
					instance_destroy();
				}
				break;
			}
		}
	}
	break;
}


