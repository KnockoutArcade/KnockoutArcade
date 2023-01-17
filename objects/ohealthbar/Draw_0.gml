/// @description Insert description here
// You can write your code in this editor

x = (global.camObj.x-80) + ui_xOffset;

if ui_xOffset > 80 {
	draw_sprite(sUIBase, 0, (global.camObj.x-80), 0);
}

draw_self();

