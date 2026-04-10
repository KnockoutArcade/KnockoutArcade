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
			sprite_index = CharacterSprites.quickGetup_Sprite;
		}
		else
		{
			state = eState.TECH_ROLL;
			sprite_index = CharacterSprites.techRoll_Sprite;
			
			image_xscale = -movedir;
		}
	}
		
	image_index = 0;
	hsp = 0;
	image_speed = 1;
	gravityScaling = 0;
	hitstun = 0;
	ClearOwnerHitByGroups();
	invincible = true;
	hasUsedWallBounce = false;
	hasUsedFloorBounce = false;
	
	// Handle spawning impact particle
	// Spawn a landing particle once the player hits the ground
	var landingParticle = instance_create_layer(x, y, "Instances", oParticles);
	with (landingParticle) 
	{
		sprite_index = sKnockdownParticle;
		image_index = 0;
		image_xscale = other.image_xscale;
		lifetime = 17;
		depth = other.depth + 1;
	}
}