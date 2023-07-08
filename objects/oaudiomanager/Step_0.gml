
switch room 
{
//Checking which room it is

	case rMainMenu:
		var musMenu = mus_testB;
		var musTrack1 = mus_testB; //place holder 
		var musTrack2 = mus_testB; //place holder song
	case rRusselStage:
		var musTrack1 = mus_arcadeA;
		var musTrack2 = mus_arcadeB;
	break;

	case rBeverlyStage:
		var musTrack1 = mus_testA; //Test A and B are placeholders
		var musTrack2 = mus_testB;
	break;
	
	case rJayStage:
		var musTrack1 = mus_testA;
		var musTrack2 = mus_testB;
	break;
	
	case rCharacterSelectScreen:
		var musMenu = mus_testB;
		var musTrack1 = mus_testA; //place holder 
		var musTrack2 = mus_testB; //place holder song
		//audio_play_sound(musTrack1,5,true);
	break;
	

}

//Checking for gamemode and applying conditions based upon 
if (global.gameMode = GAMEMODE.MENU) 
	{
		
		if (!audio_is_playing(musMenu))
			{
			 audio_play_sound(musMenu,5,true);	
			}
		return;
	}

if (global.gameMode == GAMEMODE.VERSUS)
	{
		if (global.p1Rounds >= 2 || global.p2Rounds >= 2)
		{
		
		}
		
		if (global.p1Rounds == 1 && global.p2Rounds == 1)
		{
			if (!audio_is_playing(musTrack2))
			{
				audio_pause_sound(musTrack1);
				audio_play_sound(musTrack2,5,true);
			} 
		}
		
		if (!audio_is_playing(musTrack1))
			{
			 audio_play_sound(musTrack1,5,true);	
			}
	}	
