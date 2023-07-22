/// @description Insert description here
// You can write your code in this editor

var p1Pause = global.p1ButtonPause;
var p2Pause = global.p2ButtonPause;

if (!global.gameHalt)
{
	if (p1Pause || p2Pause)
	{
		show_debug_message(pauseTimer);
		
		pauseTimer++;
		if (pauseTimer >= 30)
		{
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
		global.gameHalt = false;
	}
}
