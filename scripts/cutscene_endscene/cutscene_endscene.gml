/// Ends the current scene and goes onto the next one
function Cutscene_ENDSCENE()
{
	sceneID += 1;
	
	if (sceneID > (array_length(sceneInfo) - 1))
	{
		instance_destroy();
	}
}