// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Each character may have a command grab that requires unique code to execute.
function ProccessCommandGrab(){
	
	// Russel's Up Special Command Grab
	if (selectedCharacter == global.stRusselMoves)
	{
		// Detect if we have hit the ground. We're using the late part of the move as the activation hitbox.
		if (grounded && animTimer < 99)
		{
			animTimer = 99;
		}
	}
}