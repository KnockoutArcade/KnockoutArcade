/// @description Insert description here
// You can write your code in this editor

if (global.p1ButtonMenuDeny)
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
			titlePositionX = lerp(titlePositionX, 0, 0.3);
		}
		
		if (animTimer >= 60)
		{
			animTimer = 0;
			
			state = eFILESELECTMENUSTATES.SELECTING_FILE;
		}
		
		animTimer++;
	}
	break;
	
	
}


