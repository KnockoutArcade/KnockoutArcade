/// This script will teleport an object to any location, ignoring collision

function Cutscene_TeleportObject(objectID, destinationX, destinationY)
{
	objectID.x = destinationX;
	objectID.y = destinationY;
	
	Cutscene_ENDSCENE();
}