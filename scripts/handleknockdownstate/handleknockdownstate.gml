// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function HandleKnockdownState( _hardKnockdown)
{
	// Handle Hard Knockdown
	if (_hardKnockdown)
	{
		state = eState.KNOCKED_DOWN;
		sprite_index = CharacterSprites.knockdown_Sprite;
	}
	else // Handle soft knockdown
	{
		if (movedir == 0)
		{
			state = eState.QUICK_GETUP;
			sprite_index = sRussel_QuickGetup;
			
			// TEMPORARY
			if (selectedCharacter.Name == "Beverly")
			{
				sprite_index = sBeverly_QuickGetup;
			}
		}
		else
		{
			state = eState.TECH_ROLL;
			sprite_index = sRussel_TechRoll;
			
			// TEMPORARY
			if (selectedCharacter.Name == "Beverly")
			{
				sprite_index = sBeverly_TechRoll;
			}
			
			image_xscale = -movedir;
		}
	}
		
	image_index = 0;
	hsp = 0;
	image_speed = 1;
	gravityScaling = 0;
	
	// Handle spawning impact particle
	// Spawn a landing particle once the player hits the ground
	var landingParticle = instance_create_layer(x, y, "Instances", oParticles);
	with (landingParticle) 
	{
		sprite_index = sLandingParticle;
		image_index = 0;
		image_xscale = other.image_xscale;
		lifetime = 20;
		depth -= 1;
	}
}