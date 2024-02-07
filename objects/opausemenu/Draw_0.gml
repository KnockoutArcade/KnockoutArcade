/// @description Insert description here
// You can write your code in this editor

switch (state)
{
	case (ePauseMenuState.MAIN) :
	{
		draw_self();
		
		// If we are past the opening animation, display the options
		if (sprite_index == sPauseMenu_MainBackdrop)
		{
			draw_sprite(sPauseMenu_SelectionLarge, 0, x + 16, y + 39 + (currentRow * 12));
			
			draw_sprite(sPauseMenu_MainOptions, 0, x, y);
		}
	}
	break;
	
	case (ePauseMenuState.ARE_YOU_SURE) :
	{
		draw_self();
		
		draw_sprite(sPauseMenu_SelectionLarge, 0, x + 16, y + 39 + (previousRow * 12));
			
		draw_sprite(sPauseMenu_MainOptions, 0, x, y);
		
		// Draw Are You Sure?
		draw_sprite(sPauseMenu_AreYouSure, playerNumber, x, y);
			
		draw_sprite(sPauseMenu_SelectionSmall, 0, x + 29, y + 61 + (currentRow * 12));
			
		draw_sprite(sPauseMenu_YesNo, 0, x, y);
	}
	break;
	
	case (ePauseMenuState.COMMAND_LISTS) :
	{
		draw_self();
		
		// Draw Base
		draw_sprite(sPauseMenu_CommandList_Base, (4 * playerNumber) + commandListCurrentTab, x, y);
			
		switch (commandListCharacter)
		{
			// Russel
			default:
			{
				// Draw name
				draw_sprite(sCharacterNames, 0, x + 65, y + 4);
				
				if (commandListCurrentTab == 0) // Command Inputs
				{
					draw_sprite(sCommandLists_Russel_CommandInputs, 0, x, y);
				}
				else if (commandListCurrentTab == 1) // Throws
				{
					draw_sprite(sCommandLists_Russel_Throws, 0, x, y);
				}
				else if (commandListCurrentTab == 2) // Specials
				{
					draw_sprite(sCommandLists_Russel_Specials, commandListCurrentPage, x, y);
				}
				else if (commandListCurrentTab == 3) // Supers
				{
					draw_sprite(sCommandLists_Russel_Supers, 0, x, y);
				}
				
			}
			break;
			
			// Beverly
			case 1:
			{
				// Draw name
				draw_sprite(sCharacterNames, 1, x + 64, y + 4);
				
				if (commandListCurrentTab == 0) // Command Inputs
				{
					draw_sprite(sCommandLists_Beverly_CommandInputs, 0, x, y);
				}
				else if (commandListCurrentTab == 1) // Throws
				{
					draw_sprite(sCommandLists_Beverly_Throws, 0, x, y);
				}
				else if (commandListCurrentTab == 2) // Specials
				{
					draw_sprite(sCommandLists_Beverly_Specials, commandListCurrentPage, x, y);
				}
				else if (commandListCurrentTab == 3) // Supers
				{
					draw_sprite(sCommandLists_Beverly_Supers, 0, x, y);
				}
			}
			break;
		}
	}
	break;
	
	case (ePauseMenuState.OPTIONS) :
	{
		draw_self();
		
		// Draw base Options menu
		draw_sprite(sPauseMenu_OptionsMenu, 0, x, y);
		draw_sprite(sPauseMenu_SelectionLarge, 0, x + 16, y + 39 + (currentRow * 12));
		draw_sprite(sPauseMenu_OptionsText, 0, x, y);
		
		// Draw Sliders
		draw_sprite(sPauseMenu_OptionsSlider, OptionsConvertDecimaltoWhole(global.musicVolume), x + 91, y + 40);
		draw_sprite(sPauseMenu_OptionsSlider, OptionsConvertDecimaltoWhole(global.sfxVolume), x + 91, y + 52);
		draw_sprite(sPauseMenu_OptionsSlider, OptionsConvertDecimaltoWhole(global.voicesVolume), x + 91, y + 64);

	}
	break;
}


