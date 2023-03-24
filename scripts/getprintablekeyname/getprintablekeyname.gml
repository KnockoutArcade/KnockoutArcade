// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetPrintableKeyName(keycode)
{
	switch (keycode)
	{
		// gamepad values
		case gp_face1:
			return "Joy 1";
		case gp_face2:
			return "Joy 2";
		case gp_face3:
			return "Joy 3";
		case gp_face4:
			return "Joy 4";
		case gp_shoulderl:
			return "L Shoulder";
		case gp_shoulderlb:
			return "L Trigger";
		case gp_shoulderr:
			return "R Shoulder";
		case gp_shoulderrb:
			return "R Trigger";
		case gp_select:
			return "Select";
		case gp_start:
			return "Start";
		case gp_stickl:
			return "L Stick";
		case gp_stickr:
			return "R Stick";
		case gp_padu:
			return "Joy Up";
		case gp_padd:
			return "Joy Down";
		case gp_padl:
			return "Joy Left";
		case gp_padr:
			return "Joy Right";
		case gp_axislh:
			return "L Stick Hor";
		case gp_axislv:
			return "L Stick Ver";
		case gp_axisrh:
			return "R Stick Hor";
		case gp_axisrv:
			return "R Stick Ver";
		
		case vk_add:
			return "+";
		case vk_backspace:
			return "Backspace";
		case vk_decimal:
			return ".";
		case vk_delete:
			return "Delete";
		case vk_divide:
			return "/";
		case vk_down:
			return "Down";
		case vk_end:
			return "End";
		case vk_enter:
			return "Enter";
		case vk_escape:
			return "Esc";
		case vk_f1:
			return "F1";
		case vk_f2:
			return "F2";
		case vk_f3:
			return "F3";
		case vk_f4:
			return "F4";
		case vk_f5:
			return "F5";
		case vk_f6:
			return "F6";
		case vk_f7:
			return "F7";
		case vk_f8:
			return "F8";
		case vk_f9:
			return "F9";
		case vk_f10:
			return "F10";
		case vk_f11:
			return "F11";
		case vk_f12:
			return "F12";
		case vk_home:
			return "Home";
		case vk_insert:
			return "Insert";
		case vk_lalt:
			return "L Alt";
		case vk_lcontrol:
			return "L Ctrl";
		case vk_left:
			return "Left";
		case vk_lshift:
			return "L Shift";
		case vk_multiply:
			return "*";
		case vk_numpad0:
			return "Num 0";
		case vk_numpad1:
			return "Num 1";
		case vk_numpad2:
			return "Num 2";
		case vk_numpad3:
			return "Num 3";
		case vk_numpad4:
			return "Num 4";
		case vk_numpad5:
			return "Num 5";
		case vk_numpad6:
			return "Num 6";
		case vk_numpad7:
			return "Num 7";
		case vk_numpad8:
			return "Num 8";
		case vk_numpad9:
			return "Num 9";
		case vk_pagedown:
			return "Page Down";
		case vk_pageup:
			return "Page Up";
		case vk_pause:
			return "Pause/Break";
		case vk_printscreen:
			return "Print Screen";
		case vk_ralt:
			return "R Alt";
		case vk_rcontrol:
			return "R Ctrl";
		case vk_right:
			return "Right";
		case vk_rshift:
			return "R Shift";
		case vk_space:
			return "Space";
		case vk_subtract:
			return "-";
		case vk_tab:
			return "Tab";
		case vk_up:
			return "Up";
		case 186:
			return ";";
		default:
			return string(chr(keycode));
	}
}