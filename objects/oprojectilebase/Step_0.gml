/// @description Insert description here
// You can write your code in this editor

if (global.game_paused)
{
	exit;
}

if (!global.gameHalt)
{
	if (place_meeting(x+hsp, y, oWall))
	{
		instance_destroy();
	}
	
	x += hsp * image_xscale;
}
