// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function OptionsConvertDecimaltoWhole(globalVolume){
	var volume = 0;
	switch(globalVolume)
	{
		case 0:
		{
			volume = 0;
		}
		break;
	
		case 0.1:
		{
			volume = 1;
		}
		break;
	
		case 0.2:
		{
			volume = 2;
		}
		break;
	
		case 0.3:
		{
			volume = 3;
		}
		break;
		case 0.4:
		{
			volume = 4;
		}
		break;
		case 0.5:
		{
			volume = 5;
		}
		break;
		case 0.6:
		{
			volume = 6;
		}
		break;
		case 0.7:
		{
			volume = 7;
		}
		break;
		case 0.8:
		{
			volume = 8;
		}
		break;
		case 0.9:
		{
			volume = 9;
		}
		break;
		case 1:
		{
			volume = 10;
		}
		break;
	}

	return volume;
}