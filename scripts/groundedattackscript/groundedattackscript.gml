/// @function                   GroundedAttackScript(moveToDo, onGround);
/// @param {moveToDo}  message  The message to show

// maintainState is a boolean. If false, go into a jumping state after leaving the ground
function GroundedAttackScript(moveToDo, onGround, gravityMult, fallingMult, ignoreWalkoff, maintainState) 
{
	sprite_index = moveToDo.spriteID;
	grounded = onGround;
	image_index = 0;
	inAttackState = true;
	
	if vsp > 0 vsp += fallSpeed * fallingMult; // If we are falling, apply a gravity modifier
	else vsp += fallSpeed * gravityMult;
	
	PerformAttack(moveToDo);
	
	if (animTimer > moveToDo.duration) 
	{
		state = eState.IDLE;
		frameAdvantage = true;
		hsp = 0;
		isThrowable = true;
	}
	
	if (!ignoreWalkoff)
	{
		HandleWalkingOffPlatforms(maintainState);
	}
}