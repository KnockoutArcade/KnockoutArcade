// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function LateCancelIntoMove(_prevState, moveToCancel, attackID){
	prevState = _prevState;
	hitstopBuffer = true;
	sprite_index = moveToCancel.spriteID;
	PressAttackButton(attackID);
	animTimer = 0;

	// Iterate through every hurtbox in the scene and destroy each nonprimary hurtbox
	for (var i = 0; i < instance_number(oPlayerHurtbox); i++;) {
		var hurtbox = instance_find(oPlayerHurtbox, i);
	
		if hurtbox.primary == false && hurtbox.owner == id instance_destroy(hurtbox);
	}
}