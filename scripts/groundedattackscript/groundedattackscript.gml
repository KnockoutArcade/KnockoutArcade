/// @function                   GroundedAttackScript(moveToDo, onGround, duration, canWalkCancel, walkCancelDuration);
/// @param {moveToDo}  message  The message to show

function GroundedAttackScript(moveToDo, onGround, duration, canWalkCancel, walkCancelDuration) {
	sprite_index = moveToDo.spriteID;
	grounded = onGround;
	image_index = 0;
	inAttackState = true;
	
	PerformAttack(moveToDo);
	
	if (animTimer > duration) {
		state = eState.IDLE;
		frameAdvantage = true;
		hsp = 0;
	}
	
	if canWalkCancel {
		if (animTimer > walkCancelDuration && movedir != 0) {
			state = eState.WALKING;
			frameAdvantage = true;
		}
	}
}