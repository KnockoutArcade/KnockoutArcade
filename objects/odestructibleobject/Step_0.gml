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
		
		// Update Movement
		vsp += fallSpeed;
		
		if (grounded)
		{
			sprite_index = CharacterSprites.hurt_Sprite;
			
			// This code handles getting knocked back on the ground.
			if (knockbackVel > 0)
			{
				hsp = knockbackVel * knockbackDirection;
				knockbackVel--;
			} 
			else if (knockbackVel < 0) 
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
			x = xHome + min(global.hitstop, 3);
		}
		else 
		{
			x = xHome - min(global.hitstop, 3);
		}
		
		if (global.hitstop == 0)
		{
			state = eState.IDLE;
		}
	}
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

x += hsp;
y += vsp;

floor(y);
}


