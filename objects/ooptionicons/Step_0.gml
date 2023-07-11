var P1menuUp = global.p1ButtonUp;
var P1menuDown = global.p1ButtonDown;
var P1menuLeft = global.p1ButtonLeft;
var P1menuRight = global.p1ButtonRight;
var P1menuConfirm = global.p1ButtonLight;
var P1menuCancel = global.p1ButtonMedium;

menuCooldown--;

if keyboard_check_pressed(ord("Q"))
{
	audio_play_sound(sfx_Heavy_Hit, 1, false);
}

if (P1menuUp && menuCooldown < 1)
{
	image_index--;
	menuCooldown = menuCooldownBuffer;
}

if (P1menuDown == -1 && menuCooldown < 1)
{
	image_index++;
	menuCooldown = menuCooldownBuffer;
}

if (P1menuRight && image_index = 0)
{
	if (musicVolume < 1)
	{
		musicVolume += 0.1;
	}
}

if (P1menuLeft == -1 && menuCooldown < 1 && image_index = 0)
{
	if (musicVolume > 0)
	{
		musicVolume -= 0.1;
	}
}

if (P1menuRight && menuCooldown < 1 && image_index = 1)
{
	if (sfxVolume < 1)
	{
		sfxVolume += 0.1;
	}
}

if (P1menuLeft == -1 && menuCooldown < 1 && image_index = 1)
{
	if (sfxVolume > 0)
	{
		sfxVolume -= 0.1;
	}
}

if (menuCooldown < 1)
{
	audio_group_set_gain(audiogroup_music, musicVolume, 0);
	audio_group_set_gain(audiogroup_soundeffect, sfxVolume, 0);
	menuCooldown = menuCooldownBuffer;
}

// if the player releases the direction, immediately refresh the cooldown
if (P1menuLeft == 0 && P1menuRight == 0 && P1menuUp == 0 && P1menuDown == 0)
{
	menuCooldown = 0;
}

if (P1menuConfirm && image_index = 2)
{	
	room_goto(rControlsRoom);
}

if (P1menuCancel)
{
	room_goto(rMainMenu);
}