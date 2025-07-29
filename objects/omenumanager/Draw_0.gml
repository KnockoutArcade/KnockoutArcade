/// @description Insert description here
// You can write your code in this editor

if (startTextTimer > 29)
{
	startTextShow = !startTextShow;
	startTextTimer = 0;
	
}

if (startTextShow)
{
	draw_sprite(sStartText, 0, 0, 0);
}


// Draw the logo
if (animTimer > logoAppearStart && animTimer < logoAppearEnd)
{
	var sizeEquasion = (logoAppearEnd - logoAppearStart) / (animTimer - 16);
	
	draw_sprite_ext(sLogo, 0, 80, 60, sizeEquasion, sizeEquasion, 0, c_white, 1);
}
else if (animTimer >= logoAppearEnd)
{
	draw_sprite(sLogo, 0, 80, 60);
}