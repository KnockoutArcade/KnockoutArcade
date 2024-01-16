/// @description Insert description here
// You can write your code in this editor

// Safegaurd in case no player is given
if (attatchedTo != noone)
{
	image_xscale = (attatchedTo.hp / attatchedTo.maxHitPoints) * MaxLength;
	
	// if this health bar is on the left side, flip it's orientation
	if (ui_xOffset < 80)
	{
	    image_xscale *= -1;
	}
	
	// if the object that we are attached to is NOT in hitstun, update the damage sprite's length
	if (attatchedTo.hitstun <= 0 && attatchedTo.state != eState.LAUNCHED)
	{
		if (abs(initialHealthXscale) != abs(image_xscale))
		{
			// Otherwise, if the damage sprite and the health sprite are different lengths, then we
			// know a combo just ended and we should start gradually decreasing the damage sprite
			isDecreasingSpriteGradually = true;
		}
		
		// if we aren't trying to decrease the sprite, set the damage xscale to the health xscale
		if (!isDecreasingSpriteGradually)
		{
			initialHealthXscale = image_xscale; 
			// We mulitply by sign of maxLength to allow
			// the damage sprite to be flipped if the
			// health bar is supposed to be flipped
		}
		
		
	}
	
	// if we are currently decreasing the hurt sprite...
	if (isDecreasingSpriteGradually)
	{
		// If the damage sprite is less than one, then subtract the remaining fractional portion
		// to prevent indefinite sprite flipping.
		if (abs(initialHealthXscale) < 1)
		{
			initialHealthXscale -= sign(initialHealthXscale) * frac(initialHealthXscale);
		}
		else // Otherwise, decrease the xscale by 1
		{
			initialHealthXscale -= sign(initialHealthXscale);
		}
		
		// if we've finished decreasing the xscale, stop decreasing
		if (abs(initialHealthXscale) <= abs(image_xscale))
		{
			// reset the damage sprite
			isDecreasingSpriteGradually = false;
			initialHealthXscale = image_xscale;
		}
	}
}




