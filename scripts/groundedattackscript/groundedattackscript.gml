/// @function                   GroundedAttackScript(moveToDo, onGround);
/// @param {moveToDo}  message  The message to show

// maintainState is a boolean. If false, go into a jumping state after leaving the ground
function GroundedAttackScript(moveToDo, onGround, gravityMult, fallingMult, ignoreWalkoff, maintainState) 
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
		if (moveToDo.SpiritData.Vulnerable)
		{
			vulnerable = true;
		}
	}
	else
	{
		PerformAttack(moveToDo, false);
	}
	
	// Activate pending summon
	// The purpose of this is to actiate/deactivate spirit if a toggle move is performed but it's interrupted before it ends
	if (selectedCharacter.UniqueData.SpiritData == 1 && moveToDo.SpiritData.ToggleState && !spiritBroken)
	{
		pendingToggle = true;
	}
	
	// If this move temporarily summons the spirit to attack in Spirit OFF
	SummonInSpiritOff(moveToDo);
	
	if (animTimer > moveToDo.Duration) 
	{
		state = eState.IDLE;
		frameAdvantage = true;
		hsp = 0;
		isThrowable = true;
		isEXFlash = false;
		
		// If this move updates the moveset, switch the moveset
		if (selectedCharacter.UniqueData.AdditionalMovesets > 0) // If this character has multiple movesets...
		{
			if (moveToDo.SwitchMoveset)
			{
				if (selectedCharacter.UniqueData.LinkMovesetsWithSpirits && !spiritBroken)
				{
					currentMovesetID = moveToDo.SwitchToMoveset;
					OverwriteMoveset();
				}
				else if (!selectedCharacter.UniqueData.LinkMovesetsWithSpirits)
				{
					currentMovesetID = moveToDo.SwitchToMoveset;
					OverwriteMoveset();
				}
			}
		}
		
		// If this move switched Spirit state
		if (selectedCharacter.UniqueData.SpiritData == 1 && moveToDo.SpiritData.ToggleState && !spiritBroken)
		{
			if (!spiritState)
			{
				SummonSpirit();
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
				pendingToggle = false;
				if ((selectedCharacter.JumpType & 1) != 1)
				{
					canDoubleJump = false;
				}
			}
		}
	}
	
	if (!ignoreWalkoff)
	{
		HandleWalkingOffPlatforms(maintainState);
	}
}