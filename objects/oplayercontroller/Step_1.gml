/// @description Insert description here
// You can write your code in this editor

if (global.game_paused)
{
	exit;
}

// Handle colliding with camera zones
if (place_meeting(x, y, oCameraZone) && playerID == 1)
{
	// Get the ID of the camera zone we're touching
	with (instance_place(x, y, oCameraZone))
	{
		other.cameraZoneID = id;
	}
	
	// Pass that data to the global camera
	global.camObj.cameraBoundMinY = cameraZoneID.cameraBoundMinY;
	global.camObj.cameraBoundMaxY = cameraZoneID.cameraBoundMaxY;
}

// Handle colliding with room transitions
if (place_meeting(x, y, oLevelTransition) && playerID == 1 && state != eState.ROOM_TRANSITION)
{
	isInCutscene = true;
	invincible = true;
	
	// Get the ID of the room transition
	with (instance_place(x, y, oLevelTransition))
	{
		global.roomTransitionData.isActive = true;
		
		global.roomTransitionData.newX = newPositionX;
		global.roomTransitionData.newY = newPositionY;
		global.roomTransitionData.newCamX = newCamX;
		global.roomTransitionData.newCamY = newCamY;
		
		global.roomTransitionData.currentHealth = other.hp;
		global.roomTransitionData.currentSuperMeter = other.superMeter;
		global.roomTransitionData.currentAnimTimer = other.animTimer;
		
		
		// If this character has a spirit
		if (other.selectedCharacter.UniqueData.SpiritData == 1)
		{
			global.roomTransitionData.currentSpiritHealth = other.spiritCurrentHealth;
		}
		
		// Handle transition state
		if (preserveState)
		{
			global.roomTransitionData.newState = other.state;
		}
		else
		{
			global.roomTransitionData.newState = newState;
		}
		
		// Handle transition momentum
		if (preserveMomentum)
		{
			global.roomTransitionData.newHSP = other.hsp;
			global.roomTransitionData.newVSP = other.vsp;
			
			// Preserve our height going into the next room (ignore for vertical room transitions)
			if (applyVerticalOffset)
			{
				// Note: we are always assuming that 2 room transitions that link to each other
				// have the exact same y-scale, and that for horizontal transitions, the 
				// spawn point is always at the base of the transition object.
				
				// Take the relative difference between the player and the transition object and invert it
				var spawnPositionOffset = abs(bbox_top - bbox_bottom) - abs(other.y - y);
				
				global.roomTransitionData.newY = newPositionY - spawnPositionOffset;
				global.roomTransitionData.newGrounded = other.grounded;
				global.roomTransitionData.newJumpHSP = other.jumpHsp;
				
				// Note: When placing room transitions, be sure to extend them into the floor/ceiling
			}
		}
		else
		{
			global.roomTransitionData.newHSP = newHSP;
			global.roomTransitionData.newVSP = newVSP;
		}
		
		// Currently unimplemented
		global.roomTransitionData.spawnDelay = 0;
		global.roomTransitionData.currentMoney = 0;
		global.roomTransitionData.currentTime = 0;
		global.roomTransitionData.currentItem = 0;
		
		room_goto(newRoomID);
	}
	
	state = eState.ROOM_TRANSITION;
}

if (hitstun <= 0 && prevState == eState.HURT && state != eState.LAUNCHED && state != eState.HURT && state != eState.BEING_GRABBED && state != eState.SCREEN_FREEZE && state != eState.HITSTOP)
{
	cancelCombo = true;
}