/// @description Insert description here
// You can write your code in this editor

transitionTimer++;

if (transitionTimer >= transitionLength)
{
	instance_destroy();
}

if (image_index >= image_number - 1)
{
	image_index = 14;
}
