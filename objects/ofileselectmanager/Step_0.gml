/// @description Insert description here
// You can write your code in this editor

// Find the first controller
var slot0Controller = FindController(0); // Find the first gamepad ID
var wasdController = FindController(13); // Find the WASD controller object

// Both the first controller slot and the WASD controller can control the file screen

// initialize the inputs
var P1menuLeft = 0;
var P1menuRight = 0;
var P1menuUp = 0;
var P1menuDown = 0;

var P1menuConfirm = 0;
var P1menuDeny = 0;

// Handle detecting controller inputs
if (slot0Controller != -1)
{
	if (slot0Controller.buttonMenuLeft == -1) 
	{
		P1menuLeft = -1;
		mostRecentControllerType = CONTROLLER_TYPES.PAD;
	}
	if (slot0Controller.buttonMenuRight) 
	{
		P1menuRight = 1;
		mostRecentControllerType = CONTROLLER_TYPES.PAD;
	}
	
	if (slot0Controller.buttonMenuUp) 
	{
		P1menuUp = 1;
		mostRecentControllerType = CONTROLLER_TYPES.PAD;
	}
	if (slot0Controller.buttonMenuDown == -1) 
	{
		P1menuDown = -1;
		mostRecentControllerType = CONTROLLER_TYPES.PAD;
	}

	if (slot0Controller.buttonMenuConfirm) 
	{
		P1menuConfirm = true;
		mostRecentControllerType = CONTROLLER_TYPES.PAD;
	}
	if (slot0Controller.buttonMenuDeny) 
	{
		P1menuDeny = true;
		mostRecentControllerType = CONTROLLER_TYPES.PAD;
	}
}
// Handle detecting WASD inputs
if (wasdController != -1)
{
	if (wasdController.buttonMenuLeft == -1) 
	{
		P1menuLeft = -1;
		mostRecentControllerType = CONTROLLER_TYPES.WASD;
	}
	if (wasdController.buttonMenuRight) 
	{
		P1menuRight = 1;
		mostRecentControllerType = CONTROLLER_TYPES.WASD;
	}
	
	if (wasdController.buttonMenuUp) 
	{
		P1menuUp = 1;
		mostRecentControllerType = CONTROLLER_TYPES.WASD;
	}
	if (wasdController.buttonMenuDown == -1) 
	{
		P1menuDown = -1;
		mostRecentControllerType = CONTROLLER_TYPES.WASD;
	}

	if (wasdController.buttonMenuConfirm) 
	{
		P1menuConfirm = true;
		mostRecentControllerType = CONTROLLER_TYPES.WASD;
	}
	if (wasdController.buttonMenuDeny) 
	{
		P1menuDeny = true;
		mostRecentControllerType = CONTROLLER_TYPES.WASD;
	}
}

menuHorizontalDirection = P1menuLeft + P1menuRight;
var menuVerticalDirection = P1menuUp + P1menuDown;
menuCooldownTimer--;

if (menuCooldownTimer <= 0 || (menuHorizontalDirection == 0 && menuVerticalDirection == 0))
{
	menuCooldownTimer = 0;
}

if (screenTransitionObject != noone)
{
	// If we have created a backwards screen transition, exit this menu.
	with (screenTransitionObject)
	{
		if (sprite_index == sScreenTransition_Backwards && image_index >= 16)
		{
			room_goto(rMainMenu);
			font_delete(other.fileFont);
			exit;
		}
		else if (sprite_index == sScreenTransition && image_index >= 16)
		{
			room_goto(rRusselMap);
	
			global.campaignMapLocationX = 160;
			global.campaignMapLocationY = 244;
			
			font_delete(other.fileFont);
		}
	}
	
	exit;
}

// This allows the file select intro to be delayed after the initial screen transition.
if (instance_exists(oScreenTransition))
{
	exit;
}

switch (state)
{
	case eFILESELECTMENUSTATES.INTRO :
	{
		if (animTimer == 0)
		{
			// Initialize file locations
			file1PositionX = 16;
			file1PositionY = 130;
			
			file2PositionX = 64;
			file2PositionY = 130;
			
			file3PositionX = 112;
			file3PositionY = 130;
			
			// Initialize title text location
			titlePositionX = -160;
			titlePositionY = 8;
		}
		else
		{
			// Lerp file positions
			if (animTimer > 30)
			{
				file1PositionY = lerp(file1PositionY, fileDestinationY, fileMovementSpeed);
			}
			if (animTimer > 32)
			{
				file2PositionY = lerp(file2PositionY, fileDestinationY, fileMovementSpeed);
			}
			if (animTimer > 34)
			{
				file3PositionY = lerp(file3PositionY, fileDestinationY, fileMovementSpeed);
			}
			
			// Lerp Title Position
			titlePositionX = lerp(titlePositionX, 0, 0.2);
			
			// Lerp the leftmost Bar
			layer_x(leftmostBar, lerp(layer_get_x(leftmostBar), leftmostBarTargetPosition, 0.2));
		}
		
		if (animTimer >= 60)
		{
			animTimer = 0;
			
			state = eFILESELECTMENUSTATES.SELECTING_FILE;
		}
		
		animTimer++;
	}
	break;
	
	case eFILESELECTMENUSTATES.SELECTING_FILE : 
	{
		// Select different files
		if (menuHorizontalDirection == -1 && menuCooldownTimer <= 0)
		{
			selectedFile--;
			menuCooldownTimer = menuCooldown;
			
			audio_play_sound(sfx_CharSel_Hover, 0, false);
			
			if (selectedFile < 0)
			{
				selectedFile = 2;
			}
		}
		else if (menuHorizontalDirection == 1 && menuCooldownTimer <= 0)
		{
			selectedFile++;
			menuCooldownTimer = menuCooldown;
			
			audio_play_sound(sfx_CharSel_Hover, 0, false);
			
			if (selectedFile > 2)
			{
				selectedFile = 0;
			}
		}
		
		// Animating Files
		if (selectedFile == 0)
		{
			isSelectingFile1 = true; 
			isSelectingFile2 = false;
			isSelectingFile3 = false;
			
			file1PositionY = lerp(file1PositionY, 32, fileMovementSpeed);
			file2PositionY = lerp(file2PositionY, fileDestinationY, fileMovementSpeed);
			file3PositionY = lerp(file3PositionY, fileDestinationY, fileMovementSpeed);
			
			file1DrawColor = #9092a6;
			file2DrawColor = #38343b;
			file3DrawColor = #38343b;
			
			file1TextDrawColor = c_white;
			file2TextDrawColor = #b2b2b2;
			file3TextDrawColor = #b2b2b2;
		}
		else if (selectedFile == 1)
		{
			isSelectingFile1 = false; 
			isSelectingFile2 = true;
			isSelectingFile3 = false;
			
			file1PositionY = lerp(file1PositionY, fileDestinationY, fileMovementSpeed);
			file2PositionY = lerp(file2PositionY, 32, fileMovementSpeed);
			file3PositionY = lerp(file3PositionY, fileDestinationY, fileMovementSpeed);
			
			file1DrawColor = #38343b;
			file2DrawColor = #9092a6;
			file3DrawColor = #38343b;
			
			file1TextDrawColor = #b2b2b2;
			file2TextDrawColor = c_white;
			file3TextDrawColor = #b2b2b2;
		}
		else
		{
			isSelectingFile1 = false; 
			isSelectingFile2 = false;
			isSelectingFile3 = true;
			
			file1PositionY = lerp(file1PositionY, fileDestinationY, fileMovementSpeed);
			file2PositionY = lerp(file2PositionY, fileDestinationY, fileMovementSpeed);
			file3PositionY = lerp(file3PositionY, 32, fileMovementSpeed);
			
			file1DrawColor = #38343b;
			file2DrawColor = #38343b;
			file3DrawColor = #9092a6;
			
			file1TextDrawColor = #b2b2b2;
			file2TextDrawColor = #b2b2b2;
			file3TextDrawColor = c_white;
		}
		
		// Going back to the main menu
		if (P1menuDeny)
		{
			// Create the screen transition object to take us away
			screenTransitionObject = instance_create_depth(0, 0, -10000, oScreenTransition);
			screenTransitionObject.sprite_index = sScreenTransition_Backwards;
			audio_play_sound(sfx_UI_Exit, 0, false);
			
			exit;
		}
		
		// Confirming a file
		if (P1menuConfirm)
		{
			state = eFILESELECTMENUSTATES.CHOSE_FILE;
			animTimer = 0;
			
			audio_play_sound(sfx_UI_Select, 0, false);
		}
	}
	break;
	
	case eFILESELECTMENUSTATES.CHOSE_FILE : 
	{
		animTimer++;
		
		// Slide the unselected files down
		if (animTimer <= 30)
		{
			if (selectedFile == 0) // Selected the first file
			{
				file2PositionY = lerp(file2PositionY, 160, fileMovementSpeed - 0.1);
				file3PositionY = lerp(file3PositionY, 160, fileMovementSpeed - 0.1);
				
				file1PositionY = 32;
			}
			else if (selectedFile == 1) // Selected the second
			{
				file1PositionY = lerp(file1PositionY, 160, fileMovementSpeed - 0.1);
				file3PositionY = lerp(file3PositionY, 160, fileMovementSpeed - 0.1);
				
				file2PositionY = 32;
			}
			else if (selectedFile == 2) // Third
			{
				file1PositionY = lerp(file1PositionY, 160, fileMovementSpeed - 0.1);
				file2PositionY = lerp(file2PositionY, 160, fileMovementSpeed - 0.1);
				
				file3PositionY = 32;
			}
		}
		else if (animTimer > 45 && animTimer <= 75) // Slide the selected file down and the Title to the left
		{
			if (selectedFile == 0) // Selected the first file
			{
				file1PositionY = lerp(file1PositionY, 170, fileMovementSpeed - 0.1);
				
			}
			else if (selectedFile == 1) // Selected the second
			{
				file2PositionY = lerp(file2PositionY, 170, fileMovementSpeed - 0.1);
			}
			else if (selectedFile == 2) // Third
			{
				file3PositionY = lerp(file3PositionY, 170, fileMovementSpeed - 0.1);
			}
			
			// Lerp Title Position
			titlePositionX = lerp(titlePositionX, -160, 0.2);
		}
		else if (animTimer > 75) // transition to the character select
		{
			state = eFILESELECTMENUSTATES.CHARACTER_SELECT_INTRO;
			titleSubimage = 1;
			animTimer = 0;
			
			// Initialize the voucher to be offscreen
			characterVoucherPositionX = 160;
			characterVoucherPositionY = 52;
		}
	}
	break;
	
	case eFILESELECTMENUSTATES.CHARACTER_SELECT_INTRO :
	{
		animTimer++;
		
		if (animTimer < 30) // Slide in the new Title and the Character Voucher
		{
			// Lerp Title Position
			titlePositionX = lerp(titlePositionX, 0, 0.2);
		}
		else if (animTimer >= 30 && animTimer < 60)
		{
			titlePositionX = 0;
			
			// Lerp Character Voucher
			characterVoucherPositionX = lerp(characterVoucherPositionX, characterVoucherTargetPositionX, 0.2);
		}
		else
		{
			state = eFILESELECTMENUSTATES.SELECTING_CHARACTER;
			selectorPositionX = 31;
		}
		
	}
	break;
	
	case eFILESELECTMENUSTATES.SELECTING_CHARACTER :
	{
		// Lerp the Voucher slightly
		characterVoucherPositionY = lerp(characterVoucherPositionY, characterVoucherTargetPositionY - 5, 0.2);
		
		animTimer++;
		selectorPositionX = 31 + (sin(animTimer/4) * 2);
		
		// Going back to the file Select
		if (P1menuDeny)
		{
			animTimer = 0;
			state = eFILESELECTMENUSTATES.CANCEL_CHARACTER_SELECT;
			audio_play_sound(sfx_UI_Exit, 0, false);
			
			exit;
		}
		
		// Selecting a character
		if (P1menuConfirm)
		{
			state = eFILESELECTMENUSTATES.CHOSE_CHARACTER;
			currentRow = 0;
			
			audio_play_sound(sfx_UI_Select, 0, false);
		}
	}
	break;
	
	case eFILESELECTMENUSTATES.CANCEL_CHARACTER_SELECT :
	{
		animTimer++;
		
		if (animTimer <= 25)
		{
			// Lerp the Voucher slightly
			characterVoucherPositionY = lerp(characterVoucherPositionY, characterVoucherTargetPositionY, 0.2);
		}
		else if (animTimer > 25 && animTimer <= 60)
		{
			// Lerp Character Voucher
			characterVoucherPositionX = lerp(characterVoucherPositionX, 175, 0.23);
			
			// Lerp the Title
			titlePositionX = lerp(titlePositionX, -160, 0.23);
		} 
		else if (animTimer > 60)
		{
			titleSubimage = 0;
			animTimer = 0;
			state = eFILESELECTMENUSTATES.INTRO;
		}
	}
	break;
	
	case eFILESELECTMENUSTATES.CHOSE_CHARACTER :
	{
		// Handle Option Selection
		if (menuVerticalDirection == -1 && menuCooldownTimer <= 0)
		{
			currentRow--;
			menuCooldownTimer = menuCooldown;
			
			audio_play_sound(sfx_CharSel_Hover, 0, false);
			
			if (currentRow < 0)
			{
				currentRow = maxRows - 1;
			}
		}
		else if (menuVerticalDirection == 1 && menuCooldownTimer <= 0)
		{
			currentRow++;
			menuCooldownTimer = menuCooldown;
			
			audio_play_sound(sfx_CharSel_Hover, 0, false);
			
			if (currentRow > maxRows - 1)
			{
				currentRow = 0;
			}
		}
		
		// Handle Menu Deny
		if (P1menuDeny || (P1menuConfirm && currentRow == 1))
		{
			currentRow = 0;
			
			state = eFILESELECTMENUSTATES.SELECTING_CHARACTER;
			animTimer = 0;
			
			audio_play_sound(sfx_UI_Exit, 0, false);
			
			exit;
		}
		
		// Handle Menu Confirm
		if (P1menuConfirm)
		{
			state = eFILESELECTMENUSTATES.SELECTING_CHARACTER;
			
			// Create the screen transition object to take us away
			screenTransitionObject = instance_create_depth(0, 0, -10000, oScreenTransition);
			
			audio_play_sound(sfx_UI_Select, 0, false);
			
			exit;
		}
	}
	break;
}


