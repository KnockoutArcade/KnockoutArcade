/// @description Insert description here
// You can write your code in this editor

// Remove this objects collision if it is not supposed to have it
if (!hasWallCollision)
{
	instance_destroy(wallCollisionBox);
}

switch (state)
{
	case eState.IDLE:
	{
		cancelCombo = true; // Combo Counter shouldn't show up on Destructable Objects
		
		if (!global.freezeTimer)
		{
			// Update Movement
			vsp += fallSpeed;
			
			if (grounded)
			{
				sprite_index = CharacterSprites.hurt_Sprite;
				
				// This code handles getting knocked back on the ground.
				// We use 1 instead of 0 to make sure any decimal values just get ignored.
				// It would be possible if our knockbackVel had a value of 2.5 for example. Since
				// we only decrease KnockbackVel by 1, the remaining .5 would cause the object
				// to occillate.
				if (knockbackVel > 1)
				{
					hsp = knockbackVel * knockbackDirection;
					knockbackVel--;
				} 
				else if (knockbackVel < -1) 
				{
					hsp = knockbackVel * knockbackDirection;
					knockbackVel++;
				}
				else
				{
					hsp = 0;
					knockbackVel = 0;
				}
			} 
			
			if (hitstun > 0)
			{
				hitstun--;
			}
			else
			{
				ds_list_clear(hitByGroup);
			}
			
			// Destroy this object if at 0 hp
			if (hp <= 0)
			{
				instance_destroy(hurtbox);
				if (hasWallCollision)
				{
					instance_destroy(wallCollisionBox);
				}
				ds_list_destroy(hitByGroup);
				instance_destroy();
				oPlayerController.target = noone;
			}
		}
	}
	break;
	
	case eState.HITSTOP:
	{
		hitstunShuffleTimer++;
	
		if (!isGrabbed)
		{
			sprite_index = CharacterSprites.hurt_Sprite;
		}
		
		if (hitstunShuffleTimer % 2 == 1)
		{
			shuffle++;
		}

		if (shuffle % 2 == 1)
		{
			x = xHome + min(hitstop, 3);
		}
		else 
		{
			x = xHome - min(hitstop, 3);
		}
		
		hitstop--;
		
		if (hitstop == 0)
		{
			state = eState.IDLE;
			x = xHome;
		}
	}
	break;
}

if (state != eState.HITSTOP)
{
	xHome = x;
	if (pushbackVel >= 0)
	{
		hsp = pushbackVel * -image_xscale;
		pushbackVel--;
	}
	
	// Collisions With Walls
	if (place_meeting(x+hsp, y, oWall) && state != eState.BEING_GRABBED)
	{
		while (!place_meeting(x+sign(hsp), y, oWall)) 
		{
			x += sign(hsp);
		}
		hsp = 0;
	}
	
	if (place_meeting(x, y+vsp+fallSpeed, oWall))
	{
		//Determine wether we are rising into a cieling or falling onto a floor.
		var fallDirection = sign(vsp);
		
		while (!place_meeting(x, y + sign(vsp+fallSpeed), oWall))
		{
			y += sign(vsp);
		}
		
		vsp = 0;
		if (!grounded && state != eState.LAUNCHED && state != eState.HURT && state != eState.NEUTRAL_SPECIAL && state != eState.SIDE_SPECIAL && fallDirection == 1) 
		{
			state = eState.IDLE;
			grounded = true;
			inAttackState = false;
		}
	}
	
	// Semisolid Platform Collision
	var semiSolidCollisionCheck = place_meeting(x, y+vsp+fallSpeed, oSemiSolid);
	var collisionID = noone;

	if (semiSolidCollisionCheck) && (state != eState.BEING_GRABBED)
	{
		//Determine wether we are rising into a ceiling or falling onto a floor.
		var fallDirection = sign(vsp);
	
		// Creates a list containing all of the semisolids we're colliding with.
		var semiSolidCollision_list = ds_list_create();
		collisionID = instance_place_list(x, y+vsp+fallSpeed, oSemiSolid, semiSolidCollision_list, false); // Tells us how many objects we are colliding with
	
		// Iterate through each semisolid
		for (var i = 0; i < collisionID; i++;)
		{
			// Determine if we are above the platform's surface
			if (y < semiSolidCollision_list[| i].y + 1) && (fallDirection == 1)
			{
				while (!place_meeting(x, y + sign(vsp+fallSpeed), semiSolidCollision_list[| i]))
				{
					y += sign(vsp);
				}
		
				vsp = 0;
				if (!grounded && state != eState.LAUNCHED && state != eState.HURT && state != eState.NEUTRAL_SPECIAL && state != eState.SIDE_SPECIAL && fallDirection == 1) 
				{
					state = eState.IDLE;
					grounded = true;
					inAttackState = false;
				}
			}
		}
	
		ds_list_destroy(semiSolidCollision_list);
	}
	
	// Handle Hurtbox Placement
	with (hurtbox)
	{
		
	}
	
	
	if (!global.freezeTimer)
	{
		x += hsp;
		y += vsp;
		
		floor(y);
	}
}


