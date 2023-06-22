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
		
		// If this move updates the moveset, switch the moveset
		if (selectedCharacter.UniqueData.AdditionalMovesets > 0) // If this character has multiple movesets...
		{
			if (moveToDo.SwitchMoveset)
			{
				currentMovesetID = moveToDo.SwitchToMoveset;
				OverwriteMoveset();
			}
		}
	}
}