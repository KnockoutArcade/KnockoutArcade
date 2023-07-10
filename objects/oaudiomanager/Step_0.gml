//This entire switch statement is the *ROOM CHECKER** this is going to check which room the players in
//and then assign variables based on what's going on. 
//if mus_testA or mus_testB are used, assume they are placeholders till the actual tracks are finished
switch room 
{
	case rMainMenu: //Main Menu 
		if (enteredRoom = true) 
		{
			audio_pause_sound(mus_testA); //For menus we don't have to define any variables and
			audio_resume_sound(mus_testB);  // can just call out the specific songs outright
			exitedRoom = true;
			enteredRoom = false;
		}
		else if (!audio_is_playing(mus_testB)) //we gotta use if !audio is playing otherwise it will play the song every frame
			{
			 audio_play_sound(mus_testB,5,true);	
			}
		//NOTE: Need bools for exiting from other menus (Training, Campian, ect) when those places have music
	break;
	
	case rRusselStage: //Russel's Stage 
		var musTrack1 = mus_arcadeA; // define local variables for the battle stages because the tracks are dynamic there
		var musTrack2 = mus_arcadeB;
		//Play battle music
		if (!audio_is_playing(musTrack1))
			{
			 audio_play_sound(musTrack1,5,true);	
			}
	break;

	case rBeverlyStage: //Beverly's Stage 
		var musTrack1 = mus_testA; 
		var musTrack2 = mus_testB;
		//Play battle music
		if (!audio_is_playing(musTrack1))
			{
			 audio_play_sound(musTrack1,5,true);	
			}
	break;
	
	case rJayStage: //Jay's Stage
		var musTrack1 = mus_testA;
		var musTrack2 = mus_testB;
		//Play battle music
		if (!audio_is_playing(musTrack1))
			{
			 audio_play_sound(musTrack1,5,true);	
			}
	break;
	
	case rCharacterSelectScreen: //Character Select
		if (exitedRoom = true) 
		{
			audio_resume_sound(mus_testA);
			audio_pause_sound(mus_testB);
		}
		var musTrack1 = mus_testA;
		enteredRoom = true;
		if (!audio_is_playing(mus_testA)) 
			{
			 audio_play_sound(mus_testA,5,true);	
			}
	break;
}

// Battle Music Manager ---
// If the game mode is currently versus, extra condtions will be checked
if (global.gameMode == GAMEMODE.VERSUS) 
	{
		
		if (global.p1Rounds >= 2 || global.p2Rounds >= 2) //When battle is finished
		{
			audio_pause_sync_group(audiogroup_mus);
		}
		
		if (global.p1Rounds == 1 && global.p2Rounds == 1) //Tiebreaker Round
		{
			if (!audio_is_playing(musTrack2))
			{
				audio_pause_sound(musTrack1);
				audio_play_sound(musTrack2,5,true);
			} 
		}
	}

