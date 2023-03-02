// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/*
		Dear future me,
		
		You're probably looking at the code below and thinking, "What the heck is going on here?" Don't
		worry, it's actually quite simple.
		
		You see, we needed a simple way to determine what frame of the animation needed to be shown
		at any time. The code below interates through every window to see what should be displayed,
		indicated by numOfWindows. It grabs this data from a global struct made when the game
		starts. If animTimer is greater than the value provided by that window's Length value,
		it sets the image_index to the value according to the image_index value of that window.
		
		window is a 2D matrix. The first value is the window's ID, the second value is the specific
		data partaining to that window. A value of 0 is the Length Value for that window, 1 is
		the image_index of that window.
			
		TLDR: I'm trying to future-proof this code when/if I add more characters.
*/

function PerformAttack(Action)
{
	var hitbox = 0;
	// Animations
	for (var i = 0; i < Action.numOfWindows; i++) 
	{
			//if (animTimer >= Action.window[i][0])
			if(animTimer >= Action.window[i].ImageIndex)
			{
				//image_index = Action.window[i][1];
				image_index = Action.window[i].Length;
			}
	}
	
	// Throws
	if (Action.isThrow) 
	{
		for (var i = 0; i < Action.opponentPositionData.NumberOfFrames; i++) 
		{
			//Key -   [frame, rel x, rel y, sprite, index, rotation, xscale]
			if (animTimer >= Action.opponentPositionData.Frames[i].Frame && heldOpponent != noone)
			{
				////Key -   [frame, rel x, rel y, sprite, index, rotation, xscale]
				heldOpponent.x = x + Action.opponentPositionData.Frames[i].RelativeX * image_xscale;
				heldOpponent.y = y + Action.opponentPositionData.Frames[i].RelativeY;
				// Assigns the correct sprite to use. It will be different for every character, but we just want to use that character's hurt sprite
				if (Action.opponentPositionData.Frames[i].Sprite == eSpritesToUse.HURT_SPRITE)
				{
				 	heldOpponent.sprite_index = heldOpponent.CharacterSprites.hurt_Sprite;
				}
				else if (Action.opponentPositionData.Frames[i].Sprite == eSpritesToUse.KNOCKDOWN_SPRITE)
				{
					heldOpponent.sprite_index = heldOpponent.CharacterSprites.knockdown_Sprite;
					heldOpponent.image_index = Action.opponentPositionData.Frames[i].Index;
					heldOpponent.image_angle = Action.opponentPositionData.Frames[i].Rotation * image_xscale;
					heldOpponent.image_xscale = Action.opponentPositionData.Frames[i].XScale * image_xscale;
				}
			}
		}
	}
	
	
	// Momentum Data
	// Grounded
	if (Action.groundMovementData.NumberOfWindows > 0 && grounded)
	{
		var currentMovementWindow = 0; // The current window that we are using for momentum data
		for (var i = 0; i < Action.groundMovementData.NumberOfWindows; i++) 
		{
			// We iterate through each window from left to right to determine which window should be active.
			// If animTimer is >= the current window's starting_frame, then it will become the active window.
			// If more than one window works, this code will allow the largest of the valid windows to be
			// the active window.
			if (animTimer >= Action.groundMovementData.Windows[i].StartingFrame)
			{
				currentMovementWindow = i;
			}
		}
		
		// check hsp overwrite flag
		// If the overwrite flag hsp is set to 1, then we overwrite the player's current momentum for the desired value
		// If not, the velocity gets added to our current velocity.
		if (Action.groundMovementData.Windows[currentMovementWindow].OverwriteHorizontalSpeed)
		{ // hsp velocity
			hsp = Action.groundMovementData.Windows[currentMovementWindow].HorizontalSpeed * image_xscale; // hsp value 
		} 
		else
		{
			hsp += Action.groundMovementData.Windows[currentMovementWindow].HorizontalSpeed * image_xscale;
		}
		
		// check vsp overwrite flag
		if (Action.groundMovementData.Windows[currentMovementWindow].OverwriteVerticalSpeed)
		{
			vsp = Action.groundMovementData.Windows[currentMovementWindow].VerticalSpeed;
		}
		else
		{
			vsp += Action.groundMovementData.Windows[currentMovementWindow].VerticalSpeed;
		}
		
	} 
	
	// Air
	if (Action.airMovementData.NumberOfWindows > 0 && !grounded)
	{
		var currentMovementWindow = 0; // The current window that we are using for momentum data
		for (var i = 0; i < Action.airMovementData.NumberOfWindows; i++)
		{
			// Same as grounded
			if (animTimer >= Action.airMovementData.Windows[i].StartingFrame)
			{
				currentMovementWindow = i;
			}
		}
		
		// check hsp overwrite flag
		if (Action.airMovementData.Windows[currentMovementWindow].OverwriteHorizontalSpeed)
		{ // hsp velocity
			hsp = Action.airMovementData.Windows[currentMovementWindow].HorizontalSpeed * image_xscale; // hsp value 
		} 
		else
		{
			hsp += Action.airMovementData.Windows[currentMovementWindow].HorizontalSpeed * image_xscale;
		}
		
		// check vsp overwrite flag
		if (Action.airMovementData.window[currentMovementWindow].OverwriteVerticalSpeed)
		{
			vsp = Action.airMovementData.window[currentMovementWindow].VerticalSpeed;
		}
		else
		{
			vsp += Action.airMovementData.window[currentMovementWindow].VerticalSpeed;
		}
	}
	
	
	
	// Hitboxes
	for (var i = 0; i < Action.numOfHitboxes; i++;)
	{
		if (animTimer == Action.attackProperty[i].Start) 
		{
			hitbox = instance_create_layer(x + (Action.attackProperty[i].WidthOffset * other.image_xscale) + 0.5, y - Action.attackProperty[i].HeightOffset, "hitboxes", oHitbox);
			with (hitbox) 
			{
				lifetime = Action.attackProperty[i].Lifetime;
				hitboxID = i;
				image_xscale = Action.attackProperty[i].AttackWidth * other.image_xscale;
				image_yscale = Action.attackProperty[i].AttackHeight;
				owner = other.id;
			
				// Pass through attack data
				attackProperty = Action.attackProperty;
				counterHitProperty = Action.counterHitProperty;
			}
		}
	}
	
	
	// Re-hitting Hitboxes
	if(Action.rehitData.NumberOfHits > 0)
	{
		for (var i = 0; i < Action.rehitData.HitBox; i++;)
		{
			for (var j = 0; j < Action.rehitData.NumberOfHits; j++;)
			{
				if (animTimer == Action.rehitData.HitOnFrames[j])
				{
					hitbox = instance_create_layer(x + (Action.attackProperty[i].WidthOffset * other.image_xscale) + 0.5, y - Action.attackProperty[i].HeightOffset, "hitboxes", oHitbox);
					
					with (hitbox) 
					{
						lifetime = Action.attackProperty[i].Lifetime;
						hitboxID = i;
						image_xscale = Action.attackProperty[i].AttackWidth * other.image_xscale;
						image_yscale = Action.attackProperty[i].AttackHeight;
						owner = other.id;
			
						// Pass through attack data
						attackProperty = Action.attackProperty;
						counterHitProperty = Action.counterHitProperty;
						
					}
					
					// Clears the hitBy data to allow attacks to connect properly
						ds_list_clear(hitByGroup);
						ds_list_clear(opponent.hitByGroup);
				}
			}
		}
	}
	
	// Hurtboxes
	hitbox = 0;
	for (var i = 0; i < Action.numOfHurtboxes; i++;) 
	{
		if (animTimer == Action.hurtboxProperty[i].Start)
		{
			hitbox = instance_create_layer(x + (Action.hurtboxProperty[i].WidthOffset * other.image_xscale), y - Action.hurtboxProperty[i].HeightOffset, "hitboxes", oPlayerHurtbox);
			
			with (hitbox) 
			{
				lifetime = Action.hurtboxProperty[i].Lifetime;
				hurtboxID = i;
				image_xscale = Action.hurtboxProperty[i].AttackWidth * other.image_xscale;
				image_yscale = Action.hurtboxProperty[i].AttackHeight;
				owner = other.id;
				
				hurtboxProperty = Action.hurtboxProperty;
			}
		}
	}	
}