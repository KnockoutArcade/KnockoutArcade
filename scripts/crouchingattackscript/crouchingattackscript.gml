/// @function                  CrouchingAttackScript(moveToDo, onGround);
/// @param {moveToDo}  message  The message to show

function CrouchingAttackScript(moveToDo, onGround) 
{
	sprite_index = moveToDo.spriteID;
	grounded = onGround;
	image_index = 0;
	inAttackState = true;
	
	PerformAttack(moveToDo);
	
	if (animTimer > moveToDo.duration) 
	{
		state = eState.CROUCHING;
		frameAdvantage = true;
		hsp = 0;
	}
}