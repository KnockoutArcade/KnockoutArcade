// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// This script will take an inputted gamepad button code and convert it into the correct image_index
// for sButtons_Controller

function ConvertButtonIntoImageIndex( keyCode)
{
	switch (keyCode)
	{
		// Face Buttons
		case gp_face1:
			return 0;
			
		case gp_face2:
			return 1;
			
		case gp_face3:
			return 2;
			
		case gp_face4:
			return 3;
			
		// Shoulder Buttons
		case gp_shoulderrb:
			return 4;
			
		case gp_shoulderlb:
			return 5;
			
		case gp_shoulderr:
			return 6;
			
		case gp_shoulderl:
			return 7;
			
		// Dpad Inputs
		case gp_padr:
			return 8;
			
		case gp_padd:
			return 9;
			
		case gp_padl:
			return 10;
			
		case gp_padu:
			return 11;
			
		// Stick inputs
		case gp_axislh:
		case gp_axislv:
			return 12;
			
		case gp_axisrh:
		case gp_axisrv:
			return 13;
			
		// Start and Select
		case gp_start:
			return 18;
			
		case gp_select:
			return 19;
			
		// failsafe
		default:
			return 14;
	}
}