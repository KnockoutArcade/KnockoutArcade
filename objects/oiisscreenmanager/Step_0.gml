/// @description Insert description here
// You can write your code in this editor

initInteractScreenTimer++;

if (initInteractScreenTimer >= initInteractScreenDuration)
{
	room_goto(rTitleScreen);
}

if (image_index > image_number - 1)
{
	image_speed = 0;
}

