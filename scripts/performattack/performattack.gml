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

function PerformAttack(Action, createdBySpirit)
{
	var hitbox = 0;
	// Animations
	for (var i = 0; i < Action.NumberOfWindows; i++) 
	{
			if (animTimer >= Action.Window[i].Length)
			{
				image_index = Action.Window[i].ImageIndex;
			}
	}
	
	
	// Momentum Data
	// Grounded
	if (createdBySpirit)
	{
		show_debug_message(grounded);
	}
	if (Action.GroundMovementData.NumberOfWindows > 0 && grounded)
	{
		var currentMovementWindow = 0; // The current window that we are using for momentum data
		for (var i = 0; i < Action.GroundMovementData.NumberOfWindows; i++) 
		{
			// We iterate through each window from left to right to determine which window should be active.
			// If animTimer is >= the current window's starting_frame, then it will become the active window.
			// If more than one window works, this code will allow the largest of the valid windows to be
			// the active window.
			if (animTimer >= Action.GroundMovementData.Windows[i].StartingFrame)
			{
				currentMovementWindow = i;
			}
		}
		
		// check hsp overwrite flag
		// If the overwrite flag hsp is set to 1, then we overwrite the player's current momentum for the desired value
		// If not, the velocity gets added to our current velocity.
		if (Action.GroundMovementData.Windows[currentMovementWindow].OverwriteHorizontalSpeed)
		{ // hsp velocity
			hsp = Action.GroundMovementData.Windows[currentMovementWindow].HorizontalSpeed * image_xscale; // hsp value 
		} 
		else
		{
			hsp += Action.GroundMovementData.Windows[currentMovementWindow].HorizontalSpeed * image_xscale;
		}
		
		// check vsp overwrite flag
		if (Action.GroundMovementData.Windows[currentMovementWindow].OverwriteVerticalSpeed)
		{
			vsp = Action.GroundMovementData.Windows[currentMovementWindow].VerticalSpeed;
		}
		else
		{
			vsp += Action.GroundMovementData.Windows[currentMovementWindow].VerticalSpeed;
		}
		
	} 
	
	// Air
	if (Action.AirMovementData.NumberOfWindows > 0 && !grounded)
	{
		var currentMovementWindow = 0; // The current window that we are using for momentum data
		for (var i = 0; i < Action.AirMovementData.NumberOfWindows; i++)
		{
			// Same as grounded
			if (animTimer >= Action.AirMovementData.Windows[i].StartingFrame) 
			{
				currentMovementWindow = i;
			}
		}
		
		// check hsp overwrite flag
		if (Action.AirMovementData.Windows[currentMovementWindow].OverwriteHorizontalSpeed)
		{ // hsp velocity
			hsp = Action.AirMovementData.Windows[currentMovementWindow].HorizontalSpeed * image_xscale; // hsp value 
		} 
		else 
		{
			hsp += Action.AirMovementData.Windows[currentMovementWindow].HorizontalSpeed * image_xscale;
		}
		
		// check vsp overwrite flag
		if (Action.AirMovementData.Windows[currentMovementWindow].OverwriteVerticalSpeed)
		{
			vsp = Action.AirMovementData.Windows[currentMovementWindow].VerticalSpeed;
		}
		else
		{
			vsp += Action.AirMovementData.Windows[currentMovementWindow].VerticalSpeed;
		}
	}
	
	
	// Throws
	if (Action.IsThrow) 
	{
		for (var i = 0; i < Action.OpponentPositionData.NumberOfFrames; i++) 
		{
			//Key -   [frame, rel x, rel y, sprite, index, rotation, xscale]
			if (animTimer >= Action.OpponentPositionData.Frames[i].Frame && heldOpponent != noone)
			{
				heldOpponent.x = x + Action.OpponentPositionData.Frames[i].RelativeX * image_xscale;
				heldOpponent.y = y + Action.OpponentPositionData.Frames[i].RelativeY;
				// Assigns the correct sprite to use. It will be different for every character, but we just want to use that character's hurt sprite
				if (Action.OpponentPositionData.Frames[i].Sprite == eSpritesToUse.HURT_SPRITE)
				{
				 	heldOpponent.sprite_index = heldOpponent.CharacterSprites.hurt_Sprite;
				}
				else if (Action.OpponentPositionData.Frames[i].Sprite == eSpritesToUse.KNOCKDOWN_SPRITE)
				{
					heldOpponent.sprite_index = heldOpponent.CharacterSprites.knockdown_Sprite;
				}
				
				heldOpponent.image_index = Action.OpponentPositionData.Frames[i].Index;
				heldOpponent.image_angle = Action.OpponentPositionData.Frames[i].Rotation * image_xscale;
				heldOpponent.image_xscale = Action.OpponentPositionData.Frames[i].XScale * image_xscale;
			}
		}
	}
	
	// Sound FX
	//for (var i = 0; i < Action.NumberOfSounds; i++)
	//{
	//	if (animTimer == Action.MoveSoundData[i].SFXPlayFrame) 
	//	{
	//		audio_play_sound(asset_get_index(Action.MoveSoundData[i].SoundEffect), 1, false);
	//	}
	//}
	
	
	// Hitboxes
	for (var i = 0; i < Action.NumberOfHitboxes; i++;) 
	{
		if (animTimer == Action.AttackProperty[i].Start) 
		{
			var hostID = noone;
			if (createdBySpirit)
			{
				hostID = hostObject.id;
			}
			
			hitbox = instance_create_layer(x + (Action.AttackProperty[i].WidthOffset * other.image_xscale) + 0.5, y - Action.AttackProperty[i].HeightOffset, "hitboxes", oHitbox);
			with (hitbox) 
			{
				lifetime = Action.AttackProperty[i].Lifetime;
				hitboxID = i;
				image_xscale = Action.AttackProperty[i].AttackWidth * other.image_xscale;
				image_yscale = Action.AttackProperty[i].AttackHeight;
				if (!createdBySpirit)
				{
					owner = other.id;
				}
				else
				{
					owner = hostID;
					spirit = other.id;
				}
			
				// Pass through attack data
				attackProperty = Action.AttackProperty[i];
				counterHitProperty = Action.CounterHitProperty[i];
			}
		}
	}
	
	
	// Re-hitting Hitboxes
	if (Action.RehitData.NumberOfHits > 0) 
	{
		for (var i = 0; i < Action.RehitData.HitBox; i++;) 
		{
			for (var j = 0; j < Action.RehitData.NumberOfHits; j++;) 
			{
				if (animTimer == Action.RehitData.HitOnFrames[j]) 
				{
					var hostID = noone;
					if (createdBySpirit)
					{
						hostID = hostObject.id;
					}
					
					hitbox = instance_create_layer(x + (Action.AttackProperty[i].WidthOffset * other.image_xscale) + 0.5, y - Action.AttackProperty[i].HeightOffset, "hitboxes", oHitbox);
					with (hitbox) 
					{
						lifetime = Action.AttackProperty[i].Lifetime;
						hitboxID = i;
						image_xscale = Action.AttackProperty[i].AttackWidth * other.image_xscale;
						image_yscale = Action.AttackProperty[i].AttackHeight;
						if (!createdBySpirit)
						{
							owner = other.id;
						}
						else
						{
							owner = hostID;
							spirit = other.id;
						}
			
						// Pass through attack data
						attackProperty = Action.AttackProperty[i];
						counterHitProperty = Action.CounterHitProperty[i];
					}
					
					// Clears the hitBy data to allow attacks to connect properly
					ds_list_clear(hitByGroup);
					if (createdBySpirit)
					{
						ds_list_clear(hostObject.target.hitByGroup);
					}
					if (target != noone)
					{
						ds_list_clear(target.hitByGroup);
					}
				}
			}
		}
	}
	hitbox = 0;
	
	
	// Projectiles
	if (Action.NumberOfProjectiles > 0) 
	{
		for (var i = 0; i < Action.NumberOfProjectiles; i++;)
		{
			if (animTimer == Action.ProjectileData[i].SpawnFrame)
			{
				var Projectile = instance_create_layer(x + (Action.ProjectileData[i].SpawnXOffset * other.image_xscale), y + Action.ProjectileData[i].SpawnYOffset, "Instances", asset_get_index(Action.ProjectileData[i].ProjectileObject));
			
				with (Projectile)
				{
					image_xscale = other.image_xscale;
					playerOwner = other.id;
					
					var hostID = noone;
					if (createdBySpirit)
					{
						hostID = hostObject.id;
					}
					
					hitboxID = instance_create_layer(x + (hitboxProperties.AttackData[i].AttackWidth * other.image_xscale) + 0.5, y - hitboxProperties.AttackData[i].HeightOffset, "hitboxes", oHitbox);
					with (hitboxID) 
					{
						hitboxID = i;
						image_xscale = other.hitboxProperties.AttackData[i].AttackWidth * other.image_xscale;
						image_yscale = other.hitboxProperties.AttackData[i].AttackHeight;
						if (!createdBySpirit)
						{
							owner = other.id;
						}
						else
						{
							owner = hostID;
							spirit = other.id;
						}
						
						isProjectile = true;
			
						// Pass through attack data
						attackProperty = other.hitboxProperties.AttackData[i];
						counterHitProperty = other.hitboxProperties.CounterData[i];
					}
				}
			}
		}
	}
	
	
	// Hurtboxes
	for (var i = 0; i < Action.NumberOfHurtboxes; i++;) 
	{
		if (animTimer == Action.HurtboxProperty[i].Start) 
		{
			var hostID = noone;
			if (createdBySpirit)
			{
				hostID = hostObject.id;
			}
			
			hitbox = instance_create_layer(x + (Action.HurtboxProperty[i].WidthOffset * other.image_xscale), y - Action.HurtboxProperty[i].HeightOffset, "hitboxes", oPlayerHurtbox);
			with (hitbox) 
			{
				lifetime = Action.HurtboxProperty[i].Lifetime;
				hurtboxID = i;
				image_xscale = Action.HurtboxProperty[i].AttackWidth * other.image_xscale;
				image_yscale = Action.HurtboxProperty[i].AttackHeight;
				if (!createdBySpirit)
				{
					owner = other.id;
				}
				else
				{
					owner = hostID;
					spirit = other.id;
				}
				
				hurtboxProperty = Action.HurtboxProperty[i];
			}
		}
	}
}