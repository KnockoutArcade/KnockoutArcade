// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// This function can take a keyboard code and return the associated image_index
// of sButtons_Keyboard

function ConvertKeyIntoImageIndex( keyCode)
{
	switch (keyCode)
	{
		// Alphabet (QWERTY order)
		case ord("Q"):
			return 0;
			
		case ord("W"):
			return 1;
			
		case ord("E"):
			return 2;
			
		case ord("R"):
			return 3;
		
		case ord("T"):
			return 4;
			
		case ord("Y"):
			return 5;
			
		case ord("U"):
			return 6;
			
		case ord("I"):
			return 7;
			
		case ord("O"):
			return 8;
			
		case ord("P"):
			return 9;
			
		case ord("A"):
			return 10;
			
		case ord("S"):
			return 11;
		
		case ord("D"):
			return 12;
			
		case ord("F"):
			return 13;
			
		case ord("G"):
			return 14;
			
		case ord("H"):
			return 15;
			
		case ord("J"):
			return 16;
			
		case ord("K"):
			return 17;
			
		case ord("L"):
			return 18;
			
		case ord("Z"):
			return 19;
		
		case ord("X"):
			return 20;
			
		case ord("C"):
			return 21;
			
		case ord("V"):
			return 22;
			
		case ord("B"):
			return 23;
			
		case ord("N"):
			return 24;
			
		case ord("M"):
			return 25;
			
		// Number keys (1-9, 0)
		case ord("1"):
			return 26;
			
		case ord("2"):
			return 27;
			
		case ord("3"):
			return 28;
			
		case ord("4"):
			return 29;
			
		case ord("5"):
			return 30;
			
		case ord("6"):
			return 31;
			
		case ord("7"):
			return 32;
			
		case ord("8"):
			return 33;
			
		case ord("9"):
			return 34;
			
		case ord("0"):
			return 35;
		
		// Punctuation (top left to bottom right)
		//case ord("`"):
		//	return 36;
			
		case ord("-"):
			return 37;
			
		case ord("="):
			return 38;
			
		case ord("["):
			return 39;
			
		case ord("]"):
			return 40;
			
		case ord("\\"):
			return 41;
			
		case 186: // semicolon key
			return 42;
			
		//case ord("'"):
		//	return 43;
			
		case ord(","):
			return 44;
			
		case ord("."):
			return 45;
			
		case ord("/"):
			return 46;
			
		// Word Keys (ESC, shift, space, etc.)
		case vk_backspace:
			return 47;
			
		case vk_tab:
			return 48;
			
		//case vk_: Capslock
		//	return 49;
			
		case vk_enter:
			return 50;
			
		case vk_lshift:
			return 51;
			
		case vk_rshift:
			return 52;
			
		case vk_lcontrol:
			return 53;
			
		case vk_lalt:
			return 54;
			
		case vk_space:
			return 55;
			
		case vk_ralt:
			return 56;
			
		//case vk_: Function
		//	return 57;
		
		case vk_rcontrol:
			return 58;
			
		case vk_escape:
			return 59;
			
		// Arrow Keys
		case vk_right:
			return 60;
			
		case vk_down:
			return 61;
			
		case vk_left:
			return 62;
			
		case vk_up:
			return 63;
			
		// Numpad Keys
		case vk_numpad1:
			return 64;
			
		case vk_numpad2:
			return 65;
			
		case vk_numpad3:
			return 66;
			
		case vk_numpad4:
			return 67;
		
		case vk_numpad5:
			return 68;
			
		case vk_numpad6:
			return 69;
			
		case vk_numpad7:
			return 70;
			
		case vk_numpad8:
			return 71;
			
		case vk_numpad9:
			return 72;
			
		case vk_numpad0:
			return 73;
			
		case vk_decimal:
			return 74;
			
		// failsafe
		default:
			return 75;
	}
}