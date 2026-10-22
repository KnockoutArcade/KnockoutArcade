/// @description Insert description here
// You can write your code in this editor

// If our host is missing, exit
if (host == noone || hostObject == noone)
{
	exit;
}

// Pause function, cancel event
if (global.game_paused)
{
	image_speed = 0;
	exit;
}
else
{
	image_speed = 1;
}

// A number of things will function similarly to a regular character, but 
// a lot will be cut out since this isn't its own character

// This sets the hurtbox data properly
if (!hurtboxSet)
{
	var hostID = hostObject;
	with(hurtbox)
	{
		owner = hostID;
		calledBySpirit = true;
		spirit = other.id;
	}
	hurtboxSet = true;
	
	// Set up the proper palette data
	if (hostObject.playerID == 2)
	{
		PaletteSetup(global.p2PaletteID, selectedCharacter);
	}
	else
	{
		PaletteSetup(global.p1PaletteID, selectedCharacter);
	}

}


depth = hostObject.depth + 2;

// Handle Traction
if (hostObject.grounded && !isPerformingThrow)
{
	HandleTraction();
}

heldOpponent = hostObject.heldOpponent;

#region Handle Pushback + knockback
if (hostObject.state != eState.HITSTOP) 
{
	ProcessPushback();
}
if ((hostObject.state == eState.HURT || hostObject.state == eState.BLOCKING) && !nextToPlayer)
{
	ProcessKnockback();
}
#endregion

switch (spiritState)
{
	// while deactivated, hide this object off screen
	case eSpiritState.DEACTIVATED:
	{
		x = hostObject.x;
		y = hostObject.y + 10000;
		environmentDisplacement = 0;
		image_xscale = hostObject.image_xscale;
		isPerformingThrow = false;
		hasRecentlyRushCanceled = false;
		
		xHome = x;
		yHome = y;
		
		shouldCreateSpiritFire = true;
		nextToPlayer = true;
		
		// Set hurtbox width and height
		hurtbox.image_xscale = 0;
		hurtbox.image_yscale = 0;
	}
	break;
	
	// The spirit is currently active
	case eSpiritState.ACTIVE:
	{
		isPerformingThrow = false;
		
		if (nextToPlayer && hostObject.state != eState.HITSTOP)
		{
			x = lerp(x, hostObject.x + (spiritOffsetDistance * hostObject.image_xscale), 0.5);
			x += environmentDisplacement;
			
			environmentDisplacement = 0;
			
			y = hostObject.y;
			
			knockbackVel = 0;
			knockbackVelTimer = 0;
			pushbackVel = 0;
			pushbackVelTimer = 0;
			
			xHome = x;
			yHome = y;
		}
		else if (hostObject.state != eState.HITSTOP)
		{
			#region Handle moving when the host's movement is blocked in some way
			
			if (hostObject.state == eState.WALKING) // Handle moving the spirit when the host is walking up against a wall
			{
				if (place_meeting(hostObject.x + hostObject.movedir, hostObject.y, oWall) || hostObject.x + hostObject.movedir < global.camObj.x - (80 - hostObject.cameraBufferAmount) || hostObject.x + hostObject.movedir > global.camObj.x + (80 - hostObject.cameraBufferAmount))
				{
					remoteOffset += walkSpeed * hostObject.movedir;
				}
			}
			else if (hostObject.state == eState.JUMPING) // Handle if they are jumping
			{
				if (place_meeting(hostObject.x + sign(hostObject.jumpHsp), hostObject.y, oWall) || hostObject.x + sign(hostObject.jumpHsp) < global.camObj.x - (80 - hostObject.cameraBufferAmount) || hostObject.x + sign(hostObject.jumpHsp) > global.camObj.x + (80 - hostObject.cameraBufferAmount))
				{
					remoteOffset += hostObject.jumpHsp;
				}
			}
			else if (hostObject.state == eState.RUN_BACKWARD) // Handle if the host is backdashing into a wall
			{
				// If the host moves into a wall, transfer the hsp to the remote offset
				if (place_meeting(hostObject.x + (-sign(hostObject.image_xscale)), hostObject.y, oWall) || hostObject.x + (-sign(hostObject.image_xscale)) < global.camObj.x - (80 - hostObject.cameraBufferAmount) || hostObject.x + (-sign(hostObject.image_xscale)) > global.camObj.x + (80 - hostObject.cameraBufferAmount))
				{
					// If the host is supposed to backdash, then set our hsp to the backdash speed.
					if (hostObject.animTimer == hostObject.backdashStartup)
					{
						hsp = hostObject.backdashSpeed * -sign(hostObject.image_xscale);
					}
				}
			}
			else if (hostObject.state == eState.RUN_FORWARD) // Handle if the host is forward dashing into a wall
			{
				// If the host moves into a wall, transfer the hsp to the remote offset
				if (place_meeting(hostObject.x + sign(hostObject.image_xscale), hostObject.y, oWall) || hostObject.x + (sign(hostObject.image_xscale)) < global.camObj.x - (80 - hostObject.cameraBufferAmount) || hostObject.x + (sign(hostObject.image_xscale)) > global.camObj.x + (80 - hostObject.cameraBufferAmount))
				{
					// If the host is supposed to dash, then set our hsp to the dash speed.
					if (hostObject.animTimer == 5)
					{
						hsp = 5 * sign(hostObject.image_xscale);
					}
				}
			}
			else if (hostObject.state == eState.RUSH_CANCEL_FORWARD || hostObject.state == eState.RUSH_CANCEL_AIR || hostObject.state == eState.RUSH_CANCEL_UP) // Handle Rush Canceling
			{
				hasRecentlyRushCanceled = true;
				
				if (image_xscale != hostObject.image_xscale)
				{
					hsp = abs(hostObject.hsp) * image_xscale * 2;
				}
			}
			else if (!hostObject.inAttackState)
			{
				hasRecentlyRushCanceled = false;
			}
			
			#endregion
			
			remoteOffset += hsp + environmentDisplacement;
			
			x = lerp(x, hostObject.x + remoteOffset, 0.5);
			x += hsp + environmentDisplacement;
			
			environmentDisplacement = 0;
			
			y = hostObject.y;
			
			xHome = x;
			yHome = y;
		}
		
		// Set the direction this spirit is looking
		if (nextToPlayer)
		{
			image_xscale = hostObject.image_xscale;
		}
		else
		{
			if (hostObject.opponent != noone)
			{
				if (x < hostObject.opponent.x)
				{
					image_xscale = 1;
				}
				else if (x != hostObject.opponent.x)
				{
					image_xscale = -1;
				}
			}
			else
			{
				image_xscale = hostObject.image_xscale;
			}
		}
		
		sprite_index = CharacterSprites.idle_Sprite;
		
		// Set hurtbox width and height
		hurtbox.image_xscale = 16;
		hurtbox.image_yscale = 43;
		
		if (shouldCreateSpiritFire)
		{
			createSpiritFire();
			shouldCreateSpiritFire = false;
		}
		
		// If we are too close to our host, exit remote mode
		if (!nextToPlayer && x < (hostObject.x + remoteModeThreshold) && x > (hostObject.x - remoteModeThreshold))
		{
			nextToPlayer = true;
		}
		
		#region Set the sprite for each state (specifically hurt states)
		if (hostObject.prevState == eState.CROUCHING)
		{
			sprite_index = CharacterSprites.crouch_Sprite;
			// Set hurtbox width and height
			hurtbox.image_xscale = 16;
			hurtbox.image_yscale = 28;
		}
		else if (hostObject.prevState == eState.HURT)
		{
			// Extra check to see if we're using the launched sprite in this state
			if (hostObject.sprite_index == hostObject.CharacterSprites.launched_Sprite)
			{
				sprite_index = CharacterSprites.launched_Sprite;
				image_index = hostObject.image_index;
			}
			else
			{
				sprite_index = CharacterSprites.hurt_Sprite;
			}
		}
		else if (hostObject.prevState == eState.LAUNCHED)
		{
			sprite_index = CharacterSprites.launched_Sprite;
			image_index = hostObject.image_index;
		}
		else if (hostObject.prevState == eState.KNOCKED_DOWN)
		{
			sprite_index = CharacterSprites.knockdown_Sprite;
			image_index = hostObject.image_index;
		}
		else if (hostObject.prevState == eState.GETUP)
		{
			sprite_index = CharacterSprites.getup_Sprite;
			image_index = hostObject.image_index;
		}
		else if (hostObject.prevState == eState.QUICK_GETUP)
		{
			sprite_index = sRussel_QuickGetup;
			image_index = hostObject.image_index;
		}
		else if (hostObject.prevState == eState.TECH_ROLL)
		{
			sprite_index = sRussel_TechRoll;
			image_index = hostObject.image_index;
		}
		else if (hostObject.prevState == eState.THROW_TECH)
		{
			sprite_index = sRussel_Grab;
			image_index = hostObject.image_index;
		}
		#endregion
		
	}
	break;
	
	// Spirit attack
	case eSpiritState.ATTACK:
	{
		// Make the spirit appear in front
		depth = -2;
		
		// Freeze when in hitstop or screen freeze
		if (hostObject.state != eState.HITSTOP && hostObject.state != eState.SCREEN_FREEZE)
		{
			// Special exception for Jay's Spirit OFF Down Special
			if (hostObject.prevState == eState.DOWN_SPECIAL && inSpiritOff)
			{
				y = 104;
			}
			else if (hostObject.prevState == eState.ENHANCED_DOWN_SPECIAL)
			{	
				y += vsp;
				if (animTimer <= 2) y = 104;
				
				x += hsp + environmentDisplacement;
			}
			else
			{
				y = hostObject.y;
				x += hsp + environmentDisplacement;
			}
			
			
			environmentDisplacement = 0;
			
			xHome = x;
			yHome = y;
		}
		
		// Handle Remote Mode
		if (!nextToPlayer)
		{
			remoteOffset = x - hostObject.x;
		}
		
		// Handle moving while doing a throw
		if (isPerformingThrow)
		{
			if (!nextToPlayer && x < (hostObject.x + remoteModeThreshold) && x > (hostObject.x - remoteModeThreshold))
			{
				nextToPlayer = true;
			}
			else if (nextToPlayer)
			{
				hostObject.hsp = hsp;
			}
		}
		
		// If the host leaves the attack state, cancel
		if (!hostObject.inAttackState)
		{
			spiritState = eSpiritState.ACTIVE;
			inAttackState = false;
			//hasRecentlyRushCanceled = false;
		}
		
		// If a spirit Fire is buffered, create one
		if (shouldCreateSpiritFire)
		{
			createSpiritFire();
			shouldCreateSpiritFire = false;
		}
	}
	break;
	
	// Hold (grabs)
	case eSpiritState.HOLD:
	{
		// TEMPORARY!!!!
		sprite_index = sJay_SC_StandLight_MOCKUP_strip3;
		image_index = 1;
		// TEMPORARY!!!!
		
		hasRecentlyRushCanceled = false;
		
		// Transition to a throw
		if (hostObject.animTimer > 4)
		{
			if (hostObject.movedir != -image_xscale)
			{
				hostObject.state = eState.FORWARD_THROW;
				hostObject.animTimer = 0;
				animTimer = 0;
				
				spiritState = eSpiritState.ATTACK;
				sprite_index = selectedCharacter.ForwardThrow.SpriteId;
				isPerformingThrow = true;
				
				with (hostObject)
				{
					ClearVictimHitByGroups();
				}
				
				// Handle moving the player away from the wall
				var ThrowDistance = instance_create_layer(x, y-15, "hitboxes", oThrowEnvDetection);
				with (ThrowDistance)
				{
					owner = other.id;
					image_xscale = other.selectedCharacter.ForwardThrow.OpponentPositionData.DistanceFromWall * other.image_xscale;
					throwToCheck = other.selectedCharacter.ForwardThrow;
				}
			} 
			else 
			{
				hostObject.state = eState.BACKWARD_THROW;
				hostObject.animTimer = 0;
				animTimer = 0;
				
				spiritState = eSpiritState.ATTACK;
				sprite_index = selectedCharacter.BackwardThrow.SpriteId;
				isPerformingThrow = true;
				
				with (hostObject)
				{
					ClearVictimHitByGroups();
				}
			
				// Handle moving the player away from the wall
				var ThrowDistance = instance_create_layer(x, y-15, "hitboxes", oThrowEnvDetection);
				with (ThrowDistance) 
				{
					owner = other.id;
					image_xscale = other.selectedCharacter.BackwardThrow.OpponentPositionData.DistanceFromWall * other.image_xscale;
					throwToCheck = other.selectedCharacter.BackwardThrow;
				}
			}
		}
	}
	break;
}

#region Spirit Break
if (hostObject.spiritCurrentHealth <= 0)
{
	hostObject.spiritBroken = true;
	hostObject.hitstop = 60;
	hostObject.state = eState.LAUNCHED;
	hostObject.prevState = eState.HURT;
	hostObject.hitstun = 10;
	hostObject.sprite_index = hostObject.CharacterSprites.hurt_Sprite;
	hostObject.image_index = 0;
	hostObject.grounded = false;
	hostObject.vsp = -4; // Launches the player up
	hostObject.hsp = 0;
	hostObject.canBlock = false;

	DeactivateSpirit(true);
}
#endregion

#region Handle getting Hit while in spirit OFF
if (hostObject.hitstun > 0 && spiritState != eSpiritState.DEACTIVATED && inSpiritOff)
{
	DeactivateSpirit(true);
}

#endregion

#region Handle Player Collisions
// Collision
// When a player gets hit, they ossilate back and forth, which will move the player's collision box around.
// We're storing the actual x Position so we can restore it later.
// We need a consistent X position to do accurate collision calculations, so we'll use xHome, which is the
// player's position without ossilating.
var actualXPos = x;
var actualYPos = y;
x = xHome;
y = yHome;

// Collisions With Players
if (hostObject.opponent != noone)
{
	// Check to see if players are about to be touching
	if (place_meeting(x+hsp+environmentDisplacement, y, hostObject.opponent) && hostObject.state != eState.BEING_GRABBED && hostObject.opponent.state != eState.BEING_GRABBED && hostObject.state != eState.TECH_ROLL && hostObject.opponent.state != eState.TECH_ROLL && hostObject.prevState != eState.DOWN_SPECIAL) // && opponent.state != eState.BEING_GRABBED && ((grounded && opponent.grounded) || ((((opponent.state = eState.HURT || opponent.state = eState.BLOCKING) && !opponent.grounded) || opponent.state = eState.LAUNCHED) || (((state = eState.HURT || opponent.state = eState.BLOCKING) && !grounded) || state = eState.LAUNCHED))))
	{
		if (hostObject.state != eState.HITSTOP)
		{
			hsp *= .75; // Reduce player speed
		}
		var origanalX = hostObject.opponent.x; // Keep track of the opponent's x position before calculations
		// Simulate the opponent moving forwards
		if (hostObject.opponent.state != eState.HITSTOP) 
		{
			hostObject.opponent.x += (hostObject.opponent.hsp*.75) + hostObject.opponent.environmentDisplacement;
		}
		
		// While the players are still touching
		var boundingBoxSize = round(abs(bbox_left - bbox_right));
			
		environmentDisplacement += (boundingBoxSize - abs((x+hsp+environmentDisplacement) - hostObject.opponent.x)) * 0.5 * -sign(image_xscale);
		
		if (nextToPlayer)
		{
			hostObject.environmentDisplacement += environmentDisplacement;
		}
		
		hostObject.opponent.environmentDisplacement = -environmentDisplacement; // give opponent their environment displacement
		hostObject.opponent.x = origanalX; // Return oponent to original position
	}
}

x = actualXPos; // Restore the player's actual x position
y = actualYPos; // Restore the player's actual y position

// Handle going off screen
if (!nextToPlayer || hostObject.prevState == eState.DOWN_SPECIAL || hostObject.prevState == eState.ENHANCED_DOWN_SPECIAL)
{
	if (x < global.camObj.x-72 || x > global.camObj.x+72)
	{
		// Clamp to the screen (with some buffer room)
		x = clamp(x, global.camObj.x-72, global.camObj.x+72);
		
		remoteOffset = (x - hostObject.x);
	}
}

#endregion
