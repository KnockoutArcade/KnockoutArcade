/// @description Insert description here
// You can write your code in this editor

if (lifetime < 1) 
{
	if (sprite_index == sRound1Start)
	{
		global.game_paused = false;
	}
	else if (sprite_index == sRound2Start)
	{
		global.game_paused = false;
	}
	else if (sprite_index == sFinalRoundStart)
	{
		global.game_paused = false;
	}
	instance_destroy();
}

lifetime--;

if image_index > (image_number - 1) image_speed = 0;
else image_speed = 1;
