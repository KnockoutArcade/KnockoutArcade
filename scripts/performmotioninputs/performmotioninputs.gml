// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Allows player to perform motion inputs during special moves
function PerformMotionInputs(attack)
{
	if (inputSet)
	{
		var inputPerformed = false;
		
		var inputDirection = 5; // Neutral; Default
		// Set input directions
		if (movedir == -image_xscale && verticalMoveDir == -1)
		{
			inputDirection = 1; // Down-back
		}
		else if (movedir == 0 && verticalMoveDir == -1)
		{
			inputDirection = 2; // Down
		}
		else if (movedir == image_xscale && verticalMoveDir == -1)
		{
			inputDirection = 3; // Down-forward
		}
		else if (movedir == -image_xscale && verticalMoveDir == 0)
		{
			inputDirection = 4; // Back
		}
		else if (movedir == 0 && verticalMoveDir == 0)
		{
			inputDirection = 5; // Neutral
		}
		else if (movedir == image_xscale && verticalMoveDir == 0)
		{
			inputDirection = 6; // Forward
		}
		else if (movedir == -image_xscale && verticalMoveDir == 1)
		{
			inputDirection = 7; // Up-back
		}
		else if (movedir == 0 && verticalMoveDir == 1)
		{
			inputDirection = 8; // Up
		}
		else if (movedir == image_xscale && verticalMoveDir == 1)
		{
			inputDirection = 9; // Up-forward
		}
		
		// Iterates through each motion input for the special move
		for (var i = 0; i < ds_list_size(listOfInputs); i++)
		{
			var currentMotionInput = ds_list_find_value(listOfInputs, i);
			// Iterates through each direction in motion input
			for (var j = 0; j < array_length(currentMotionInput); j++)
			{
				if (inputDirection == currentMotionInput[j] && progressInInputs[i] == j - 1)
				{
					progressInInputs[i] = j;
				}
			}
		}
		
		// Check if any move is already being enhanced
		for (var i = 0; i < array_length(enhanced); i++)
		{
			if (enhanced[i])
			{
				inputPerformed = true;
				isEXFlash = true;
			}
		}
		
		// If not, check if any enhancements have been inputted
		if (!inputPerformed)
		{
			// Variables used for input priority
			var longerInput = -1;
			var longerIndex = -1;
			
			for (var i = 0; i < array_length(progressInInputs); i++)
			{
				var currentMotionInput = ds_list_find_value(listOfInputs, i);
				if (progressInInputs[i] == array_length(currentMotionInput) - 1 && !inputPerformed)
				{
					// Reset the input if it is performed outside of the input window
					if (animTimer < inputWindowStart || animTimer > inputWindowEnd)
					{
						progressInInputs[i] = -1;
					}
					// Checks for the longer input
					else if (longerInput < array_length(currentMotionInput) - 1)
					{
						longerInput = array_length(currentMotionInput) - 1;
						longerIndex = i;
					}
				}
			}
			
			// Enhances input
			if (longerIndex != -1) && ( (attack == 5 && requireSpecialButton) || (!requireSpecialButton) ) && (superMeter >= 25)
			{
				var currentMotionInput = ds_list_find_value(listOfInputs, longerIndex);
				var inputString = "";
				for (i = 0; i < array_length(currentMotionInput); i++)
				{
					inputString = inputString + string(currentMotionInput[i]);
				}
				
				enhanced[longerIndex] = true;
				superMeter -= 25;
				hasUsedMeter = true;
				if (changeImmediately)
				{
					changeFrame = animTimer;
				}
			}
			
		}
	}
	
}