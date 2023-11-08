/// This script is responsible for hiding or showing a particular object
function Cutscene_HideObject(objectID, shouldHide)
{
	if (shouldHide)
	{
		objectID.visible = false;
	}
	else
	{
		objectID.visible = true;
	}
	
	Cutscene_ENDSCENE();
}