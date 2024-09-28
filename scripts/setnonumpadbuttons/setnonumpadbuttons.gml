// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetNoNumpadButtons()
{
	global.player2Controls = {
		Keyboard : 
		{
			buttonLeft : vk_left,
			buttonRight : vk_right,
			buttonUp : vk_up,
			buttonDown : vk_down,
			buttonLight : ord("1"),
			buttonMedium : ord("2"),
			buttonHeavy : ord("3"),
			buttonGrab : ord("5"),
			buttonSpecial : ord("4"),
			buttonSuper : ord("6"),
			buttonRun : ord("Q"),
			
			// Menu Controls - These will never be changed
			buttonMenuLeft : vk_left,
			buttonMenuRight : vk_right,
			buttonMenuUp : vk_up,
			buttonMenuDown : vk_down,
			
			buttonMenuConfirm : ord("1"),
			buttonMenuDeny : ord("2"),
			buttonMenuSwitch : ord("3"),
			buttonMenuSetControls : ord("4"),
			
			buttonMenuPageRight : vk_right,
			buttonMenuPageLeft : vk_left,
			buttonMenuTriggerRight : vk_pageup,
			buttonMenuTriggerLeft : vk_pagedown,
			
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
			
			buttonMenuPageRight : gp_shoulderr,
			buttonMenuPageLeft : gp_shoulderl,
			buttonMenuTriggerRight : gp_shoulderrb,
			buttonMenuTriggerLeft : gp_shoulderlb,
			
			buttonMenuPause : gp_start
		}
	};
}