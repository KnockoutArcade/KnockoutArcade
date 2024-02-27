/// @description Insert description here
// You can write your code in this editor

draw_self();

draw_sprite(p1Portait, global.p1PaletteID, global.camObj.x - 80 + p1CharacterPortait_x, global.camObj.y + p1CharacterPortait_y);


	draw_set_halign(fa_left);
	draw_set_valign(fa_center);
	draw_set_color(c_white);
	draw_set_font(fntVictoryQuote);
	
	draw_text_ext(global.camObj.x - 80 + 15, global.camObj.y + 84, "TEST TEST TEST TEST TEST", 20, 120);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_set_font(Font1);

