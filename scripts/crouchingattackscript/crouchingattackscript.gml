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
	if (selectedCharacter.UniqueData.SpiritData == 1 && !spiritState && moveToDo.SpiritData.PerformInSpiritOff && !spiritBroken)
	{
		SummonInSpiritOff(moveToDo);
	}
	
	// If the current move doesn't have the spirit perform a move in Spirit OFF and it's around, destroy it
	if (selectedCharacter.UniqueData.SpiritData == 1 && !spiritState && spiritObject != noone && !moveToDo.SpiritData.PerformInSpiritOff)
	{
		DeactivateSpirit(false);
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
				DeactivateSpirit(false);
			}
		}
	}
	
	HandleWalkingOffPlatforms(maintainState);
}