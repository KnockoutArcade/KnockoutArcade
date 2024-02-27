/// @description Insert description here
// You can write your code in this editor

if (global.toggleHitboxVisibility) 
{
	draw_set_alpha(.5);
	draw_set_color(c_black);
	draw_rectangle(195, 195, 220, 220, false);
	draw_set_alpha(1);
	draw_set_color(c_white);

	draw_text(200, 200, frameAdvantage);
}

// Results Screen
if (state == eGameManagerState.POST_MATCH)
{
	// Player 1 buttons
	//draw_sprite(sResults_Options, 0, 30, 400);
	//draw_sprite(sResults_Cursor_strip2, P1hasSelectedresult, 40, 410 + (46 * P1resultSelRow));
	
	
	// Player 2 buttons
	//draw_sprite(sResults_Options, 0, 500, 400);
	//draw_sprite(sResults_Cursor_strip2, P2hasSelectedresult, 510, 410 + (46 * P2resultSelRow));
}