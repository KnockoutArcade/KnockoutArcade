/// @function                   GroundedAttackScript(moveToDo, onGround);
/// @param {moveToDo}  moveToDo  The message to show

// maintainState is a boolean. If false, go into a jumping state after leaving the ground
function GroundedAttackScript(moveToDo, onGround, gravityMult, fallingMult, ignoreWalkoff, maintainState, attackID) 
{
	sprite_index = moveToDo.SpriteId;
	grounded = onGround;
	image_index = 0;
	inAttackState = true;
	canBlock = false;
	invincible = false;
	
	// Resets all run timers
	holdBackwardTimer = 0;
	runBackwardTimer = 16;
	startedMovingBackward = false;
	runningForward = false;
	holdForwardTimer = 0;
	runForwardTimer = 16;
	startedMovingForward = false;
	runningBackward = false;
	
	// Supplementary Scripts
	if (moveToDo.UseMoveScript)
	{
		var scriptToExecute = asset_get_index(moveToDo.SupplementaryMoveScript);
		
		scriptToExecute();
	}
	
	if vsp > 0 vsp += fallSpeed * fallingMult; // If we are falling, apply a gravity modifier
	else vsp += fallSpeed * gravityMult;
	
	if (selectedCharacter.UniqueData.SpiritData == 2)
	{
		// Hackey way of preventing a crash where a move gets interrupted as soon as a hitbox is created
		creatingHitbox = false;
		for (var i = 0; i < array_length(moveToDo.RehitData.HitOnFrames); i++)
		{
			if (animTimer == moveToDo.RehitData.HitOnFrames[i] + 1 || animTimer == moveToDo.RehitData.HitOnFrames[i])
			{
				creatingHitbox = true;
				break;
			}
		}
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
	if (selectedCharacter.UniqueData.SpiritData == 1 && !spiritON && moveToDo.SpiritData.PerformInSpiritOff && !spiritBroken)
	{
		SummonInSpiritOff(moveToDo);
	}
	
	// If the current move doesn't have the spirit perform a move in Spirit OFF and it's around, destroy it
	if (selectedCharacter.UniqueData.SpiritData == 1 && !spiritON && spiritObject != noone && 
		 !moveToDo.SpiritData.PerformInSpiritOff && !pendingToggle && !spiritInstall)
	{
		DeactivateSpirit(false);
	}
	
	// If we are in Spirit ON, make our Spirit Perform the corresponding attack
	if (spiritON && spiritObject != noone) || (moveToDo.SpiritData.PerformInSpiritOff && !spiritBroken)
	{
		// Transfer momentum
		if (animTimer <= 1 && !spiritObject.hasRecentlyRushCanceled) // If we are not RC'ing, always transfer
		{
			spiritObject.hsp = hsp;
			spiritObject.vsp = vsp;
		}
		else if (animTimer <= 1 && spiritObject.hasRecentlyRushCanceled && image_xscale == spiritObject.image_xscale) // If we are RC'ing, only transfer if we're facing the same direction
		{
			spiritObject.hsp = hsp;
			spiritObject.vsp = vsp;
		}
		
		with (spiritObject)
		{
			animTimer = other.animTimer;
			spiritState = eSpiritState.ATTACK;
			GroundedAttackScript(FindAttackState(other.state), onGround, gravityMult, fallingMult, true, maintainState, attackID);
		}
	}
	
	// Buffer attack input
	if ((animTimer >= moveToDo.Duration - inputBufferLength) && attackID != 0)
	{
		bufferAttackInput = attackID;
	}
	
	// If the animation has expired
	if (animTimer > moveToDo.Duration) 
	{
		state = eState.IDLE;
		frameAdvantage = true;
		//hsp = 0;
		isThrowable = true;
		isEXFlash = false;
		
		// Execute buffered input (make sure not a spirit)
		if (bufferAttackInput != 0 && selectedCharacter.UniqueData.SpiritData != 2)
		{
			PressAttackButton(bufferAttackInput);
			bufferAttackInput = 0;
			animTimer = 0;
		}
		
		// If this performed by a spirit, update their state
		if (selectedCharacter.UniqueData.SpiritData == 2)
		{
			if (inSpiritOff)
			{
				DeactivateSpirit(true);
			}
			else
			{
				spiritState = eSpiritState.ACTIVE;
				moveToPerform = 0;
				sprite_index = CharacterSprites.idle_Sprite;
				hasRecentlyRushCanceled = false;
			}
		}
		
		// If this move updates the moveset, switch the moveset
		if (selectedCharacter.UniqueData.AdditionalMovesets > 0) // If this character has multiple movesets...
		{
			if (moveToDo.SwitchMoveset)
			{
				if (selectedCharacter.UniqueData.LinkMovesetsWithSpirits && !spiritBroken && !spiritInstall)
				{
					if (!spiritON)
					{
						currentMovesetID = selectedCharacter.UniqueData.SpiritOnMoveset;
					}
					else
					{
						currentMovesetID = selectedCharacter.UniqueData.SpiritOffMoveset;
					}
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
		if (selectedCharacter.UniqueData.SpiritData == 1 && moveToDo.SpiritData.ToggleState && !spiritBroken && !spiritInstall)
		{
			if (!spiritON)
			{
				SummonSpirit();
			}
			else
			{
				DeactivateSpirit(false);
			}
		}
	}
	
	if (!ignoreWalkoff)
	{
		HandleWalkingOffPlatforms(maintainState);
	}
}