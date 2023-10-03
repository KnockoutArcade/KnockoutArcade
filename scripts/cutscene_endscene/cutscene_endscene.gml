/// Ends the current scene and goes onto the next one
function Cutscene_ENDSCENE()
{
	sceneID += 1;
	
	if (sceneID > (array_length(sceneInfo) - 1))
	{
		instance_destroy();
		
		// If this cutscene is not an intro
		if (!isIntroCutscene)
		{
			// For all players, put them out of a cutscene state
			for (var i = 0; i < instance_number(oPlayerController); i++;)
			{
				var player = instance_find(oPlayerController, i);
			
				player.isInCutscene = false;
			}
		}
	}
}