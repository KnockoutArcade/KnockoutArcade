/// @description Insert description here
// You can write your code in this editor

if global.gameTimer > -1 {
if string_length(global.gameTimer) > 1 {
	draw_sprite(sTimer9, string_char_at(global.gameTimer, 1), (global.camObj.x-80) + 74, 25);
	draw_sprite(sTimer9, string_char_at(global.gameTimer, 2), (global.camObj.x-80) + 87, 25);
} 
else {
	draw_sprite(sTimer9, 0, (global.camObj.x-80) + 74, 25);
	draw_sprite(sTimer9, string_char_at(global.gameTimer, 1), (global.camObj.x-80) + 87, 25);
}
}
