/// @description Insert description here
// You can write your code in this editor

if (attatchedTo.spirit != noone)
{
	image_xscale = (attatchedTo.spiritCurrentHealth / attatchedTo.spiritMaxHealth) * MaxLength;
}

if (ui_xOffset < 80)
{
    image_xscale *= -1;
}