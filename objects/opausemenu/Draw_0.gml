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
}


