/// @description Insert description here
// You can write your code in this editor


#region If both players are CPU, accept input from all controllers

var allPlayersControls = {
	buttonMenuLeft : false,
	buttonMenuRight : false,
			
	buttonMenuUp : false,
	buttonMenuDown : false,
			
	buttonMenuConfirm : false,
	buttonMenuDeny : false,
	buttonMenuSwitch : false,
	buttonMenuSetControls : false
}

if (p1IsCPU && p2IsCPU)
{
	// For each input, if any controller is pressing that button, set that button to true
	for (var i = 0; i < array_length(controllerAssign); i++;)
	{
		if (controllerAssign[i].buttonMenuLeft == -1) allPlayersControls.buttonMenuLeft = controllerAssign[i].buttonMenuLeft;
		if (controllerAssign[i].buttonMenuRight) allPlayersControls.buttonMenuRight = controllerAssign[i].buttonMenuRight;
		
		if (controllerAssign[i].buttonMenuUp) allPlayersControls.buttonMenuUp = controllerAssign[i].buttonMenuUp;
		if (controllerAssign[i].buttonMenuDown == -1) allPlayersControls.buttonMenuDown = controllerAssign[i].buttonMenuDown;
		
		if (controllerAssign[i].buttonMenuConfirm) allPlayersControls.buttonMenuConfirm = true;
		if (controllerAssign[i].buttonMenuDeny) allPlayersControls.buttonMenuDeny = true;
		if (controllerAssign[i].buttonMenuSwitch) allPlayersControls.buttonMenuSwitch = true;
		if (controllerAssign[i].buttonMenuSetControls) allPlayersControls.buttonMenuSetControls = true;
	}
}

#endregion

// Player 1 cursor vars
if (p1IsCPU && p2IsCPU && (!P1hasSelectedAlt || P1hasSelectedAlt && state != eCharacterSelectState.CHARACTER_SELECT)) // Both CPUs
{
	var P1menuLeft = allPlayersControls.buttonMenuLeft;
	var P1menuRight = allPlayersControls.buttonMenuRight;
	var P1menuColMove = P1menuLeft + P1menuRight;

	var P1menuUp = allPlayersControls.buttonMenuUp;
	var P1menuDown = allPlayersControls.buttonMenuDown;
	var P1menuRowMove = P1menuUp + P1menuDown;

	var P1menuConfirm = allPlayersControls.buttonMenuConfirm;
	var P1menuCancel = allPlayersControls.buttonMenuDeny;
	var P1switch = allPlayersControls.buttonMenuSwitch;
	var P1ChangeControls = allPlayersControls.buttonMenuSetControls;
	var P1menuConfirmBuffer = false;
	var P1menuAltSelBuffer = false;
	var P1menuMapSelBuffer = false;
	var P1menuMusicSelBuffer = false;
}
else if (instance_exists(p1SideController) && p1SideController != -1) // Human Player
{
	var P1menuLeft = p1SideController.buttonMenuLeft;
	var P1menuRight = p1SideController.buttonMenuRight;
	var P1menuColMove = P1menuLeft + P1menuRight;

	var P1menuUp = p1SideController.buttonMenuUp;
	var P1menuDown = p1SideController.buttonMenuDown;
	var P1menuRowMove = P1menuUp + P1menuDown;

	var P1menuConfirm = p1SideController.buttonMenuConfirm;
	var P1menuCancel = p1SideController.buttonMenuDeny;
	var P1switch = p1SideController.buttonMenuSwitch;
	var P1ChangeControls = p1SideController.buttonMenuSetControls;
	var P1menuConfirmBuffer = false;
	var P1menuAltSelBuffer = false;
	var P1menuMapSelBuffer = false;
	var P1menuMusicSelBuffer = false;
}
else // empty Controller
{
	var P1menuLeft = false;
	var P1menuRight = false;
	var P1menuColMove = P1menuLeft + P1menuRight;

	var P1menuUp = false;
	var P1menuDown = false;
	var P1menuRowMove = P1menuUp + P1menuDown;

	var P1menuConfirm = false;
	var P1menuCancel = false;
	var P1switch = false;
	var P1ChangeControls = false;
	var P1menuConfirmBuffer = false;
	var P1menuAltSelBuffer = false;
	var P1menuMapSelBuffer = false;
	var P1menuMusicSelBuffer = false;
	
}

// Player 2 cursor vars
if (p1IsCPU && p2IsCPU && P1hasSelectedAlt) // Both CPUs
{
	var P2menuLeft = allPlayersControls.buttonMenuLeft;
	var P2menuRight = allPlayersControls.buttonMenuRight;
	var P2menuColMove = P2menuLeft + P2menuRight;

	var P2menuUp = allPlayersControls.buttonMenuUp;
	var P2menuDown = allPlayersControls.buttonMenuDown;
	var P2menuRowMove = P2menuUp + P2menuDown;

	var P2menuConfirm = allPlayersControls.buttonMenuConfirm;
	var P2menuCancel = allPlayersControls.buttonMenuDeny;
	var P2switch = allPlayersControls.buttonMenuSwitch;
	var P2ChangeControls = allPlayersControls.buttonMenuSetControls;
	var P2menuConfirmBuffer = false;
	var P2menuAltSelBuffer = false;
	var P2menuMapSelBuffer = false;
	var P2menuMusicSelBuffer = false;
}
else if (instance_exists(p2SideController) && p2SideController != -1) // Human Player
{
	var P2menuLeft = p2SideController.buttonMenuLeft;
	var P2menuRight = p2SideController.buttonMenuRight;
	var P2menuColMove = P2menuLeft + P2menuRight;

	var P2menuUp = p2SideController.buttonMenuUp;
	var P2menuDown = p2SideController.buttonMenuDown;
	var P2menuRowMove = P2menuUp + P2menuDown;

	var P2menuConfirm = p2SideController.buttonMenuConfirm;
	var P2menuCancel = p2SideController.buttonMenuDeny;
	var P2switch = p2SideController.buttonMenuSwitch;
	var P2ChangeControls = p2SideController.buttonMenuSetControls;

	var P2menuConfirmBuffer = false;
}
else // Empty controller
{
	var P2menuLeft = false;
	var P2menuRight = false;
	var P2menuColMove = P2menuLeft + P2menuRight;

	var P2menuUp = false;
	var P2menuDown = false;
	var P2menuRowMove = P2menuUp + P2menuDown;

	var P2menuConfirm = false;
	var P2menuCancel = false;
	var P2ChangeControls = false;

	var P2menuConfirmBuffer = false;
}

P1cursorCooldown--;
P2cursorCooldown--;

// Check if the controls menu objects exist
if (P1ControlsMenuObj != noone)
{
	if (!instance_exists(P1ControlsMenuObj))
	{
		P1ControlsMenuObj = noone;
	}
}
if (P2ControlsMenuObj != noone)
{
	if (!instance_exists(P2ControlsMenuObj))
	{
		P2ControlsMenuObj = noone;
	}
}

if (state == eCharacterSelectState.CONTROLLER_ASSIGN)
{
	var goBackToMainMenu = false;
	var proceedToCharSel = false;
	
	for (var i = 0; i < array_length(controllerAssign) && i < numberOfMaxAssignedControllers; i++;)
	{
		var tempControllerMenuLeft = controllerAssign[i].buttonMenuLeft;
		var tempControllerMenuRight = controllerAssign[i].buttonMenuRight;
		var tempControllerDirection = tempControllerMenuLeft + tempControllerMenuRight;
		
		if (controllerAssign[i].buttonMenuDeny)
		{
			goBackToMainMenu = true;
		}
		
		if (controllerAssign[i].buttonMenuConfirm)
		{
			proceedToCharSel = true;
		}
		
		if (tempControllerMenuLeft == 0 && tempControllerMenuRight == 0)
		{
			controllerAssignData[i].cursorCooldown = 0;
		}
		
		controllerAssignData[i].cursorCooldown--;
		
		if (controllerAssignData[i].cursorCooldown <= 0 && tempControllerDirection != 0)
		{
			controllerAssignData[i].playerSide += tempControllerDirection;
			
			// Cap playerSide to be between -1 and 1
			if (controllerAssignData[i].playerSide > 1) controllerAssignData[i].playerSide = 1;
			else if (controllerAssignData[i].playerSide < -1) controllerAssignData[i].playerSide = -1;
			
			// Set cursor cooldown
			controllerAssignData[i].cursorCooldown = 13;
		}
		
		// If we move into the player spot and it's empty 
		if (controllerAssignData[i].playerSide == -1 && p1SideController == -1)
		{
			p1SideController = controllerAssign[i];
		}
		else if (controllerAssignData[i].playerSide == -1 && p1SideController != controllerAssign[i]) // If we get there and its not us
		{
			controllerAssignData[i].playerSide = 0;
			controllerAssignData[i].cursorCooldown = 0;
		}
		
		// Ditto but for the other side
		if (controllerAssignData[i].playerSide == 1 && p2SideController == -1)
		{
			p2SideController = controllerAssign[i];
		}
		else if (controllerAssignData[i].playerSide == 1 && p2SideController != controllerAssign[i]) // If we get there and its not us
		{
			controllerAssignData[i].playerSide = 0;
			controllerAssignData[i].cursorCooldown = 0;
		}
		
		// If we move back to the center and one of the sides was assigned to us, unassign it
		if (controllerAssignData[i].playerSide == 0 && p1SideController == controllerAssign[i])
		{
			p1SideController = -1;
		}
		else if (controllerAssignData[i].playerSide == 0 && p2SideController == controllerAssign[i])
		{
			p2SideController = -1;
		}
		
		// Handle position
		controllerAssignData[i].xPos = 66 + (44 * controllerAssignData[i].playerSide);
		
		if (controllerAssignData[i].playerSide == 0) 
		{
			controllerAssignData[i].yPos = 19 + (21 * i);
		}
		else 
		{
			controllerAssignData[i].yPos = 37;
		}
	}
	
	// Handle returning to Main Menu
	if (goBackToMainMenu)
	{
		room_goto(rMainMenu);
		exit;
	}
	else if (proceedToCharSel)
	{
		state = eCharacterSelectState.CHARACTER_SELECT;
		
		// Store the slots separately that way if the controllers DC, we know which slot to look for when they come back
		if (p1SideController != -1) 
		{
			p1SideControllerSlot = p1SideController.controllerSlot;
			p1IsCPU = false;
		}
		else
		{
			p1SideControllerSlot = -1;
			p1IsCPU = true;
		}
		
		if (p2SideController != -1) 
		{
			p2SideControllerSlot = p2SideController.controllerSlot;
			p2IsCPU = false;
		}
		else
		{
			p2SideControllerSlot = -1;
			p2IsCPU = true;
		}
	}
}
else if (state == eCharacterSelectState.CHARACTER_SELECT)
{
    charSelBoxTimer++;

    // Handle frame rates of different character idle anims
    if (P1charSelCol == 0 && P1charSelRow == 0)
    {
        p1charSelFrameRate = 10;
        p1LocalPalette = RusselPaletteData;
    }
    else if (P1charSelCol == 1 && P1charSelRow == 0)
    {
        p1charSelFrameRate = 6;
        p1LocalPalette = BeverlyPaletteData;
    }
    else if (P1charSelCol == 2 && P1charSelRow == 0)
    {
        p1charSelFrameRate = 6;
        p1LocalPalette = JayPaletteData;
    }
	else if (P1charSelCol == 0 && P1charSelRow == 1)
    {
        p1charSelFrameRate = 10;
        p1LocalPalette = GuntherPaletteData;
    }

    if (P2charSelCol == 0 && P2charSelRow == 0)
    {
        p2charSelFrameRate = 10;
        p2LocalPalette = RusselPaletteData;
    }
    else if (P2charSelCol == 1 && P2charSelRow == 0)
    {
        p2charSelFrameRate = 6;
        p2LocalPalette = BeverlyPaletteData;
    }
    else if (P2charSelCol == 2 && P2charSelRow == 0)
    {
        p2charSelFrameRate = 6;
        p2LocalPalette = JayPaletteData;
    }
	else if (P2charSelCol == 0 && P2charSelRow == 1)
    {
        p2charSelFrameRate = 10;
        p2LocalPalette = GuntherPaletteData;
    }

    // Handle P1 cursor movement
    if (P1menuColMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedChar && P1ControlsMenuObj == noone)
    {
        P1charSelCol += P1menuColMove;
        P1cursorCooldown = 10;
		
		audio_play_sound(sfx_CharSel_Hover, 0, false);
    }
    if (P1menuRowMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedChar && P1ControlsMenuObj == noone)
    {
        P1charSelRow += P1menuRowMove;
        P1cursorCooldown = 10;
		
		audio_play_sound(sfx_CharSel_Hover, 0, false);
    }
    if (P1menuRowMove == 0 && P1menuColMove == 0)
    {
        P1cursorCooldown = 0;
    }
    if (P1charSelCol > charSelColMax)
    {
        P1charSelCol = 0;
    }
    if (P1charSelCol < 0)
    {
        P1charSelCol = charSelColMax;
    }
    if (P1charSelRow > charSelRowMax)
    {
        P1charSelRow = 0;
    }
    if (P1charSelRow < 0)
    {
        P1charSelRow = charSelRowMax;
    }
	
	// Handle Controls Menu
	if (P1ChangeControls && P1ControlsMenuObj == noone && !p1IsCPU)
	{
		// Play Sound
		audio_play_sound(sfx_UI_Select, 0, false);
					
		// Spawn the controls object
		P1ControlsMenuObj = instance_create_depth(0, 0, -20000, oSetControlsMenu);
		P1ControlsMenuObj.playerNumber = 0;
		P1ControlsMenuObj.playerControls = global.player1Controls;
		P1ControlsMenuObj.playerControlsType = global.player1ControllerType;
	}
	
    if (P1menuConfirm && !P1hasSelectedChar && P1ControlsMenuObj == noone)
    {
        P1hasSelectedChar = true;
        P1menuConfirmBuffer = true;
		
		audio_play_sound(sfx_UI_Select, 0, false);

        if (P1charSelCol == 0 && P1charSelRow == 0)
        {
            global.p1SelectedCharacter = oRussel; // When Setting selected characters, always use the object name
        }
        else if (P1charSelCol == 1 && P1charSelRow == 0)
        {
            global.p1SelectedCharacter = oBeverly;
        }
        else if (P1charSelCol == 2 && P1charSelRow == 0)
        {
            global.p1SelectedCharacter = oJay;
        }
		else if (P1charSelCol == 0 && P1charSelRow == 1)
        {
            global.p1SelectedCharacter = oGunther;
        }
        else
        {
            P1hasSelectedChar = false;
            P1menuConfirmBuffer = false;
        }
    }

    if (P1menuCancel && P1ControlsMenuObj == noone)
    {
        if (P1hasSelectedAlt)
        {
            P1hasSelectedAlt = false;
        }
        else if (P1hasSelectedChar)
        {
            P1hasSelectedChar = false;
            global.p1SelectedCharacter = noone;
        }
        else if (p1IsCPU && !p2IsCPU)
		{
			// If we're the CPU and p2 isn't, pass control to P2
			p2SideController = p1SideController;
			p2SideControllerSlot = p1SideControllerSlot;
			
			p1SideController = -1;
			p1SideControllerSlot = -1;
			
			// Un-select P2's character
			P2hasSelectedChar = false;
            global.p2SelectedCharacter = noone;
			P2hasSelectedAlt = false;
		}
		else if (!P2hasSelectedChar)
        {
            // If neither player has chosen a character, return to main menu
            room_goto(rMainMenu);
        }

        RTF_animTimer = 0;
        RTF_currentFrame = 0;
		
		audio_play_sound(sfx_UI_Exit, 0, false);
    }

    // Handle Palette Selection
    if (P1hasSelectedChar && P1ControlsMenuObj == noone)
    {
        if (P1menuColMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedAlt)
        {
            global.p1PaletteID += P1menuColMove;
            P1cursorCooldown = 10;
			
			audio_play_sound(sfx_CharSel_SelectAlt, 0, false);
        }

        if (global.p1PaletteID >= p1LocalPalette.NumberOfPalettes)
        {
            global.p1PaletteID = 0;
        }
        else if (global.p1PaletteID < 0)
        {
            global.p1PaletteID = p1LocalPalette.NumberOfPalettes - 1;
        }

        if (P1menuConfirm && !P1menuConfirmBuffer && !P1hasSelectedAlt)
        {
            P1hasSelectedAlt = true;
            P1menuAltSelBuffer = true;
			
			audio_play_sound(sfx_CharSel_Ready, 0, false);
			
			if (p2IsCPU)
			{
				// If p2 is a CPU controller, switch our control over to them
				p2SideController = p1SideController;
				p2SideControllerSlot = p1SideControllerSlot;
			
				p1SideController = -1;
				p1SideControllerSlot = -1;
			}
        }
    }


    // Handle P2 cursor movement
    if (P2menuColMove != 0 && P2cursorCooldown < 1 && !P2hasSelectedChar && P2ControlsMenuObj == noone)
    {
        P2charSelCol += P2menuColMove;
        P2cursorCooldown = 10;
		
		audio_play_sound(sfx_CharSel_Hover, 0, false);
    }
    if (P2menuRowMove != 0 && P2cursorCooldown < 1 && !P2hasSelectedChar && P2ControlsMenuObj == noone)
    {
        P2charSelRow += P2menuRowMove;
        P2cursorCooldown = 10;
		
		audio_play_sound(sfx_CharSel_Hover, 0, false);
    }
    if (P2menuRowMove == 0 && P2menuColMove == 0)
    {
        P2cursorCooldown = 0;
    }
    if (P2charSelCol > charSelColMax)
    {
        P2charSelCol = 0;
    }
    if (P2charSelCol < 0)
    {
        P2charSelCol = charSelColMax;
    }
    if (P2charSelRow > charSelRowMax)
    {
        P2charSelRow = 0;
    }
    if (P2charSelRow < 0)
    {
        P2charSelRow = charSelRowMax;
    }

	// Handle Controls Menu
	if (P2ChangeControls && P2ControlsMenuObj == noone)
	{
		// Play Sound
		audio_play_sound(sfx_UI_Select, 0, false);
					
		// Spawn the controls object
		P2ControlsMenuObj = instance_create_depth(80, 0, -20000, oSetControlsMenu);
		P2ControlsMenuObj.playerNumber = 1;
		P2ControlsMenuObj.playerControls = global.player2Controls;
		P2ControlsMenuObj.playerControlsType = global.player2ControllerType;
	}
	
    if (P2menuConfirm && !P2hasSelectedChar && P2ControlsMenuObj == noone)
    {
        P2hasSelectedChar = true;
        P2menuConfirmBuffer = true;
		
		audio_play_sound(sfx_UI_Select, 0, false);
		
        if (P2charSelCol == 0 && P2charSelRow == 0)
        {
            global.p2SelectedCharacter = oRussel;
            p2charSelFrameRate = 10;
        }
        else if (P2charSelCol == 1 && P2charSelRow == 0)
        {
            global.p2SelectedCharacter = oBeverly;
            p2charSelFrameRate = 6;
        }
        else if (P2charSelCol == 2 && P2charSelRow == 0)
        {
            global.p2SelectedCharacter = oJay;
            p2charSelFrameRate = 6;
        }
		else if (P2charSelCol == 0 && P2charSelRow == 1)
        {
            global.p2SelectedCharacter = oGunther;
        }
        else
        {
            P2hasSelectedChar = false;
            P2menuConfirmBuffer = false;
        }
    }

    if (P2menuCancel && P2ControlsMenuObj == noone)
    {
        if (P2hasSelectedAlt)
        {
            P2hasSelectedAlt = false;
        }
        else if (P2hasSelectedChar)
        {
            P2hasSelectedChar = false;
            global.p2SelectedCharacter = noone;
        } 
		else if (p2IsCPU)
        {
            // If we are the CPU, always pass control back to P1
			p1SideController = p2SideController;
			p1SideControllerSlot = p2SideControllerSlot;
			
			p2SideController = -1;
			p2SideControllerSlot = -1;
			
			// Un-select P1's character
			P1hasSelectedChar = false;
            global.p1SelectedCharacter = noone;
			P1hasSelectedAlt = false;
        }
		else if (!p2IsCPU && !P1hasSelectedChar)
		{
			// If neither player has chosen a character, return to main menu
            room_goto(rMainMenu);
		}

        RTF_animTimer = 0;
        RTF_currentFrame = 0;
		
		audio_play_sound(sfx_UI_Exit, 0, false);
    }

    // Handle Palette Selection
    if (P2hasSelectedChar && P2ControlsMenuObj == noone)
    {
        if (P2menuColMove != 0 && P2cursorCooldown < 1 && !P2hasSelectedAlt)
        {
            global.p2PaletteID += P2menuColMove;
            P2cursorCooldown = 10;
			
			audio_play_sound(sfx_CharSel_SelectAlt, 0, false);
        }

        // Handle Palette Data
        if (global.p2PaletteID >= p2LocalPalette.NumberOfPalettes)
        {
            global.p2PaletteID = 0;
        }
        else if (global.p2PaletteID < 0)
        {
            global.p2PaletteID = p2LocalPalette.NumberOfPalettes - 1;
        }

        if (P2menuConfirm && !P2menuConfirmBuffer)
        {
            P2hasSelectedAlt = true;
            P2menuConfirmBuffer = true;
			
			audio_play_sound(sfx_CharSel_Ready, 0, false);
			
			// If p1 is a CPU controller and we aren't, switch our control over to them
			// Different for P2 because if both players are CPUs, once P2 selects their character we go to the Stage Sel
			if (p1IsCPU && !p2IsCPU)
			{
				p1SideController = p2SideController;
				p1SideControllerSlot = p2SideControllerSlot;
				
				p2SideController = -1;
				p2SideControllerSlot = -1;
			}
        }
    }


    if (charSelBoxTimer > 4)
    {
        charSelBoxAlt = !charSelBoxAlt;
        charSelBoxTimer = 0;
    }

    // Character Select Animations
    p1charSelAnimTimer++;
    if (p1charSelAnimTimer > (60 / p1charSelFrameRate))
    {
        p1charSelAnimTimer = 0;
        P1charSelCurrentFrame++;
    }

    p2charSelAnimTimer++;
    if (p2charSelAnimTimer > (60 / p2charSelFrameRate))
    {
        p2charSelAnimTimer = 0;
        P2charSelCurrentFrame++;
    }
	
	// If both player's have selected an alt AND there are no controls menus open
    if (P1hasSelectedAlt && P2hasSelectedAlt && P1ControlsMenuObj == noone && P2ControlsMenuObj == noone)
    {
        // Go to stage select
        state = eCharacterSelectState.STAGE_SELECT;
    }
}
else if (state == eCharacterSelectState.STAGE_SELECT)
{
    // Ready To Fight Animations
    RTF_animTimer++;

    if (RTF_animTimer >= (60 / RTF_frameRate) && RTF_currentFrame != 4)
    {
        RTF_animTimer = 0;
        RTF_currentFrame++;
    }

    // Fix for when charcters don't have the exact same number of costumes.
    if (global.p1PaletteID >= p1LocalPalette.NumberOfPalettes)
    {
        global.p1PaletteID = 0;
    }
    if (global.p2PaletteID >= p2LocalPalette.NumberOfPalettes)
    {
        global.p2PaletteID = 0;
    }

    // Handle Map selection
    if (P1menuColMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedMap)
    {
        P1mapSelCol += P1menuColMove;
        P1cursorCooldown = 10;
		
		audio_play_sound(sfx_CharSel_Hover, 0, false);
    }

    if (P1menuRowMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedMap)
    {
        P1mapSelRow += P1menuRowMove;
        P1cursorCooldown = 10;
		
		audio_play_sound(sfx_CharSel_Hover, 0, false);
    }

    if (P1menuRowMove == 0 && P1menuColMove == 0)
    {
        P1cursorCooldown = 0;
    }

    if (P1mapSelCol > mapSelColMax)
    {
        P1mapSelCol = 0;
    }

    if (P1mapSelCol < 0)
    {
        P1mapSelCol = mapSelColMax;
    }

    if (P1mapSelRow > mapSelRowMax)
    {
        P1mapSelRow = 0;
    }

    if (P1mapSelRow < 0)
    {
        P1mapSelRow = mapSelRowMax;
    }
	
	// If we have clicked on a stage
    if (P1menuConfirm && !P1menuConfirmBuffer && !P1hasSelectedMap)
    {
        P1hasSelectedMap = true;
        P1menuMapSelBuffer = true;
		
		// Start match on Russel's Stage
        if (P1mapSelCol == 0 && P1mapSelRow == 0)
        {
			if (selectedMusic == 0) // Auto
			{
				selectedMusic = 2;
			}
			else if (selectedMusic == 1) // Random
			{
				P1musicSelRow = irandom_range(0, musicSelRowMax);
				if (P1musicSelRow == 0)
				{
					selectedMusic = 2;
				}
				else if (P1musicSelRow == 1)
				{
					selectedMusic = 3;
				}
				else if (P1musicSelRow == 2)
				{
					selectedMusic = 4;
				}
			}
			
			selectedStage = rRusselStage;
			state = eCharacterSelectState.TRANSITION_TO_FIGHT;
			
			//room = rRusselStage;
			//global.gameMode = GAMEMODE.VERSUS;
        }
        else if (P1mapSelCol == 1 && P1mapSelRow == 0) // Start Match on Beverly's Stage
        {
			if (selectedMusic == 0) // Auto
			{
				selectedMusic = 3;
			}
			else if (selectedMusic == 1) // Random
			{
				P1musicSelRow = irandom_range(0, musicSelRowMax);
				if (P1musicSelRow == 0)
				{
					selectedMusic = 2;
				}
				else if (P1musicSelRow == 1)
				{
					selectedMusic = 3;
				}
				else if (P1musicSelRow == 2)
				{
					selectedMusic = 4;
				}
			}
			
			selectedStage = rBeverlyStage;
			state = eCharacterSelectState.TRANSITION_TO_FIGHT;
			
			//room = rBeverlyStage;
			//global.gameMode = GAMEMODE.VERSUS;
        }
        else if (P1mapSelCol == 2 && P1mapSelRow == 0) // Start match on Jay's Stage
        {
			if (selectedMusic == 0) // Auto
			{
				selectedMusic = 4;
			}
			else if (selectedMusic == 1) // Random
			{
				P1musicSelRow = irandom_range(0, musicSelRowMax);
				if (P1musicSelRow == 0)
				{
					selectedMusic = 2;
				}
				else if (P1musicSelRow == 1)
				{
					selectedMusic = 3;
				}
				else if (P1musicSelRow == 2)
				{
					selectedMusic = 4;
				}
			}
			
			selectedStage = rJayStage;
			state = eCharacterSelectState.TRANSITION_TO_FIGHT;
			
			//room = rJayStage;
			//global.gameMode = GAMEMODE.VERSUS;
        }
        else if (P1mapSelCol == 3 && P1mapSelRow == 1) // Random
        {
			var validStage = false;
			while (!validStage)
			{
				P1mapSelRow = irandom_range(0, mapSelRowMax);
				P1mapSelCol = irandom_range(0, mapSelColMax);
			    if (P1mapSelCol == 0 && P1mapSelRow == 0)
			    {
					if (selectedMusic == 0) // Auto
					{
						selectedMusic = 2;
					}
					else if (selectedMusic == 1) // Random
					{
						P1musicSelRow = irandom_range(0, musicSelRowMax);
						if (P1musicSelRow == 0)
						{
							selectedMusic = 2;
						}
						else if (P1musicSelRow == 1)
						{
							selectedMusic = 3;
						}
						else if (P1musicSelRow == 2)
						{
							selectedMusic = 4;
						}
					}
					
					validStage = true;
					
					selectedStage = rRusselStage;
					state = eCharacterSelectState.TRANSITION_TO_FIGHT;
					//room = rRusselStage;
					//global.gameMode = GAMEMODE.VERSUS;
			    }
			    else if (P1mapSelCol == 1 && P1mapSelRow == 0)
			    {
					if (selectedMusic == 0) // Auto
					{
						selectedMusic = 3;
					}
					else if (selectedMusic == 1) // Random
					{
						P1musicSelRow = irandom_range(0, musicSelRowMax);
						if (P1musicSelRow == 0)
						{
							selectedMusic = 2;
						}
						else if (P1musicSelRow == 1)
						{
							selectedMusic = 3;
						}
						else if (P1musicSelRow == 2)
						{
							selectedMusic = 4;
						}
					}
					
					validStage = true;
					selectedStage = rBeverlyStage;
					state = eCharacterSelectState.TRANSITION_TO_FIGHT;
					//room = rBeverlyStage;
					//global.gameMode = GAMEMODE.VERSUS;
			    }
			    else if (P1mapSelCol == 2 && P1mapSelRow == 0)
			    {
					if (selectedMusic == 0) // Auto
					{
						selectedMusic = 4;
					}
					else if (selectedMusic == 1) // Random
					{
						P1musicSelRow = irandom_range(0, musicSelRowMax);
						if (P1musicSelRow == 0)
						{
							selectedMusic = 2;
						}
						else if (P1musicSelRow == 1)
						{
							selectedMusic = 3;
						}
						else if (P1musicSelRow == 2)
						{
							selectedMusic = 4;
						}
					}
					
					validStage = true;
					selectedStage = rJayStage;
					state = eCharacterSelectState.TRANSITION_TO_FIGHT;
					//room = rJayStage;
					//global.gameMode = GAMEMODE.VERSUS;
			    }
			}
        }
        else
        {
            P1hasSelectedMap = false;
			P1menuMapSelBuffer = false;
		}
    }
	
	if (P1switch)
	{
		state = eCharacterSelectState.MUSIC_SELECT;
		
		RTF_animTimer = 0;
        RTF_currentFrame = 0;
	}

    if (P1menuCancel)
    {
        state = eCharacterSelectState.CHARACTER_SELECT;
        P1hasSelectedAlt = false;

        RTF_animTimer = 0;
        RTF_currentFrame = 0;
		
		audio_play_sound(sfx_UI_Exit, 0, false);
    }
	
	if (P2menuCancel)
    {
        state = eCharacterSelectState.CHARACTER_SELECT;
        P2hasSelectedAlt = false;

        RTF_animTimer = 0;
        RTF_currentFrame = 0;
		
		audio_play_sound(sfx_UI_Exit, 0, false);
    }
}
else if (state == eCharacterSelectState.MUSIC_SELECT)
{
	// Ready To Fight Animations
    RTF_animTimer++;

    if (RTF_animTimer >= (60 / RTF_frameRate) && RTF_currentFrame != 4)
    {
        RTF_animTimer = 0;
        RTF_currentFrame++;
    }
	
	// Handle Music selection
    if (P1menuRowMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedMusic)
    {
        P1musicSelRow -= P1menuRowMove;
        P1cursorCooldown = 10;
    }

    if (P1menuRowMove == 0)
    {
        P1cursorCooldown = 0;
    }

    if (P1musicSelRow >= musicSelRowMax)
    {
        P1musicSelRow = 0;
    }

    if (P1musicSelRow < 0)
    {
        P1musicSelRow = musicSelRowMax - 1;
    }

    if (P1musicSelRow == 0)
    {
		selectedMusic = 0;
    }
	else if (P1musicSelRow == 1)
	{
		selectedMusic = 1;
	}
    else if (P1musicSelRow == 2)
    {
		selectedMusic = 2;
    }
    else if (P1musicSelRow == 3)
    {
		selectedMusic = 3;
    }
	else if (P1musicSelRow == 4)
    {
		selectedMusic = 4;
    }
    else
    {
        selectedMusic = 1;
    }

    if (P1switch)
    {
        state =  eCharacterSelectState.STAGE_SELECT;
        P1hasSelectedMap = false;

        RTF_animTimer = 0;
        RTF_currentFrame = 0;
    }
}
else if (state == eCharacterSelectState.TRANSITION_TO_FIGHT)
{
	// Increment the transition timer
	transitionTimer++;
	
	// On the first frame of transitioning...
	if (transitionTimer == 1)
	{
		// Spawn the transition object
		transitionObject = instance_create_depth(0, 0, -1000, oFightTransitionScreen);
		
		// Set the transition object's parameters
		transitionObject.transitionTimer = transitionTimer;
		transitionObject.transitionLength = transitionLength;
		transitionObject.transitionFrame = transitionFrame;
		
		transitionObject.transitionKOText_StartLeaving = transitionFrame - 20; // The frame to start moving the KO text away on
		transitionObject.transitionKOText_EndLeaving = transitionFrame - 1; // The frame to stop moving the KO text away on
		
		transitionObject.portaits_StartLeaving = transitionFrame - 10; // The frame to start moving the portaits away on
		transitionObject.portaits_EndLeaving = transitionFrame - 1; // The frame to stop moving the portaits away on
	}
	
	// If the timer has reached the transition frame...
	if (transitionTimer == transitionFrame)
	{
		// Go to the selected stage
		room_goto(selectedStage);
		// Update the game into versus mode
		global.gameMode = GAMEMODE.VERSUS;
	}
}