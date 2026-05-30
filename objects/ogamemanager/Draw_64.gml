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

if (global.gameMode == GAMEMODE.TRAINING)
{
	draw_set_alpha(0.8);
	draw_set_color(c_black);
	draw_rectangle(255, 130, 540, 245, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	draw_set_font(fntTrainingMode);
	draw_set_halign(fa_center);
	draw_text(400, 130, "Damage");
	draw_text(400, 150, "Combo Damage");
	
	draw_set_halign(fa_left);
	draw_set_font(Font1);
}