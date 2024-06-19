/// @function                  JumpingAttackScript(moveToDo, onGround);
/// @param {moveToDo}  message  The message to show

// 
function JumpingAttackScript(moveToDo, onGround, gravityMult, fallingMult) 
{
	sprite_index = moveToDo.SpriteId;
	grounded = onGround;
	image_index = 0;
	inAttackState = true;
	canBlock = false;
	
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
	if (selectedCharacter.UniqueData.SpiritData == 1 && !spiritState && moveToDo.SpiritData.PerformInSpiritOff && !spiritBroken)
	{
		SummonInSpiritOff(moveToDo);
	}
	
	// If the current move doesn't have the spirit perform a move in Spirit OFF and it's around, deactivate it
	if (selectedCharacter.UniqueData.SpiritData == 1 && !spiritState && spiritObject != noone && 
		 !moveToDo.SpiritData.PerformInSpiritOff && !pendingToggle && !spiritInstall)
	{
		if (!spiritObject.creatingHitbox)
		{
			DeactivateSpirit(false);
		}
	}
	
	if (animTimer > moveToDo.Duration) 
	{
		state = eState.JUMPING;
		jumpHsp = hsp;
		frameAdvantage = true;
		isThrowable = true;
		isEXFlash = false;
		
		// If this move updates the moveset, switch the moveset
		if (selectedCharacter.UniqueData.AdditionalMovesets > 0) // If this character has multiple movesets...
		{
			if (moveToDo.SwitchMoveset && !spiritBroken && !spiritInstall)
			{
				if (selectedCharacter.UniqueData.LinkMovesetsWithSpirits && !spiritBroken)
				{
					if (!spiritState)
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
}