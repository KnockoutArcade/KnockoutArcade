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
		
	PerformAttack(moveToDo);
	
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
				if (!spiritSummoned) SummonSpirit(spirit);
				spiritState = true;
			}
			else
			{
				if (spiritSummoned) 
				{
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