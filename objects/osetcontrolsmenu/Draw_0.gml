/// @description Insert description here
// You can write your code in this editor

draw_self();

switch (state)
{
	case eSetControlsState.ACTIVE:
	{	
		// Draw the options
		for (var i = 0; i < maxOnScreenOptions; i++;) // for each on screen option (there's 8)
		{
			#region Draw that option's backdrop
			
			if (controlsOptions[topRowOption + i] < 4) // If the option is a direction...
			{
				draw_sprite(sControlsMenuUI_InputBackgrounds, 0, x + 9, y + 20 + (i * 10));
			}
			else if (controlsOptions[topRowOption + i] < 8) // If the option is an attack
			{
				draw_sprite(sControlsMenuUI_InputBackgrounds, 1, x + 9, y + 20 + (i * 10));
			}
			else if (controlsOptions[topRowOption + i] < 11) // If the option is an action
			{
				draw_sprite(sControlsMenuUI_InputBackgrounds, 2, x + 9, y + 20 + (i * 10));
			}
			
			#endregion
		}
		
		
		// Draw our Cursor
		draw_sprite(sControlsMenuUI_Selection, playerNumber, x + 6, y + 18 + (selectedRow * 10));
	}
	break;
}
