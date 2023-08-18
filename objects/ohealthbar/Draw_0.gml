/// @description Insert description here
// You can write your code in this editor

if (attatchedTo.hp <= 0)
{
	image_xscale = 0;
}

if (!global.togglePresentationMode)
{
	x = (global.camObj.x-80) + ui_xOffset;

	draw_self();
}