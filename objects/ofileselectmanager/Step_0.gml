/// @description Insert description here
// You can write your code in this editor

// Inputs
var P1menuLeft = global.p1ButtonMenuLeft;
var P1menuRight = global.p1ButtonMenuRight;
var P1menuConfirm = global.p1ButtonMenuConfirm;
var P1menuDeny = global.p1ButtonMenuDeny;

menuHorizontalDirection = P1menuLeft + P1menuRight;
menuCooldownTimer--;

if (menuCooldownTimer <= 0 || menuHorizontalDirection == 0)
{
	menuCooldownTimer = 0;
}

if (instance_exists(oScreenTransition))
{
	exit;
}

if (P1menuDeny)
{
	room_goto(rMainMenu);
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
			
			if (selectedFile < 0)
			{
				selectedFile = 2;
			}
		}
		else if (menuHorizontalDirection == 1 && menuCooldownTimer <= 0)
		{
			selectedFile++;
			menuCooldownTimer = menuCooldown;
			
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
		}
	}
	break;
}


