/// @description Insert description here
// You can write your code in this editor

/*
visible = global.toggleHitboxVisibility

if lifetime < 1 instance_destroy();

if !global.game_paused lifetime--;


var collisionCheck = place_meeting(x,y, oPlayerHurtbox);
var collisionID = noone;

if collisionCheck {
	
	
	// Creates a list containing all of the hurtboxes we're colliding with.
	var collision_list = ds_list_create();
	collisionID = instance_place_list(x,y, oPlayerHurtbox, collision_list, false);
	
	// If the hurtbox we're touching isn't our own AND that hitbox hasn't hit anything
	// Iterates over every hurtbox being collided with to check if it can be hit.
	for (var i = 0; i < collisionID; i++;) {
		if (collision_list[| i].owner != owner && !hasHit) {
			
			// BLOCKING                               Check to see if we are blocking correctly
			if collision_list[| i].owner.canBlock && ((attackProperty.attackType == eAttackType.LOW && collision_list[| i].owner.verticalMoveDir == -1) || attackProperty.attackType == eAttackType.MID){
					
				collision_list[| i].owner.prevState = eState.BLOCKING;
				collision_list[| i].owner.sprite_index = sRussel_Block;
				
				collision_list[| i].owner.knockbackVel = attackProperty.knockback;
				owner.pushbackVel = attackProperty.pushback;
				hasHit = true;
				collision_list[| i].owner.blockstun = attackProperty.blockstun;
				collision_list[| i].owner.shuffle = 0;
				global.hitstop = attackProperty.attackHitstop;
				
				// Allow Cancelling
				owner.cancelable = true;
				
				// Depth Sorting
				owner.depth = -1;
				collision_list[| i].owner.depth = 0;
				
				var particle = instance_create_layer(collision_list[| i].owner.x, collision_list[| i].owner.y, "Particles", oParticles);
				with particle {
					lifetime = 10;
					sprite_index = sBlockEffect;
					image_xscale = other.owner.image_xscale * -1;
				}
			}
		else {  // HITTING
				collision_list[| i].owner.prevState = eState.HURT; // Set the player's previous state to HURT
				collision_list[| i].owner.sprite_index = sRussel_Hurt; // Set the correct Sprite
				
				collision_list[| i].owner.hp -= attackProperty.damage;
				collision_list[| i].owner.knockbackVel = attackProperty.knockback;
				if collision_list[| i].owner.grounded == false {
					collision_list[| i].owner.vsp = attackProperty.airKnockbackV;
					collision_list[| i].owner.hsp = attackProperty.airKnockbackH * -collision_list[| i].owner.image_xscale;
				}
				else collision_list[| i].owner.vsp = 0;
				owner.pushbackVel = attackProperty.pushback;
				
				hasHit = true;
				collision_list[| i].owner.hitstun = attackProperty.attackHitstun;
				global.hitstop = attackProperty.attackHitstop;
				
				//Allow Cancelling
				owner.cancelable = true;
				
				// Depth Sorting
				owner.depth = -1;
				collision_list[| i].owner.depth = 0;

				
					//Draw hit effect
				var particle = instance_create_layer(x + (attackProperty.particlexOffset * owner.image_xscale), y - attackProperty.particleyOffset, "Particles", oParticles);
				with particle lifetime = 10;
			}
		}
	}
}