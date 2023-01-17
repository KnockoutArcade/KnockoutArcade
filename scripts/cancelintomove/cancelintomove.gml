// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CancelIntoMove(_prevState, _prevSprite, _animOffset){
prevState = _prevState;
prevSprite = _prevSprite;
ds_list_clear(hitByGroup);
ds_list_clear(opponent.hitByGroup);
animOffset = _animOffset;
hitstopBuffer = true;

// Iterates through every hurtbox in the scene and destroys each one that isn't a primary hurtbox
for (var i = 0; i < instance_number(oPlayerHurtbox); i++;) {
	var hurtbox = instance_find(oPlayerHurtbox, i);
	
	if hurtbox.primary == false  && hurtbox.owner == id instance_destroy(hurtbox);
}
}