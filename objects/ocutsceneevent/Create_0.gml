/// @description Insert description here
// You can write your code in this editor

sceneInfo = -1; // Cutscene data
/*
To format a cutscene, sceneInfo contains a 2D array full of script IDs and their arguments
Each entry in the first dimention is what we want the cutscene to do.
	Ex:
	[
		[stop camera],
		[move player, 20, 10],
		[wait, 5],
		[end scene]
	]
	This cutscene will stop the cam, then move the player, then wait, then end the scene in that order
	
Each entry in the second dimention is an argument for the script in that slot.

*/

sceneID = 0; // The index for which script we are executing in the cutscene

waitTimer = 0; // Timer for the wait command
cameraTimer = 0; // Timer for the camera commands
cameraTravelDistanceX = 0; // How much the camera must travel on the x axis
cameraTravelDistanceY = 0; // How much the camera msut travel on the y axis

activateByPlayer = true; // Whether this cutscene should activate if a player touches the trigger
isActivated = false; // Whether this cutscene has been activated

isIntroCutscene = false; // Whether this cutscene is an intro cutscene