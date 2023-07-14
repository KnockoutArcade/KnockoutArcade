// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SpeedTrail(setStartingOpacity, setFadeSpeed, interval)
{
	if (speedTrailTimer >= interval)
	{
		speedTrailTimer = 0;
		object_set_sprite(oSpeedTrail, sprite_index);
		var instance = instance_create_layer(x, y, "Instances", oSpeedTrail);
		var this = object_index;
		var thisCharacter = selectedCharacter;
		var opponentCharacter = noone;
		if (opponent != noone)
		{
			opponentCharacter = opponent.selectedCharacter;
		}
		with (instance)
		{
			image_index = this.image_index;
			if (opponentCharacter != noone)
			{
				// For some reason, the player 2 sprite is flipped during mirror matches
				if (thisCharacter == opponentCharacter && this.playerID == 2)
				{
					image_xscale = -this.image_xscale;
				}
				else
				{
					image_xscale = this.image_xscale;
				}
			}
			else
			{
				image_xscale = this.image_xscale;
			}
			
			if (this.playerID == 1)
			{
				PaletteSetup(global.p1PaletteID, this.selectedCharacter);
			}
			else
			{
				PaletteSetup(global.p2PaletteID, this.selectedCharacter);
			}
			startingOpacity = setStartingOpacity;
			fadeSpeed = setFadeSpeed;
			initialized = true;
		}
	}
	speedTrailTimer++;
}