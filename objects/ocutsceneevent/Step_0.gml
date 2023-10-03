/// @description Insert description here
// You can write your code in this editor

// Get the current scene we're performing
var currentScene = sceneInfo[sceneID];

// Get the length of the current scene ID to determine how many arguments to pass
var sceneIDLength = array_length(currentScene) - 1;

// Execute commands from the scene info
switch (sceneIDLength)
{
	case 0:
	{
		script_execute(currentScene[0]);
	}
	break;
	
	case 1:
	{
		script_execute(currentScene[0], currentScene[1]);
	}
	break;
	
	case 2:
	{
		script_execute(currentScene[0], currentScene[1], currentScene[2]);
	}
	break;
	
	case 3:
	{
		script_execute(currentScene[0], currentScene[1], currentScene[2], currentScene[3]);
	}
	break;
}