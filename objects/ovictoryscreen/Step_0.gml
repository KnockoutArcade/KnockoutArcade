/// @description Insert description here
// You can write your code in this editor

switch (state)
{
	case eVictoryScreenState.OPENING_ANIMATION:
	{
		if (image_index >= image_number - 1)
		{
			image_index = 7;
		}
		
		if (animTimer >= portaits_StartMoving && animTimer < portaits_EndMoving)
		{
			p1CharacterPortait_x = lerp(p1CharacterPortait_x, p1CharacterPortait_EndingPosition[0], 0.1);
			//p2CharacterPortait_x = lerp(p2CharacterPortait_x, p2CharacterPortait_EndingPosition[0], 0.1);
		}
	}
	break;
	
	case eVictoryScreenState.DISPLAY_WIN_QUOTE:
	{
		
	}
	break;
	
	case eVictoryScreenState.OPTIONS:
	{
		
	}
	break;
}


