/// @description Insert description here
// You can write your code in this editor

if !global.gameHalt && !global.game_paused {

if frameTimer = 0 {
	global.gameTimer--;
	frameTimer = 60;
}

frameTimer--;

if global.gameTimer < 0 global.gameTimer = 0;

}