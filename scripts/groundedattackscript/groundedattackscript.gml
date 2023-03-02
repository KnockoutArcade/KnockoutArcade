/// @function                   GroundedAttackScript(moveToDo, onGround, gravityMult, fallingMult);
/// @param {moveToDo}  Struct of the move data
/// @param {onGround}  If move is performed grounded
/// @param {gravityMultiplier}  Multiplier applied to gravity
/// @param {fallingMultiplier}  Multiplier applied to falling

function GroundedAttackScript(moveToDo, onGround, gravityMultiplier, fallingMultiplier)
{
	sprite_index = moveToDo.spriteId;
	grounded = onGround;
	image_index = 0;
	inAttackState = true;
	
	if (vsp > 0)
	{
		vsp += fallSpeed * fallingMultiplier; // If we are falling, apply a gravity modifier
	}
	else
	{
		vsp += fallSpeed * gravityMultiplier;
	}
	
	PerformAttack(moveToDo);
	
	if (animTimer > moveToDo.duration) 
	{
		state = eState.IDLE;
		frameAdvantage = true;
		hsp = 0;
	}
}