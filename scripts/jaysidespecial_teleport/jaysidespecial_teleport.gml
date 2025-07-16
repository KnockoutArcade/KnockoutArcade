// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function JaySideSpecial_Teleport()
{
	if (global.gameMode != GAMEMODE.VERSUS)
	{
		exit;
	}
	
	hasUsedAirSideSpecial = true;
	
	if (animTimer >= 12)
	{
		canCollideWithPlayers = false;
	}
	
	if (animTimer == 32)
	{
		x = opponent.x;
		y = 60; // Always teleports to the same height;
		grounded = false;
		
		var teleportDistance = 50 * previousMoveDir; // How far away to make Jay teleport from the opponent

		for (var i = 0; i < abs(teleportDistance); i++;)
		{
			if (!place_meeting(x + sign(teleportDistance), y, oWall))
			{
				x += sign(teleportDistance);
			}
			else
			{
				break;
			}
		}
		
		// Turn to face opponent
		if (x < opponent.x)
		{
			image_xscale = 1;
		}
		else
		{
			image_xscale = -1;
		}
		
		// Create particle effect
		var revealParticle = instance_create_layer(x, y, "Instances", oParticles);
		with (revealParticle) 
		{
			sprite_index = sJay_SideSpecial_Reappear;
			image_index = 0;
			image_xscale = other.image_xscale;
			lifetime = 30;
			depth = other.depth + 1;
		}
	}
}