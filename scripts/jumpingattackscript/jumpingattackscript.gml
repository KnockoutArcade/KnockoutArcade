/// @function                  JumpingAttackScript(moveToDo, onGround);
/// @param {moveToDo}  message  The message to show

function JumpingAttackScript(moveToDo, onGround, gravityMult, fallingMult) 
{
	sprite_index = moveToDo.SpriteId;
	grounded = onGround;
	image_index = 0;
	inAttackState = true;
	
	if vsp > 0 vsp += fallSpeed * fallingMult; // If we are falling, apply a gravity modifier
	else vsp += fallSpeed * gravityMult;
		
	if (selectedCharacter.UniqueData.SpiritData == 2)
	{
		PerformAttack(moveToDo, true);
	}
	else
	{
		PerformAttack(moveToDo, false);
	}
	
	// If this move temporarily summons the spirit to attack in Spirit OFF
	if (selectedCharacter.UniqueData.SpiritData == 1 && !spiritState && moveToDo.SpiritData.PerformInSpiritOff)
	{
		if (!spiritSummoned)
		{
			var spiritFire = instance_create_layer(x + (10 * image_xscale), y, "Instances", oSpiritFire);
			spiritFire.depth = depth + 1;
			SummonSpirit(spirit);
			spiritObject.image_xscale = image_xscale;
		}
		spiritObject.state = state;
	}
	
	if (animTimer > moveToDo.Duration) 
	{
		state = eState.JUMPING;
		frameAdvantage = true;
		isThrowable = true;
		isEXFlash = false;
		
		// If this move updates the moveset, switch the moveset
		if (selectedCharacter.UniqueData.AdditionalMovesets > 0) // If this character has multiple movesets...
		{
			if (moveToDo.SwitchMoveset)
			{
				currentMovesetID = moveToDo.SwitchToMoveset;
				OverwriteMoveset();
			}
		}
		
		// If this move switched Spirit state
		if (selectedCharacter.UniqueData.SpiritData == 1 && moveToDo.SpiritData.ToggleState)
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
			}
		}
	}
}