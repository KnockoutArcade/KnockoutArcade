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

if (global.gameMode == GAMEMODE.TRAINING && pauseMenuObject == noone)
{
	draw_set_alpha(0.8);
	draw_set_color(c_black);
	draw_rectangle(240, 130, 555, 255, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	draw_set_font(fntTrainingMode);
	draw_set_halign(fa_center);
	draw_text(400, 130, "Damage (Scaling)");
	draw_text(400, 155, "Combo Damage");
	draw_text(400, 180, "Max Damage");
	draw_text(400, 205, "Startup (Duration)");
	draw_text(400, 230, "Frame Advantage");
	
	draw_set_halign(fa_right);
	draw_text(315, 130, 0);
	draw_text(315, 155, string(p1.storedComboDamage));
	draw_text(315, 180, string(p1MaxComboDamage));
	
	draw_set_halign(fa_left);
	draw_set_font(Font1);
}