image_speed = 0
menuCooldown = 0;
menuCooldownBuffer = 15; // The amount of frames between held inputs
drawInitialText = true; // Whether to draw the Welcome text or not
isPercyEyesClosed = false; // Whether Percy is blinking or not (0 for not, 1 for is)
percyBlinkTimer = 0; // Timer for controlling Percy's blinks
percyEyesOpenTimerCap = 120; // The amount of time Percy's eyes remain open
percyEyesClosedTimerCap = 5; // The amount of time Percy's eyes remain closed

screenTransitionObject = noone;

animTimer = 0;

roomToTransitionTo = rCharacterSelectScreen;


if (!audio_is_playing(bgm_MainMenu))
{
	audio_sound_gain(bgm_MainMenu, global.musicVolume, 0);
	audio_play_sound(bgm_MainMenu, 0, true);
}
else if (audio_sound_get_gain(bgm_MainMenu) < 0.1)
{
	audio_stop_sound(bgm_MainMenu);
	
	audio_sound_gain(bgm_MainMenu, global.musicVolume, 0);
	audio_play_sound(bgm_MainMenu, 0, true);
}
