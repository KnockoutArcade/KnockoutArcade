/// @description Insert description here
// You can write your code in this editor

if startTextTimer > 29 {
	startTextShow = !startTextShow;
	startTextTimer = 0;
	
}

if startTextShow draw_sprite(sStartText, 0, 0, 0);