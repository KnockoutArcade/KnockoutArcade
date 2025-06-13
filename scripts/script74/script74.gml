// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ResetEnhancer()
{
	inputSet = false;
	motionInput = [];
	ds_list_clear(listOfInputs);
	progressInInputs = [];
	enhanced = [];
	inputWindowStart = [];
	inputWindowEnd = [];
	changeFrame = 999;
	changeImmediately = false;
	requireSpecialButton = false;
	requiredPosition = [];
	
	show_debug_message("Enhancers Reset");
}