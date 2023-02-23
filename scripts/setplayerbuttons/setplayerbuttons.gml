// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetPlayerButtons() {
	if (global.player1ControllerType == "KEYBOARD") 
	{
		global.player1Controls = {
			buttonLeft : ord("A"),
			buttonRight : ord("D"),
			buttonUp : ord("W"),
			buttonDown : ord("S"),
			buttonLight : ord("J"),
			buttonMedium : ord("K"),
			buttonHeavy : ord("L"),
			buttonGrab : vk_space,
			buttonSpecial : 186,    // UTF Code for ;
			buttonSuper : vk_rcontrol,
			buttonRun : vk_lshift,
		};
	} 
	else 
	{
		global.player1Controls = {
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
		};
	}
	
	if (global.player2ControllerType == "KEYBOARD")
	{
		global.player2Controls = {
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
			buttonRun : ord("."),
		};
	} 
	else 
	{
		global.player2Controls = {
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
		};
	}
}