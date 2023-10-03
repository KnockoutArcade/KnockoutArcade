/// @description Insert description here
// You can write your code in this editor

if (lifetime < 1) 
{
	if (sprite_index == sRound1Start)
	{
		global.game_paused = false;
		
		// For all players, put them out of a cutscene state
		for (var i = 0; i < instance_number(oPlayerController); i++;)
		{
			var player = instance_find(oPlayerController, i);
			
			player.isInCutscene = false;
		}
	}
	else if (sprite_index == sRound2Start)
	{
		global.game_paused = false;
		
		// For all players, put them out of a cutscene state
		for (var i = 0; i < instance_number(oPlayerController); i++;)
		{
			var player = instance_find(oPlayerController, i);
			
			player.isInCutscene = false;
		}
	}
	else if (sprite_index == sFinalRoundStart)
	{
		global.game_paused = false;
		
		// For all players, put them out of a cutscene state
		for (var i = 0; i < instance_number(oPlayerController); i++;)
		{
			var player = instance_find(oPlayerController, i);
			
			player.isInCutscene = false;
		}
	}
	
	instance_destroy();
}

if (sprite_index == sKOText || sprite_index == sDoubleKOText)
{
	depth = 101;
}

lifetime--;

if image_index > (image_number - 1) image_speed = 0;
else image_speed = 1;
