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
}


