// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetPlayerButtons() 
{
	global.player1Controls = 
	{
		Keyboard : 
		{
			buttonLeft : ord("A"),
			buttonRight : ord("D"),
			buttonUp : ord("W"),
			buttonDown : ord("S"),
			buttonLight : ord("J"),
			buttonMedium : ord("K"),
			buttonHeavy : ord("L"),
			buttonGrab : vk_space,
			buttonSpecial : 186,    // Keyboard code value for ";"
			buttonSuper : ord("M"),
			buttonRun : vk_lshift
		},
		
		Controller : 
		{
			buttonLeft : gp_axislh,
			buttonRight : gp_axislh,
			buttonUp : gp_axislv,
			buttonDown : gp_axislv,
			buttonLight : gp_face3,
			buttonMedium : gp_face4,
			buttonHeavy : gp_face2,
			buttonGrab : gp_shoulderr,
			buttonSpecial : gp_face1,
			buttonSuper : gp_shoulderl,
			buttonRun : gp_shoulderrb,
		}
	};
	
	global.player2Controls = {
		Keyboard : 
		{
			buttonLeft : vk_left,
			buttonRight : vk_right,
			buttonUp : vk_up,
			buttonDown : vk_down,
			buttonLight : vk_numpad1,
			buttonMedium : vk_numpad2,
			buttonHeavy : vk_numpad3,
			buttonGrab : vk_numpad4,
			buttonSpecial : vk_numpad0,
			buttonSuper : vk_numpad5,
			buttonRun : 110, // Keyboard code value for numpad "."
		},
		Controller : 
		{
			buttonLeft : gp_axislh,
			buttonRight : gp_axislh,
			buttonUp : gp_axislv,
			buttonDown : gp_axislv,
			buttonLight : gp_face3,
			buttonMedium : gp_face4,
			buttonHeavy : gp_face2,
			buttonGrab : gp_shoulderr,
			buttonSpecial : gp_face1,
			buttonSuper : gp_shoulderl,
			buttonRun : gp_shoulderrb,
		}
	};
}