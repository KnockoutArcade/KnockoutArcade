/// @description Insert description here
// You can write your code in this editor

x = (global.camObj.x-80) + ui_xOffset;

// Display proper frame when the meter is empty, half-full, and full
if (owner.superMeter > 49)
{
	image_index = 1;
	meterIndex = 0;
}
else 
{
	image_index = 0;
	meterIndex = 0;
}
if (owner.superMeter > 99)
{
	image_index = 2;
	meterIndex = 1;
}

draw_self();

// Fill up depending on how full the player's meter is
if (meterDir = -1)
{
	draw_sprite_ext(sSuperMeterBar, meterIndex, x+4 + 53, y+7, ((meterDir * owner.superMeter) / 100) * 53, 1, 0, c_white, 1);
}
else if (meterDir == 1) 
{
	draw_sprite_ext(sSuperMeterBar, meterIndex, x+4, y+7, ((meterDir * owner.superMeter) / 100) * 53, 1, 0, c_white, 1);
}





