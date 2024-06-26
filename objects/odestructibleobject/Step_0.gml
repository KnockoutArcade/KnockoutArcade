/// @description Insert description here
// You can write your code in this editor

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
					if (!doesBounceOnTerrain) 
					{
						hsp = 0;
					}
					else
					{
						hsp = hsp * bounceDampeningFactor;
						
						if (abs(hsp) <= 0.1)
						{
							hsp = 0;
						}
					}
					knockbackVel = 0;
				}
			} 
			else
			{
				knockbackVel = 0;
			}
			
			if (hitstun > 0)
			{
				hitstun--;
			}
			else
			{
				ds_list_clear(hitByGroup);
			}
			
			// Destroy this object if at 0 hp and this object has no unique death properties
			if (hp <= 0 && !hasUniqueDeath)
			{
				DropCoins(coinsToDrop);
				
				instance_destroy(hurtbox);
				if (hasWallCollision)
				{
					instance_destroy(wallCollisionBox);
				}
				ds_list_destroy(hitByGroup);
				state = eState.OBJECT_DESTROYED;
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
			
			// Show Damage according to health
			if (hp < (MaxHitPoints * 0.45))
			{
				image_index = 2;
			}
			else if (hp < (MaxHitPoints * 0.95))
			{
				image_index = 1;
			}
			
		}
	}
	break;
	
	case eState.OBJECT_DESTROYED:
	{
		// Set sprite to the destroyed sprite
		image_index = 3;
		
		// Increment despawn timer
		despawnTimer++;
	
		// Alternate visibilty (blink while despawning)
		if (despawnTimer mod blinkInterval == 0)
		{
			if (visible)
			{
				visible = false;
			}
			else
			{
				visible = true;
			}
		}
	
		// Destroy the object
		if (despawnTimer >= despawnLength)
		{
			instance_destroy();
		}
	}
	break;
}

if (state != eState.HITSTOP)
{
	// Animating pushback
	xHome = x;
	if (pushbackVel >= 0)
	{
		hsp = pushbackVel * -image_xscale;
		pushbackVel--;
	}
	
	
	// Using y + 2 so that if this object is going downhill on a slope, they can stay snapped to the surface
	// Otherwise, this object would jitter as they went down
	if (place_meeting(x, y + 2, oSlope) && state != eState.BEING_GRABBED && sign(vsp) != -1)
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
	
		if (state != eState.HITSTOP)
		{
			// Handle bouncing off of terrain
			if (!doesBounceOnTerrain)
			{
				vsp = 0;
			}
			else
			{
				vsp = -vsp * bounceDampeningFactor;
				
				if (abs(vsp) <= 0.5)
				{
					vsp = 0;
				}
			}
			
		}
		
		if (!grounded && vsp == 0) 
		{
			state = eState.IDLE;
			grounded = true;
			inAttackState = false;
		}
	}
	
	// Collisions With Walls
	if (place_meeting(x+hsp, y, oWall) && state != eState.BEING_GRABBED)
	{
		while (!place_meeting(x+sign(hsp), y, oWall)) 
		{
			x += sign(hsp);
		}
		
		// Handle bouncing off of terrain
		if (!doesBounceOnTerrain)
		{
			hsp = 0;
		}
		else
		{
			hsp = -hsp * bounceDampeningFactor;
		
			if (abs(hsp) <= 0.1)
			{
				hsp = 0;
			}
		}
	}
	
	if (place_meeting(x, y+vsp+fallSpeed, oWall))
	{
		//Determine wether we are rising into a cieling or falling onto a floor.
		var fallDirection = sign(vsp);
		
		while (!place_meeting(x, y + sign(vsp+fallSpeed), oWall))
		{
			y += sign(vsp);
		}
		
		// Handle bouncing off of terrain
		if (!doesBounceOnTerrain)
		{
			vsp = 0;
		}
		else
		{
			vsp = -vsp * bounceDampeningFactor;
			
			if (abs(vsp) <= 0.5)
			{
				vsp = 0;
			}
		}
			
		if (!grounded && vsp == 0) 
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
		
				// Handle bouncing off of terrain
				if (!doesBounceOnTerrain)
				{
					vsp = 0;
				}
				else
				{
					vsp = -vsp * bounceDampeningFactor;
				
					if (abs(vsp) <= 0.5)
					{
						vsp = 0;
					}
				}
				
				if (!grounded && vsp == 0) 
				{
					state = eState.IDLE;
					grounded = true;
					inAttackState = false;
				}
			}
		}
	
		ds_list_destroy(semiSolidCollision_list);
	}
	
	// Update Movement
	if (!global.freezeTimer && state != eState.OBJECT_DESTROYED)
	{
		x += hsp;
		y += vsp;
		
		floor(y);
	}
}


