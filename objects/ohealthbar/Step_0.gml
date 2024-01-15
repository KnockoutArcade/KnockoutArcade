/// @description Insert description here
// You can write your code in this editor

// Safegaurd in case no player is given
if (attatchedTo != noone)
{
	image_xscale = (attatchedTo.hp / attatchedTo.maxHitPoints) * MaxLength;

	// if the object that we are attached to is in hitstun, don't update the damage sprite's length
	if (attatchedTo.hitstun <= 0 && attatchedTo.state != eState.LAUNCHED)
	{
		initialHealthXscale = image_xscale;
	}
}


if (ui_xOffset < 80)
{
    image_xscale *= -1;
}

