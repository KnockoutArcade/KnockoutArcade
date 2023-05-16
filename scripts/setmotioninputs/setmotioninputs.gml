// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function SetMotionInputs(motionInputs, numberOfInputs)
{
	if (!inputSet) 
	{
		for (var i = 0; i < numberOfInputs; i++) 
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
					show_debug_message(directions[j]);
				}
				catch(e) {}
			}
			ds_list_add(listOfInputs, directions);
		}
		
		inputSet = true;
	}
}