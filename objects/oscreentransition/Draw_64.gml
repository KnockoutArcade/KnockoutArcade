/// @description Insert description here
// You can write your code in this editor
if (screenTransitionType == eSCREENTRANSITIONS.WIPE)
{
	image_xscale = 5;
	image_yscale = 5;

	draw_self();
}
else
{
	draw_set_alpha(screenFadeTimer / screenFadeDuration);
	
	draw_rectangle_color(0, 0, 10000, 10000, c_black, c_black, c_black, c_black, false);
	
	draw_set_alpha(1);
}



