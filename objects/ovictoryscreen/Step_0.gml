/// @description Insert description here
// You can write your code in this editor

animTimer++;

switch (state)
{
	case eVictoryScreenState.OPENING_ANIMATION:
	{
		if (image_index >= image_number - 1)
		{
			image_index = 7;
		}
		
		if (animTimer >= portaits_StartMoving && animTimer < portaits_EndMoving)
		{
			p1CharacterPortait_x = lerp(p1CharacterPortait_x, p1CharacterPortait_EndingPosition[0], 0.1);
		}
		
		if (image_index >= 7 && animTimer >= portaits_EndMoving)
		{
			state = eVictoryScreenState.DISPLAY_WIN_QUOTE;
		}
	}
	break;
	
	case eVictoryScreenState.DISPLAY_WIN_QUOTE:
	{
		image_speed = 0;
		
		// Print text
		if (animTimer mod 2 == 0)
		{
			if (quotePrintingLength < quoteLength)
			{
				quotePrintingLength += 1;
				
				displayQuote = string_copy(winQuote, 1, quotePrintingLength);
			}
		}
		
		// If we press any button
		if (keyboard_check_pressed(vk_anykey) || GamepadCheck(global.player1ControllerSlot) || GamepadCheck(global.player2ControllerSlot))
		{
			// If we still printing the quote, instantly complete it.
			if (quotePrintingLength < quoteLength)
			{
				displayQuote = winQuote;
				quotePrintingLength = quoteLength;
			}
			else
			{
				// Otherwise, transition into the options state.
				state = eVictoryScreenState.OPTIONS;
			}
		}
	}
	break;
	
	case eVictoryScreenState.OPTIONS:
	{
		image_speed = 0;
		
		ResultsScreen();
	}
	break;
}


