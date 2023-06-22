/// @function                  CrouchingAttackScript(moveToDo, onGround);
/// @param {moveToDo}  message  The message to show

// maintainState is a boolean. If false, go into a jumping state after leaving the ground
function CrouchingAttackScript(moveToDo, onGround, maintainState) 
{
	sprite_index = moveToDo.SpriteId;
	grounded = onGround;
	image_index = 0;
	inAttackState = true;
	
	PerformAttack(moveToDo);
	
	if (animTimer > moveToDo.Duration) 
	{
		state = eState.CROUCHING;
		frameAdvantage = true;
		hsp = 0;
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
	
	HandleWalkingOffPlatforms(maintainState);
}