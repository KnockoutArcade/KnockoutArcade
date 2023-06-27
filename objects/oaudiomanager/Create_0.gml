/// @description Insert description here
// You can write your code in this editor
audio_group_stop_all(audiogroup_mus)
audio_group_load(audiogroup_mus);
audio_group_load(audiogroup_sfx);

//switch room 
//{
////Checking which room it is

//	case rRusselStage:
//		musTrack1 = mus_arcadeA;
//		musTrack2 = mus_arcadeB;
//	break;

//	case rBeverlyStage:
//		musTrack1 = mus_testA; //Test A and B are placeholders
//		musTrack2 = mus_testB;
//	break;
	
//	case rJayStage:
//		musTrack1 = mus_testA;
//		musTrack2 = mus_testB;
//	break;

//}

////Playing music in std
//if (global.gameMode == GAMEMODE.VERSUS)
//	{
//		if (global.p1Rounds == 1 && global.p2Rounds == 1)
//		{
//			if (!audio_is_playing(musTrack2))
//			{
//				audio_pause_sound(musTrack1)
//				audio_play_sound(musTrack2,5,true);
//			} 
//		}
//		if (!audio_is_playing(musTrack1))
//			{
//			 audio_pause_sound(musTrack1)	
//			 audio_play_sound(musTrack1,5,true);	
//			}
//	}	