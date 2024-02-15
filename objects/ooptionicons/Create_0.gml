
// Update actual volume
audio_group_set_gain(audiogroup_music, global.musicVolume, 0); // Set the volume
audio_group_set_gain(audiogroup_soundeffect, global.sfxVolume, 0);
audio_group_set_gain(audiogroup_voices, global.voicesVolume, 0);

image_speed = 0
menuCooldown = 0; // how much time is left for the menu cooldown
menuCooldownBuffer = 15; // The amount of frames between held inputs

P1menuLeft = 0
P1menuRight = 0;

var OpenPanel = instance_create_depth(0, 0, 100, oParticles);
with OpenPanel
{
	sprite_index = sOptionsPanelOpen;
	image_index = 0;
	lifetime = 100;
}

isClosingOptionsMenu = false; // Once the player presses Medium Attack to leave, lock everything and play exiting animation
exitingAnimationTimer = 0; // Animation Timer for exiting animation
exitingAnimationFrame = 0; // Which animation frame the exit should be on