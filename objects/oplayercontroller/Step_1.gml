/// @description Insert description here
// You can write your code in this editor

if (global.game_paused)
{
	exit;
}


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
