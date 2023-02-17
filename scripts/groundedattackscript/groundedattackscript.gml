/// @function                   GroundedAttackScript(moveToDo, onGround);
/// @param {moveToDo}  message  The message to show

function GroundedAttackScript(moveToDo, onGround, gravityMult, fallingMult) {
	sprite_index = moveToDo.spriteID;
	grounded = onGround;
	image_index = 0;
	inAttackState = true;
	
	if vsp > 0 vsp += fallSpeed * fallingMult; // If we are falling, apply a gravity modifier
	else vsp += fallSpeed * gravityMult;
	
	PerformAttack(moveToDo);
	
	if (animTimer > moveToDo.duration) {
		state = eState.IDLE;
		frameAdvantage = true;
		hsp = 0;
	}
}