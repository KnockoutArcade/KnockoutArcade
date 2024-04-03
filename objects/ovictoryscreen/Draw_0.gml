/// @description Insert description here
// You can write your code in this editor

if (!skipIntro)
{
	draw_self();

	draw_sprite(p1Portait, p1PortaitPalette, global.camObj.x - 80 + p1CharacterPortait_x, global.camObj.y + p1CharacterPortait_y);

	if (state != eVictoryScreenState.OPENING_ANIMATION)
	{
		draw_set_halign(fa_left);
		draw_set_valign(fa_center);
		draw_set_color(c_white);
		draw_set_font(victoryFont);
	
		draw_text_ext(global.camObj.x - 80 + 16, global.camObj.y + 95, displayQuote, 8, 130);
	
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
		draw_set_font(Font1);
	}
}

if (state == eVictoryScreenState.OPTIONS)
{
	draw_sprite(sVictoryScreen_OptionsBase, 0, global.camObj.x - 80, global.camObj.y);
	
	// Player Selections
	if (!P1hasSelectedresult)
	{
		draw_sprite(sVictoryScreen_OptionsSelection, 0, global.camObj.x - 80 + 13, global.camObj.y + 51 + (12 * P1resultSelRow));
	}
	if (!P2hasSelectedresult)
	{
		draw_sprite(sVictoryScreen_OptionsSelection, 0, global.camObj.x - 80 + 95, global.camObj.y + 51 + (12 * P2resultSelRow));
	}
	
	// Draw text
	draw_sprite(sVictoryScreen_OptionsText, 0, global.camObj.x - 80, global.camObj.y);
	
	// Player Confirmations
	if (P1hasSelectedresult)
	{
		draw_sprite(sVictoryScreen_OptionsSelection, 1, global.camObj.x - 80 + 13, global.camObj.y + 51 + (12 * P1resultSelRow));
	}
	if (P2hasSelectedresult)
	{
		draw_sprite(sVictoryScreen_OptionsSelection, 1, global.camObj.x - 80 + 95, global.camObj.y + 51 + (12 * P2resultSelRow));
	}
}