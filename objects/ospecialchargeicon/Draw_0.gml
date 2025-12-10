/// @description Insert description here
// You can write your code in this editor

if (global.game_paused || global.freezeTimer)
{
	image_speed = 0;
}
else
{
	image_speed = 1;
}

if (!global.togglePresentationMode && owner.hasSpecialCharge)
{
	x = global.camObj.x - 80 + ui_offsetX;
	y = global.camObj.y + ui_offsetY;
	
	draw_self();
}


