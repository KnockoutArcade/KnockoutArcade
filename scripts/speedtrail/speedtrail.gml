// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SpeedTrail(setStartingOpacity, setFadeSpeed, interval)
{
	// For each interval of the speed timer.
	if (speedTrailTimer >= interval)
	{
		speedTrailTimer = 0;
		object_set_sprite(oSpeedTrail, sprite_index);
		var speedTrailInstance = instance_create_layer(x, y, "Instances", oSpeedTrail);
		
		with (speedTrailInstance)
		{
			image_index = other.image_index;
			
			image_xscale = other.image_xscale;
			
			// Set up the palette data for the speed trail
			if (array_length(other.selectedCharacter.BasePalette) > 0)
			{
				hasColorPalettes = true;
				if (other.playerID == 1)
				{
					PaletteSetup(global.p1PaletteID, other.selectedCharacter);
				}
				else
				{
					PaletteSetup(global.p2PaletteID, other.selectedCharacter);
				}
			}
			else
			{
				hasColorPalettes = false;
			}
			
			// Initialize variables
			startingOpacity = setStartingOpacity;
			fadeSpeed = setFadeSpeed;
			initialized = true;
		}
	}
	
	// Increment the speed trail timer
	speedTrailTimer++;
}