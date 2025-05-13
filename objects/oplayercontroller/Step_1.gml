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