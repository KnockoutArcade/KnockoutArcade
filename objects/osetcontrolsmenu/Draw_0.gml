/// @description Insert description here
// You can write your code in this editor

draw_self();

switch (state)
{
	case eSetControlsState.ACTIVE:
	{
		draw_sprite(sControlsMenuUI_Selection, playerNumber, x + 6, y + 18 + (selectedRow * 10));
	}
	break;
}
