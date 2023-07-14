/// @description Insert description here
// You can write your code in this editor


// Player 1 cursor vars
var P1menuLeft = global.p1ButtonLeft;
var P1menuRight = global.p1ButtonRight;
var P1menuColMove = P1menuLeft + P1menuRight;

var P1menuUp = global.p1ButtonUp;
var P1menuDown = global.p1ButtonDown;
var P1menuRowMove = P1menuUp + P1menuDown;

var P1menuConfirm = global.p1ButtonLight;
var P1menuCancel = global.p1ButtonMedium;
var P1switch = global.p1ButtonHeavy;
var P1menuConfirmBuffer = false;
var P1menuAltSelBuffer = false;
var P1menuMapSelBuffer = false;
var P1menuMusicSelBuffer = false;

// Player 2 cursor vars
var P2menuLeft = global.p2ButtonLeft;
var P2menuRight = global.p2ButtonRight;
var P2menuColMove = P2menuLeft + P2menuRight;

var P2menuUp = global.p2ButtonUp;
var P2menuDown = global.p2ButtonDown;
var P2menuRowMove = P2menuUp + P2menuDown;

var P2menuConfirm = global.p2ButtonLight;
var P2menuCancel = global.p2ButtonMedium;

var P2menuConfirmBuffer = false;

P1cursorCooldown--;
P2cursorCooldown--;

if (state == 0)
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

    // Handle P1 cursor movement
    if (P1menuColMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedChar)
    {
        P1charSelCol += P1menuColMove;
        P1cursorCooldown = 10;
    }
    if (P1menuRowMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedChar)
    {
        P1charSelRow += P1menuRowMove;
        P1cursorCooldown = 10;
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

    if (P1menuConfirm && !P1hasSelectedChar)
    {
        P1hasSelectedChar = true;
        P1menuConfirmBuffer = true;

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
        else
        {
            P1hasSelectedChar = false;
            P1menuConfirmBuffer = false;
        }
    }

    if (P1menuCancel)
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
        else if (!P2hasSelectedChar)
        {
            // If neither player has chosen a character, return to main menu
            room_goto(rMainMenu);
        }

        RTF_animTimer = 0;
        RTF_currentFrame = 0;
    }

    // Handle Palette Selection
    if (P1hasSelectedChar)
    {
        if (P1menuColMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedAlt)
        {
            global.p1PaletteID += P1menuColMove;
            P1cursorCooldown = 10;
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
        }
    }


    // Handle P2 cursor movement
    if (P2menuColMove != 0 && P2cursorCooldown < 1 && !P2hasSelectedChar)
    {
        P2charSelCol += P2menuColMove;
        P2cursorCooldown = 10;
    }
    if (P2menuRowMove != 0 && P2cursorCooldown < 1 && !P2hasSelectedChar)
    {
        P2charSelRow += P2menuRowMove;
        P2cursorCooldown = 10;
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


    if (P2menuConfirm && !P2hasSelectedChar)
    {
        P2hasSelectedChar = true;
        P2menuConfirmBuffer = true;
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
        else
        {
            P2hasSelectedChar = false;
            P2menuConfirmBuffer = false;
        }
    }

    if (P2menuCancel)
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

        RTF_animTimer = 0;
        RTF_currentFrame = 0;
    }

    // Handle Palette Selection
    if (P2hasSelectedChar)
    {
        if (P2menuColMove != 0 && P2cursorCooldown < 1 && !P2hasSelectedAlt)
        {
            global.p2PaletteID += P2menuColMove;
            P2cursorCooldown = 10;
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

    if (P1hasSelectedAlt && P2hasSelectedAlt)
    {
        // Go to stage select
        state = 1;
    }
}
else if (state == 1)
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
    }

    if (P1menuRowMove != 0 && P1cursorCooldown < 1 && !P1hasSelectedMap)
    {
        P1mapSelRow += P1menuRowMove;
        P1cursorCooldown = 10;
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

    if (P1menuConfirm && !P1menuConfirmBuffer && !P1hasSelectedMap)
    {
        P1hasSelectedMap = true;
        P1menuMapSelBuffer = true;

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
			
			room = rRusselStage;
			global.gameMode = GAMEMODE.VERSUS;
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
			
			room = rBeverlyStage;
			global.gameMode = GAMEMODE.VERSUS;
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
			
			room = rJayStage;
			global.gameMode = GAMEMODE.VERSUS;
        }
        else if (P1mapSelCol == 3 && P1mapSelRow == 1)
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
				
				room = rRusselStage;
				global.gameMode = GAMEMODE.VERSUS;
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
				
				room = rBeverlyStage;
				global.gameMode = GAMEMODE.VERSUS;
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
				
				room = rJayStage;
				global.gameMode = GAMEMODE.VERSUS;
            }
			else if (P1mapSelCol == 3 && P1mapSelRow == 0)
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
				
				room = rStageArcade;
				global.gameMode = GAMEMODE.VERSUS;
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
		state = 2;
		
		RTF_animTimer = 0;
        RTF_currentFrame = 0;
	}

    if (P1menuCancel)
    {
        state = 0;
        P1hasSelectedAlt = false;

        RTF_animTimer = 0;
        RTF_currentFrame = 0;
    }
}
else if (state == 2)
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
        state = 1;
        P1hasSelectedMap = false;

        RTF_animTimer = 0;
        RTF_currentFrame = 0;
    }
}