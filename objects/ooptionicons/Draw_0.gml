/// @description Insert description here
// You can write your code in this editor

// Draw Music Buttons
if (image_index = 0 && P1menuLeft == -1)
{
	draw_sprite(sOptionsButtons, 0, 81, 16);
}
else if (image_index = 0 && P1menuRight)
{
	draw_sprite(sOptionsButtons, 2, 81, 16);
}
else
{
	draw_sprite(sOptionsButtons, 1, 81, 16);
}
draw_sprite(sOptionsMeter, OptionsConvertDecimaltoWhole(global.musicVolume), 81, 16);


// Draw SFX Buttons
if (image_index = 1 && P1menuLeft == -1)
{
	draw_sprite(sOptionsButtons, 0, 81, 37);
}
else if (image_index = 1 && P1menuRight)
{
	draw_sprite(sOptionsButtons, 2, 81, 37);
}
else
{
	draw_sprite(sOptionsButtons, 1, 81, 37);
}
draw_sprite(sOptionsMeter, OptionsConvertDecimaltoWhole(global.sfxVolume), 81, 37);


// Draw Voices Buttons
if (image_index = 2 && P1menuLeft == -1)
{
	draw_sprite(sOptionsButtons, 0, 81, 58);
}
else if (image_index = 2 && P1menuRight)
{
	draw_sprite(sOptionsButtons, 2, 81, 58);
}
else
{
	draw_sprite(sOptionsButtons, 1, 81, 58);
}
draw_sprite(sOptionsMeter, OptionsConvertDecimaltoWhole(global.voicesVolume), 81, 58);



draw_self();

if (isClosingOptionsMenu)
{
	draw_sprite(sOptionsPanelClose, exitingAnimationFrame, 0, 0);
}
