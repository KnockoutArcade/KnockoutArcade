// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function SetMotionInputs(motionInputs, numberOfMotions)
{
	if (!inputSet) 
	{
		for (var i = 0; i < numberOfMotions; i++) 
		{
			// Turns the motion input into separate numbers in an array
			motionInputs[i] = string(motionInputs[i]);
			var n = string_length(motionInputs[i]);
			directions = [];
			for(var j = 0, directions; j < n; j++)
			{
				// Failsafe to prevent crashing
				try
				{
					directions[j] = real(string_char_at(motionInputs[i], j+1));
				}
				catch(e) {}
			}
			
			// Shorten inputs for input leniency
			lenient = false;
			while (!lenient) 
			{
				var tempIndex = 0;
				var tempSameIndex = 0;
				
				// Uses for loop to check all input directions. Removes them afterward to prevent errors
				for (var k = 0; k < array_length(directions); k++)
				{
					// Remove down and up directions that are in the middle of the input
					if (k != 0 && k != 1 && k != array_length(directions) - 1)
					{
						if (directions[k] == 2 || directions[k] == 8)
						{
							tempIndex = k;
							break;
						}
					}
					
					// Add neutral input between two directions that are the same
					if (k != 0 && directions[k] == directions[k-1])
					{
						tempSameIndex = k;
					}
				}
				
				// Check if an input needs to be deleted or not. If not, the input is lenient
				if (tempIndex != 0) 
				{
					array_delete(directions, tempIndex, 1);
				}
				
				if (tempSameIndex != 0)
				{
					for (var i = array_length(directions) - 1; i >= tempSameIndex; i--)
					{
						directions[i+1] = directions[i];
					}
					directions[tempSameIndex] = 5;
				}
				
				if (tempIndex == 0 && tempSameIndex == 0)
				{
					lenient = true;
				}
			}
			
			
			for (var k = 0; k < array_length(directions); k++)
			{
				show_debug_message(directions[k]);
			}
			
			enhanced[i] = false;
			progressInInputs[i] = -1;
			ds_list_add(listOfInputs, directions);
		}
		
		inputSet = true;
	}
}