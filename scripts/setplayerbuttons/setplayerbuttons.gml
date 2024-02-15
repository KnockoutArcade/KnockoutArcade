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
			buttonRun : vk_lshift,
			
			// Menu Controls - These will never be changed
			buttonMenuLeft : ord("A"),
			buttonMenuRight : ord("D"),
			buttonMenuUp : ord("W"),
			buttonMenuDown : ord("S"),
			buttonMenuConfirm : ord("J"),
			buttonMenuDeny : ord("K"),
			buttonMenuSwitch : ord("L"),
			buttonMenuSetControls : 186,
			buttonMenuPause : vk_escape
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
			
			// Menu Controls - These will never be changed
			buttonMenuLeft : gp_axislh,
			buttonMenuRight : gp_axislh,
			buttonMenuUp : gp_axislv,
			buttonMenuDown : gp_axislv,
			buttonMenuLeftDPAD : gp_padl,
			buttonMenuRightDPAD : gp_padr,
			buttonMenuUpDPAD : gp_padu,
			buttonMenuDownDPAD : gp_padd,
			buttonMenuConfirm : gp_face1,
			buttonMenuDeny : gp_face2,
			buttonMenuSwitch : gp_face3,
			buttonMenuSetControls : gp_face4,
			buttonMenuPause : gp_start
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
			
			// Menu Controls - These will never be changed
			buttonMenuLeft : vk_left,
			buttonMenuRight : vk_right,
			buttonMenuUp : vk_up,
			buttonMenuDown : vk_down,
			buttonMenuConfirm : vk_numpad1,
			buttonMenuDeny : vk_numpad2,
			buttonMenuSwitch : vk_numpad3,
			buttonMenuSetControls : vk_numpad4,
			buttonMenuPause : vk_backspace
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
			
			// Menu Controls - These will never be changed
			buttonMenuLeft : gp_axislh,
			buttonMenuRight : gp_axislh,
			buttonMenuUp : gp_axislv,
			buttonMenuDown : gp_axislv,
			buttonMenuLeftDPAD : gp_padl,
			buttonMenuRightDPAD : gp_padr,
			buttonMenuUpDPAD : gp_padu,
			buttonMenuDownDPAD : gp_padd,
			buttonMenuConfirm : gp_face1,
			buttonMenuDeny : gp_face2,
			buttonMenuSwitch : gp_face3,
			buttonMenuSetControls : gp_face4,
			buttonMenuPause : gp_start
		}
	};
}

// restore the default controls for player 1
function RestorePlayer1DefaultControls()
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
			buttonRun : vk_lshift,
			
			// Menu Controls - These will never be changed
			buttonMenuLeft : ord("A"),
			buttonMenuRight : ord("D"),
			buttonMenuUp : ord("W"),
			buttonMenuDown : ord("S"),
			buttonMenuConfirm : ord("J"),
			buttonMenuDeny : ord("K"),
			buttonMenuSwitch : ord("L"),
			buttonMenuSetControls : 186,
			buttonMenuPause : vk_escape
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
			
			// Menu Controls - These will never be changed
			buttonMenuLeft : gp_axislh,
			buttonMenuRight : gp_axislh,
			buttonMenuUp : gp_axislv,
			buttonMenuDown : gp_axislv,
			buttonMenuLeftDPAD : gp_padl,
			buttonMenuRightDPAD : gp_padr,
			buttonMenuUpDPAD : gp_padu,
			buttonMenuDownDPAD : gp_padd,
			buttonMenuConfirm : gp_face1,
			buttonMenuDeny : gp_face2,
			buttonMenuSwitch : gp_face3,
			buttonMenuSetControls : gp_face4,
			buttonMenuPause : gp_start
		}
	};
}

// restore the default controls for player 2
function RestorePlayer2DefaultControls()
{
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
			
			// Menu Controls - These will never be changed
			buttonMenuLeft : vk_left,
			buttonMenuRight : vk_right,
			buttonMenuUp : vk_up,
			buttonMenuDown : vk_down,
			buttonMenuConfirm : vk_numpad1,
			buttonMenuDeny : vk_numpad2,
			buttonMenuSwitch : vk_numpad3,
			buttonMenuSetControls : vk_numpad4,
			buttonMenuPause : vk_backspace
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
			
			// Menu Controls - These will never be changed
			buttonMenuLeft : gp_axislh,
			buttonMenuRight : gp_axislh,
			buttonMenuUp : gp_axislv,
			buttonMenuDown : gp_axislv,
			buttonMenuLeftDPAD : gp_padl,
			buttonMenuRightDPAD : gp_padr,
			buttonMenuUpDPAD : gp_padu,
			buttonMenuDownDPAD : gp_padd,
			buttonMenuConfirm : gp_face1,
			buttonMenuDeny : gp_face2,
			buttonMenuSwitch : gp_face3,
			buttonMenuSetControls : gp_face4,
			buttonMenuPause : gp_start
		}
	};
}