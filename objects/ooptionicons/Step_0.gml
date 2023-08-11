var P1menuUp = global.p1ButtonUp;
var P1menuDown = global.p1ButtonDown;
P1menuLeft = global.p1ButtonLeft;
P1menuRight = global.p1ButtonRight;
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

if (P1menuRight && menuCooldown < 1 && image_index = 0)
{
	if (global.musicVolume < 1)
	{
		global.musicVolume += 0.1;
	}
	menuCooldown = menuCooldownBuffer;
}

if (P1menuLeft == -1 && menuCooldown < 1 && image_index = 0)
{
	if (global.musicVolume > 0)
	{
		global.musicVolume -= 0.1;
	}
	menuCooldown = menuCooldownBuffer;
}

if (P1menuRight && menuCooldown < 1 && image_index = 1)
{
	if (global.sfxVolume < 1)
	{
		global.sfxVolume += 0.1;
	}
	menuCooldown = menuCooldownBuffer;
}

if (P1menuLeft == -1 && menuCooldown < 1 && image_index = 1)
{
	if (global.sfxVolume > 0)
	{
		global.sfxVolume -= 0.1;
	}
	menuCooldown = menuCooldownBuffer;
}

if (P1menuRight && menuCooldown < 1 && image_index = 2)
{
	if (global.voicesVolume < 1)
	{
		global.voicesVolume += 0.1;
	}
	menuCooldown = menuCooldownBuffer;
}

if (P1menuLeft == -1 && menuCooldown < 1 && image_index = 2)
{
	if (global.voicesVolume > 0)
	{
		global.voicesVolume -= 0.1;
	}
	menuCooldown = menuCooldownBuffer;
}

if (menuCooldown < 1)
{
	audio_group_set_gain(audiogroup_music, global.musicVolume, 0);
	audio_group_set_gain(audiogroup_soundeffect, global.sfxVolume, 0);
	audio_group_set_gain(audiogroup_voices, global.voicesVolume, 0);
	menuCooldown = menuCooldownBuffer;
}

// if the player releases the direction, immediately refresh the cooldown
if (P1menuLeft == 0 && P1menuRight == 0 && P1menuUp == 0 && P1menuDown == 0)
{
	menuCooldown = 0;
}

if (P1menuConfirm && image_index = 3)
{	
	room_goto(rControlsRoom);
}

if (P1menuCancel)
{
	room_goto(rMainMenu);
}