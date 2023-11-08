// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function HandleWalkingOffPlatforms(maintainState)
{
	// Handle Walking off platforms by checking for a semisolid below us
	#region
	
	var semiSolidCollisionCheck = place_meeting(x, y+1, oSemiSolid);
	var collisionID = noone;
	
	// Creates a list containing all of the semisolids we're colliding with.
	var semiSolidCollision_list = ds_list_create();
	collisionID = instance_place_list(x, y+1, oSemiSolid, semiSolidCollision_list, false); // Tells us how many objects we are colliding with
	
	// In order to fall off, the player's y coordinate MUST be GREATER than every semisolid they are colliding with
	var canFallThrough = true;
	
	if (semiSolidCollisionCheck)
	{
		
		// Iterate through each semisolid
		for (var i = 0; i < collisionID; i++;)
		{
			// Determine if we are above the platform's surface
			if (floor(y) <= semiSolidCollision_list[| i].y)
			{
				// If we are above ANY of the surfaces, don't fall through
				canFallThrough = false;
			}
		}
		
		if (canFallThrough)
		{
			//Handle walking off of platforms by checking if solid ground is below us
			if (!place_meeting(x, y+1, oWall) && !place_meeting(x, y+8, oSlope))
			{
				if (!maintainState)
				{
					state = eState.JUMPING;
					image_index = 2;
				}
				grounded = false;
				isThrowable = true;
		
				jumpHsp = hsp;
			}
		}
	}
	
	ds_list_destroy(semiSolidCollision_list);
	#endregion
	
	//Handle walking off of platforms by checking if solid ground is below us
	if (!place_meeting(x, y+1, oWall) && canFallThrough && !place_meeting(x, y+8, oSlope))
	{
		if (!maintainState)
		{
			state = eState.JUMPING;
			image_index = 2;
		}
		grounded = false;
		isThrowable = true;
		
		jumpHsp = hsp;
	}
}