/// @description Insert description here
// You can write your code in this editor

var collidingPlayer = instance_place(x, y, oPlayerController);
if (collidingPlayer != noone)
{
	collidingPlayer.coinScore += coinValue;
	
	instance_destroy();
}


if (obeyGravity)
{
	vsp += fallSpeed;
	
	#region Slope Collision
	if (place_meeting(x, y + 2, oSlope) && sign(vsp) != -1)
	{
		y = floor(y);
	
		// Snap player to Slope's surface
		// If we are inside a slope, bring us out
		while (place_meeting(x, y - 1, oSlope))
		{
			y -= 1;
		}
		// If we are still touching a slope, bring us out
		if (place_meeting(x, y, oSlope))
		{
			y -=1;
		}
	
		// If we are above a slope, bring us down until we are barely touching it
		while (!place_meeting(x, y + 1, oSlope))
		{
			y += 1;
		}
		
		// If our downwards velocity is low enough, bounce off the ground
		if (vsp > 1)
		{
			vsp = -vsp * .5;
		}
		else
		{
			vsp = 0;
			
			// Apply traction
			if (abs(hsp) - traction >= 0)
			{
				hsp += traction * -sign(hsp);
			}
			else
			{
				hsp = 0;
			}
		}
	}
	#endregion
	
	#region Wall Collision
	if (place_meeting(x+hsp, y, oWall))
	{
		while (!place_meeting(x + sign(hsp), y, oWall))
		{
			x += sign(hsp);
		}
		
		hsp = -hsp;
	}
	
	if (place_meeting(x, y+vsp, oWall))
	{
		while (!place_meeting(x, y + sign(vsp), oWall))
		{
			y += sign(vsp);
		}
		
		// If our downwards velocity is low enough, bounce off the ground
		if (vsp > 1)
		{
			vsp = -vsp * .5;
		}
		else
		{
			vsp = 0;
			
			// Apply traction
			if (abs(hsp) - traction >= 0)
			{
				hsp += traction * -sign(hsp);
			}
			else
			{
				hsp = 0;
			}
		}
	}
	#endregion
	
	#region Semisolid Collision
	var semiSolidCollisionCheck = place_meeting(x, y+vsp, oSemiSolid);
	var collisionID = noone;

	if (semiSolidCollisionCheck)
	{
		//Determine wether we are rising into a ceiling or falling onto a floor.
		var fallDirection = sign(vsp);
	
		// Creates a list containing all of the semisolids we're colliding with.
		var semiSolidCollision_list = ds_list_create();
		collisionID = instance_place_list(x, y+vsp, oSemiSolid, semiSolidCollision_list, false); // Tells us how many objects we are colliding with
	
		// Iterate through each semisolid
		for (var i = 0; i < collisionID; i++;)
		{
			// Determine if we are above the platform's surface
			if (y < semiSolidCollision_list[| i].y + 1) && (fallDirection == 1)
			{
				while (!place_meeting(x, y + sign(vsp), semiSolidCollision_list[| i]))
				{
					y += sign(vsp);
				}
		
				// If our downwards velocity is low enough, bounce off the ground
				if (vsp > 1)
				{
					vsp = -vsp * .5;
				}
				else
				{
					vsp = 0;
			
					// Apply traction
					if (abs(hsp) - traction >= 0)
					{
						hsp += traction * -sign(hsp);
					}
					else
					{
						hsp = 0;
					}
				}
			}
		}
	
		ds_list_destroy(semiSolidCollision_list);
	}
	#endregion
}

y += vsp;
x += hsp;

