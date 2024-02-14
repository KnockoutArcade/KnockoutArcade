/// @description Insert description here
// You can write your code in this editor

#region Inputs
// Determine which player's inputs to use
if (playerNumber == 0)
{
	var menuUp = global.p1ButtonMenuUp;
	var menuDown = global.p1ButtonMenuDown;
	var menuRowMove = menuUp + menuDown;
	
	var menuLeft = global.p1ButtonMenuLeft;
	var menuRight = global.p1ButtonMenuRight;
	var menuCollumnMove = menuLeft + menuRight;
	
	var menuConfirm = global.p1ButtonMenuConfirm;
	var menuConfirmBuffer = false;
	
	var menuDeny = global.p1ButtonMenuDeny;
	var menuDenyBuffer = false;
}
else
{
	var menuUp = global.p2ButtonMenuUp;
	var menuDown = global.p2ButtonMenuDown;
	var menuRowMove = menuUp + menuDown;
	
	var menuLeft = global.p2ButtonMenuLeft;
	var menuRight = global.p2ButtonMenuRight;
	var menuCollumnMove = menuLeft + menuRight;
	
	var menuConfirm = global.p2ButtonMenuConfirm;
	var menuConfirmBuffer = false;
	
	var menuDeny = global.p2ButtonMenuDeny;
	var menuDenyBuffer = false;
}

#endregion

// Decrease the cursor cooldown
cursorCooldown--;

// If the cursor isn't moving, reset the cooldown
if (menuRowMove == 0 && menuCollumnMove == 0)
{
	cursorCooldown = 0;
}


// These states control the animation of the menu, as well as what it can do during those animations
switch (state)
{
	case eSetControlsState.OPENING:
	{
		// If we are using the opening animation and we have reached the end, switch to the turn to face animation
		if (image_index >= image_number - 1)
		{
			sprite_index = sControlsMenu_TurnFace;
			image_index = 0;
			
			state = eSetControlsState.TURN_TO_FACE;
		}
	}
	break;
	
	case eSetControlsState.TURN_TO_FACE:
	{
		// If we have reached the end of this animation, switch to the active animation
		if (image_index >= image_number - 1)
		{
			sprite_index = sControlsMenu_Base;
			image_index = 0;
			
			state = eSetControlsState.ACTIVE;
		}
	}
	break;
	
	case eSetControlsState.ACTIVE:
	{
		// If we press up or down
		if (menuRowMove != 0 && cursorCooldown <= 0)
		{
			// Update our selected option
			selectedOption -= menuRowMove;
			
			// Wrap our selected option to the maximum number of selections
			if (selectedOption >= maxSelections)
			{
				selectedOption = 0;
			}
			else if (selectedOption < 0)
			{
				selectedOption = maxSelections - 1;
			}
			
			// If we've scrolled past the bottom of the selections...
			if (selectedOption > topRowOption + (maxOnScreenOptions - 1))
			{
				while (selectedOption > topRowOption + (maxOnScreenOptions - 1))
				{
					topRowOption += 1;
				}
			}
			else if (selectedOption < topRowOption) // otherwise if we've scrolled past the top...
			{
				while (selectedOption < topRowOption)
				{
					topRowOption -= 1;
				}
			}
			
			selectedRow = selectedOption - topRowOption;
			
			
			
			
			// set cooldown
			cursorCooldown = cursorCooldownAmount;
		}
	}
	break;
}


