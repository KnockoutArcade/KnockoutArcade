/// This function allows you to change the current action state of an object
function Cutscene_SetPlayerState(objectID, stateToSet)
{
	objectID.state = stateToSet;
	
	Cutscene_ENDSCENE();
}