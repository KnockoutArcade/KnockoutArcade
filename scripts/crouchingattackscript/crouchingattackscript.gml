/// @function                  CrouchingAttackScript(moveToDo, onGround);
/// @param {moveToDo}  message  The message to show

// maintainState is a boolean. If false, go into a jumping state after leaving the ground
function CrouchingAttackScript(moveToDo, onGround, maintainState) 
{
	sprite_index = moveToDo.SpriteId;
	grounded = onGround;
	image_index = 0;
	inAttackState = true;
	
	if (selectedCharacter.UniqueData.SpiritData == 2)
	{
		PerformAttack(moveToDo, true);
	}
	else
	{
		PerformAttack(moveToDo, false);
	}
	
	// If this move temporarily summons the spirit to attack in Spirit OFF
	if (selectedCharacter.UniqueData.SpiritData == 1 && !spiritState && moveToDo.SpiritData.PerformInSpiritOff && !spiritBroken)
	{
		if (!spiritSummoned)
		{
			SummonSpirit(spirit);
			spiritObject.image_xscale = image_xscale;
			spiritObject.x += moveToDo.SpiritData.StartXOffset * image_xscale;
			spiritObject.y += moveToDo.SpiritData.StartYOffset;
			var spiritFire = instance_create_layer(spiritObject.x, spiritObject.y, "Instances", oSpiritFire);
			spiritFire.depth = depth + 1;
		}
		if (moveToDo.SpiritData.SummonSpirit)
		{
			spiritState = true;
			if (selectedCharacter.UniqueData.DoubleJump)
			{
				canDoubleJump = true;
			}
			// Temporary code to change Jay's moveset when summoning Smooth Criminal
			currentMovesetID = 2;
			OverwriteMoveset();
		}
		spiritObject.state = state;
	}
	
	if (animTimer > moveToDo.Duration) 
	{
		state = eState.CROUCHING;
		frameAdvantage = true;
		hsp = 0;
		isThrowable = true;
		isEXFlash = false;
		
		// If this move updates the moveset, switch the moveset
		if (selectedCharacter.UniqueData.AdditionalMovesets > 0) // If this character has multiple movesets...
		{
			if (moveToDo.SwitchMoveset && !spiritBroken)
			{
				currentMovesetID = moveToDo.SwitchToMoveset;
				OverwriteMoveset();
			}
		}
		
		// If this move switched Spirit state
		if (selectedCharacter.UniqueData.SpiritData == 1 && moveToDo.SpiritData.ToggleState && !spiritBroken)
		{
			if (!spiritState)
			{
				if (!spiritSummoned) 
				{
					var spiritFire = instance_create_layer(x + (10 * image_xscale), y, "Instances", oSpiritFire);
					spiritFire.depth = depth + 1;
					SummonSpirit(spirit);
					spiritObject.image_xscale = image_xscale;
				}
				spiritState = true;
				if (selectedCharacter.UniqueData.DoubleJump)
				{
					canDoubleJump = true;
				}
			}
			else
			{
				if (spiritSummoned) 
				{
					instance_create_layer(spiritObject.x, spiritObject.y, "Instances", oSpiritFire);
					instance_destroy(spiritObject.hurtbox);
					instance_destroy(spiritObject);
					spiritObject = noone;
					spiritSummoned = false;
				}
				spiritState = false;
				if ((selectedCharacter.JumpType & 1) != 1)
				{
					canDoubleJump = false;
				}
			}
		}
	}
	
	HandleWalkingOffPlatforms(maintainState);
}