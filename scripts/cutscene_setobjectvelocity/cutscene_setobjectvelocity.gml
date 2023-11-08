/// This script allows you to set the velocity for a specific object in a cutscene
function Cutscene_SetObjectVelocity(objectID, horizontalVelocity, verticalVelocity)
{
	objectID.hsp = horizontalVelocity;
	objectID.jumpHsp = horizontalVelocity;
	objectID.vsp = verticalVelocity;
	
	Cutscene_ENDSCENE();
}