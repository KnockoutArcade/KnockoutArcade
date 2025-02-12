/// @description Insert description here
// You can write your code in this editor

with (other)
{
	x = other.respawnX;
	y = other.respawnY;
	
	jumpHsp = 0;
	hsp = 0;
	vsp = 0;
	
	state = eState.LAUNCHED;
	image_index = 0;
	
	hp -= other.respawnDamage;
	
	hasFallenDownPit = true;
}

// Don't move the camera if we didn't respawn the player
if (other.playerID < 1)
{
	exit;
}

with (global.camObj)
{
	xCameraDestination = other.respawnCameraX;
	yCameraDestination = other.respawnCameraY;
	
	isRespawnCamera = true;
}

