var P1menuUp = global.p1ButtonUp;
var P1menuDown = global.p1ButtonDown;
var P1menuLeft = global.p1ButtonLeft;
var P1menuRight = global.p1ButtonRight;
var P1menuConfirm = global.p1ButtonLight;
var P1menuCancel = global.p1ButtonMedium;

menuCooldown--;

if keyboard_check(ord("Q"))
{
	audio_play_sound(sndTestSfx, 1, true);
}

if (P1menuUp && menuCooldown < 1)
{
	image_index--;
	menuCooldown = 7;
}

if (P1menuDown == -1 && menuCooldown < 1)
{
	image_index++;
	menuCooldown = 7;
}

if (P1menuRight && menuCooldown < 1 && image_index = 0)
{
	if musicVolume < 0.99
	{
		musicVolume += 0.01;
	}
	
		audio_group_set_gain(audiogroup_music, musicVolume, 0);
}

if (P1menuLeft == -1 && menuCooldown < 1 && image_index = 0)
{
	if musicVolume > 0.01
	{
		musicVolume -= 0.01;
	}
	
	audio_group_set_gain(audiogroup_music, musicVolume, 0);
}

if (P1menuRight && menuCooldown < 1 && image_index = 1)
{
	if sfxVolume < 0.99
	{
		sfxVolume += 0.01;
	}
	
		audio_group_set_gain(audiogroup_soundeffect, sfxVolume, 0);
}

if (P1menuLeft == -1 && menuCooldown < 1 && image_index = 1)
{
	if sfxVolume > 0.01
	{
		sfxVolume -= 0.01;
	}
	
	audio_group_set_gain(audiogroup_soundeffect, sfxVolume, 0);
}

if (P1menuConfirm && image_index = 2)
{	
	room_goto(rControlsRoom);
}

if (P1menuCancel)
{
	room_goto(rMainMenu);
}