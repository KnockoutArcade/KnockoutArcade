/// @function                   GroundedAttackScript(moveToDo, onGround);
/// @param {moveToDo}  message  The message to show

function GroundedAttackScript(moveToDo, onGround) {
	sprite_index = moveToDo.spriteID;
	grounded = onGround;
	image_index = 0;
	inAttackState = true;
	
	PerformAttack(moveToDo);
	
	if (animTimer > moveToDo.duration) {
		state = eState.IDLE;
		frameAdvantage = true;
		hsp = 0;
	}
}