if (!isClosingOptionsMenu)
{
	var P1menuUp = global.p1ButtonMenuUp;
	var P1menuDown = global.p1ButtonMenuDown;
	P1menuLeft = global.p1ButtonMenuLeft;
	P1menuRight = global.p1ButtonMenuRight;
	var P1menuConfirm = global.p1ButtonMenuConfirm;
	var P1menuCancel = global.p1ButtonMenuDeny;

	menuCooldown--;

	if (P1menuUp && menuCooldown < 1)
	{
		image_index--;
		menuCooldown = menuCooldownBuffer;
		
		audio_play_sound(sfx_UI_Hover, 0, false);
	}

	if (P1menuDown == -1 && menuCooldown < 1)
	{
		image_index++;
		menuCooldown = menuCooldownBuffer;
		audio_play_sound(sfx_UI_Hover, 0, false);
	}

	if (P1menuRight && menuCooldown < 1 && image_index = 0)
	{
		if (global.musicVolume < 1)
		{
			global.musicVolume += 0.1;
		}
		menuCooldown = menuCooldownBuffer;
		
		audio_play_sound(sfx_UI_Select, 0, false);
	}

	if (P1menuLeft == -1 && menuCooldown < 1 && image_index = 0)
	{
		if (global.musicVolume > 0)
		{
			global.musicVolume -= 0.1;
		}
		menuCooldown = menuCooldownBuffer;
		
		audio_play_sound(sfx_UI_Select, 0, false);
	}

	if (P1menuRight && menuCooldown < 1 && image_index = 1)
	{
		if (global.sfxVolume < 1)
		{
			global.sfxVolume += 0.1;
		}
		menuCooldown = menuCooldownBuffer;
		
		audio_play_sound(sfx_UI_Select, 0, false);
	}

	if (P1menuLeft == -1 && menuCooldown < 1 && image_index = 1)
	{
		if (global.sfxVolume > 0)
		{
			global.sfxVolume -= 0.1;
		}
		menuCooldown = menuCooldownBuffer;
		
		audio_play_sound(sfx_UI_Select, 0, false);
	}

	if (P1menuRight && menuCooldown < 1 && image_index = 2)
	{
		if (global.voicesVolume < 1)
		{
			global.voicesVolume += 0.1;
		}
		menuCooldown = menuCooldownBuffer;
		
		audio_play_sound(sfx_UI_Select, 0, false);
	}

	if (P1menuLeft == -1 && menuCooldown < 1 && image_index = 2)
	{
		if (global.voicesVolume > 0)
		{
			global.voicesVolume -= 0.1;
		}
		menuCooldown = menuCooldownBuffer;
		
		audio_play_sound(sfx_UI_Select, 0, false);
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
		
		audio_play_sound(sfx_UI_Select, 0, false);
	}

	if (P1menuCancel)
	{
		isClosingOptionsMenu = true;
		
		audio_play_sound(sfx_UI_Exit, 0, false);
	}
}
else
{
	exitingAnimationTimer++;
	
	if (exitingAnimationTimer < 4)
	{
		exitingAnimationFrame = 0;
	}
	else if (exitingAnimationTimer < 8)
	{
		exitingAnimationFrame = 1;
	}
	else if (exitingAnimationTimer < 12)
	{
		exitingAnimationFrame = 2;
	}
	else if (exitingAnimationTimer < 16)
	{
		exitingAnimationFrame = 3;
	}
	else if (exitingAnimationTimer < 20)
	{
		exitingAnimationFrame = 4;
	}
	else if (exitingAnimationTimer < 24)
	{
		exitingAnimationFrame = 5;
	}
	else if (exitingAnimationTimer < 28)
	{
		exitingAnimationFrame = 6;
	}
	else if (exitingAnimationTimer < 32)
	{
		exitingAnimationFrame = 7;
	}
	
	if (exitingAnimationTimer == 40)
	{
		room_goto(rMainMenu);
	}
}