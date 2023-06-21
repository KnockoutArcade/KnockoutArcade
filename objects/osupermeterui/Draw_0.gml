/// @description Insert description here
// You can write your code in this editor
depth = -100;

x = (global.camObj.x-80) + ui_xOffset;

// Display proper frame when the meter is empty, half-full, and full
if (owner.superMeter >= 50)
{
	image_index = 1;
	meterIndex = 0;
}
else 
{
	image_index = 0;
	meterIndex = 0;
}
if (owner.superMeter >= 100)
{
	image_index = 2;
	meterIndex = 1;
}

draw_sprite(sSuperMeterBackground, 0, x, y);

// Cap the display at 100
var displayMeter = min(owner.superMeter, 100);

// Fill up depending on how full the player's meter is
if (meterDir = -1)
{
	draw_sprite_ext(sSuperMeterBar, meterIndex, x+4 + 53, y+7, ((meterDir * displayMeter) / 100) * 53, 1, 0, c_white, 1);
}
else if (meterDir == 1) 
{
	draw_sprite_ext(sSuperMeterBar, meterIndex, x+4, y+7, ((meterDir * displayMeter) / 100) * 53, 1, 0, c_white, 1);
}

draw_self();



