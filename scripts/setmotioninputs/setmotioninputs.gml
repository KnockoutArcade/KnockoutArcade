// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


function SetMotionInputs(motionInput, numberInput)
{
	if (!inputSet) 
	{
		// Turns the motion input into separate numbers in an array
		motionInput = string(motionInput);
		var n = string_length(motionInput);
		for(var i = 0; i < n; i++)
		{
			// Failsafe to prevent crashing
			try
			{
				inputDirections[numberInput][i] = real(string_char_at(motionInput, i+1));
				show_debug_message(inputDirections[numberInput][i]);
			}
			catch(e) {}
		}
		
		inputSet = true;
	}
}