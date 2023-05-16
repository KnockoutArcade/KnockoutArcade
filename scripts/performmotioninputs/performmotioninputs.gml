// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Allows player to perform motion inputs during special moves
function PerformMotionInputs()
{
	if (inputSet)
	{
		var inputDirection = 5; // Neutral
		// Set input directions
		if (movedir == -image_xscale && verticalMoveDir == -1)
		{
			inputDirection = 1; // Down-back
			show_debug_message("Down-back");
		}
		else if (movedir == 0 && verticalMoveDir == -1)
		{
			inputDirection = 2; // Down
			show_debug_message("Down");
		}
		else if (movedir == image_xscale && verticalMoveDir == -1)
		{
			inputDirection = 3; // Down-forward
			show_debug_message("Down-forward");
		}
		else if (movedir == -image_xscale && verticalMoveDir == 0)
		{
			inputDirection = 4; // Back
			show_debug_message("Back");
		}
		else if (movedir == 0 && verticalMoveDir == 0)
		{
			inputDirection = 5; // Neutral
			show_debug_message("Neutral");
		}
		else if (movedir == image_xscale && verticalMoveDir == 0)
		{
			inputDirection = 5; // Forward
			show_debug_message("Forward");
		}
		else if (movedir == -image_xscale && verticalMoveDir == 1)
		{
			inputDirection = 7; // Up-back
			show_debug_message("Up-back");
		}
		else if (movedir == 0 && verticalMoveDir == 1)
		{
			inputDirection = 8; // Up
			show_debug_message("Up");
		}
		else if (movedir == image_xscale && verticalMoveDir == 1)
		{
			inputDirection = 9; // Up-forward
			show_debug_message("Up-forward");
		}
	}
	
}