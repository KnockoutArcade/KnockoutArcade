/// @description Insert description here
// You can write your code in this editor

var p1Pause = global.p1ButtonPause;
var p2Pause = global.p2ButtonPause;

if (!global.gameHalt && global.hasCompletedIntros && !global.game_paused)
{
	if (p1Pause || p2Pause)
	{
		pauseTimer++;
		if (pauseTimer >= 30)
		{
			paused = true;
			global.gameHalt = true;
		}
	}
	else if (!p1Pause && !p2Pause)
	{
		pauseTimer = 0;
	}
}
else 
{
	if (!p1Pause && !p2Pause)
	{
		buttonReleased = true;
	}
	if ((p1Pause || p2Pause) && buttonReleased)
	{
		pauseTimer = 0;
		buttonReleased = false;
		paused = false;
		global.gameHalt = false;
	}
}
