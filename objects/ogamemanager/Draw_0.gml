/// @description Insert description here
// You can write your code in this editor

depth = -1000;
// Draw the pause bar
switch (global.gameMode)
{
	case GAMEMODE.VERSUS:
	{
		var pauseFillAmount = max(pauseMenuButtonHeldTimer_P1, pauseMenuButtonHeldTimer_P2);
		
		if (pauseFillAmount > 0)
		{
			draw_sprite(sPauseBarBackground, 0, global.camObj.x - 80 + 61, global.camObj.y + 105);
			draw_sprite_ext(sPauseBar, 0, global.camObj.x - 80 + 64, global.camObj.y + 102, (pauseFillAmount / pauseMenuHoldRequirement) * 31, 1, 0, c_white, 1);
			draw_sprite(sPauseBarBackground, 1, global.camObj.x - 80 + 61, global.camObj.y + 105);
		}
	}
	break;	
}

