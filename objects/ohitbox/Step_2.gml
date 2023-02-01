/// @description Insert description here
// You can write your code in this editor


visible = global.toggleHitboxVisibility;

if attackProperty.attackType[hitboxID] == eAttackType.GRAB sprite_index = sGrabBox;

if lifetime < 1 instance_destroy();

if !global.game_paused lifetime--;

x = owner.x + attackProperty.widthOffset[hitboxID] * sign(owner.image_xscale);
y = owner.y - attackProperty.heightOfset[hitboxID] * sign(owner.image_yscale);

if owner.inAttackState == false {
	instance_destroy();
}

var collisionCheck = place_meeting(x,y, oPlayerHurtbox);
var collisionID = noone;

if collisionCheck {
	// Creates a list containing all of the hurtboxes we're colliding with.
	var collision_list = ds_list_create();
	collisionID = instance_place_list(x,y, oPlayerHurtbox, collision_list, false);
	
	// If the hurtbox we're touching isn't our own AND that hitbox hasn't hit anything
	// Iterates over every hurtbox being collided with to check if it can be hit.
	for (var i = 0; i < collisionID; i++;) {
		
		// This code handles multiple hitboxes being used
		// It checks to see if the ID of this hitbox is contained within the hitByGroup list of the victim.
		// Whenever a hitbox connects, it adds its ID to the hitByGroup list to the victim
		var gotHitBy = ds_list_find_index(collision_list[| i].owner.hitByGroup, attackProperty.group[hitboxID])
		if (collision_list[| i].owner != owner && !hasHit && gotHitBy == -1 && !collision_list[| i].owner.invincible) {
			// Throw Teching
			if attackProperty.attackType[hitboxID] == eAttackType.GRAB && (collision_list[| i].owner.state == eState.GRAB || collision_list[| i].owner.state == eState.HOLD) && collision_list[| i].owner.animTimer <= 8 {
				owner.state = eState.THROW_TECH;
				owner.hsp = -2 * owner.image_xscale;
				owner.animTimer = 0;
				
				collision_list[| i].owner.state = eState.THROW_TECH;
				collision_list[| i].owner.hsp = -2 * collision_list[| i].owner.image_xscale;
				collision_list[| i].owner.animTimer = 0;
				
				// Meter Build - Both players get some meter
				collision_list[| i].owner.superMeter += 5;
				owner.superMeter += 5;
				
				hasHit = true;
			} else
			// Grabbing
			if attackProperty.attackType[hitboxID] == eAttackType.GRAB && collision_list[| i].owner.hitstun < 1 && collision_list[| i].owner.blockstun < 1 && collision_list[| i].owner.grounded == true && collision_list[| i].owner.state != eState.THROW_TECH && collision_list[| i].owner.state != eState.JUMPSQUAT{
				// Set the correct states for the attacker and victim
				owner.state = eState.HOLD;
				owner.animTimer = 0;
				
				collision_list[| i].owner.state = eState.BEING_GRABBED;
				collision_list[| i].owner.sprite_index = collision_list[| i].owner.CharacterSprites.hurt_Sprite;
				collision_list[| i].owner.animTimer = 0;
				collision_list[| i].owner.x = owner.x + (attackProperty.holdXOffset[hitboxID] * owner.image_xscale);
				collision_list[| i].owner.isShortHopping = false; // Make sure the victim is not using their shorthop fall speed.
				owner.heldOpponent = collision_list[| i].owner;
				
				// Multiple hitboxes
				hasHit = true;
				ds_list_add(collision_list[| i].owner.hitByGroup, attackProperty.group[hitboxID]);
				
				// Depth Sorting
				owner.depth = -1;
				collision_list[| i].owner.depth = 0;
				
				// Reset Frame Advantage Counter
				oGameManager.frameAdvantage = 0;
				
				var particle = instance_create_layer(collision_list[| i].owner.x, collision_list[| i].owner.y, "Particles", oParticles);
				with particle {
					lifetime = 10;
					sprite_index = sHitEffect;
					image_xscale = other.owner.image_xscale * -1;
				}
				
			} else 
			// BLOCKING                                  Check to see if we are blocking correctly
			if (collision_list[| i].owner.canBlock) && ((attackProperty.attackType[hitboxID] == eAttackType.LOW && collision_list[| i].owner.verticalMoveDir == -1) || attackProperty.attackType[hitboxID] == eAttackType.MID || (attackProperty.attackType[hitboxID] == eAttackType.HIGH && collision_list[| i].owner.verticalMoveDir != -1)){
					
				collision_list[| i].owner.prevState = eState.BLOCKING;
				collision_list[| i].owner.state = eState.HITSTOP; // Set the player's state to hitstop
				
				owner.prevState = owner.state; // Set the owner's previous state
				owner.state = eState.HITSTOP;
				
				// Handle if the opponent is Crouch blocking or not
				if collision_list[| i].owner.verticalMoveDir == -1 {
					collision_list[| i].owner.sprite_index = sRussel_Crouch_Block;
					collision_list[| i].owner.isCrouchBlocking = true;
				}
				else {
					collision_list[| i].owner.sprite_index = sRussel_Block;
					collision_list[| i].owner.isCrouchBlocking = false;
				}
				
				// Meter Build - P1 gets 75% meter, P2 gets 50%
				collision_list[| i].owner.superMeter += floor(attackProperty.meterGain[hitboxID] * 0.5);
				owner.superMeter += floor(attackProperty.meterGain[hitboxID] * 0.75);
				
				collision_list[| i].owner.knockbackVel = attackProperty.knockback[hitboxID];
				owner.pushbackVel = attackProperty.pushback[hitboxID];
				hasHit = true;
				collision_list[| i].owner.blockstun = attackProperty.blockstun[hitboxID];
				collision_list[| i].owner.shuffle = 0;
				global.hitstop = attackProperty.attackHitstop[hitboxID];
				
				// Allow Cancelling
				owner.cancelable = true;
				
				// Multiple hitboxes
				ds_list_add(collision_list[| i].owner.hitByGroup, attackProperty.group[hitboxID]);
				
				// Depth Sorting
				owner.depth = -1;
				collision_list[| i].owner.depth = 0;
				
				// Reset Frame Advantage Counter
				oGameManager.frameAdvantage = 0;
				
				var particle = instance_create_layer(collision_list[| i].owner.x, collision_list[| i].owner.y, "Particles", oParticles);
				with particle {
					lifetime = 10;
					sprite_index = sBlockEffect;
					image_xscale = collision_list[| i].owner.image_xscale;
				}
			}
			//Hitting	
		else if attackProperty.attackType[hitboxID] != eAttackType.GRAB { 
				if (collision_list[| i].owner.state != eState.BEING_GRABBED) collision_list[| i].owner.sprite_index = collision_list[| i].owner.CharacterSprites.hurt_Sprite; // Set the correct Sprite
				collision_list[| i].owner.prevState = eState.HURT; // Set the victim's previous state to HURT
				collision_list[| i].owner.state = eState.HITSTOP; // Set the victim's state to hitstop
				collision_list[| i].owner.isShortHopping = false; // Make sure the victim is not using their shorthop fall speed.
				
				// Combo Scaling
				owner.combo++;
				if owner.combo == 2 owner.startCombo = true;
				var damageScaling = 
				
				collision_list[| i].owner.hp -= attackProperty.damage[hitboxID];
				collision_list[| i].owner.knockbackVel = attackProperty.knockback[hitboxID];
				
				// Meter Build - P1 gets 100% meter, P2 gets 25%
				collision_list[| i].owner.superMeter += floor(attackProperty.meterGain[hitboxID] * 0.25);
				owner.superMeter += floor(attackProperty.meterGain[hitboxID]);
				
				if collision_list[| i].owner.grounded == false {
					collision_list[| i].owner.vsp = attackProperty.airKnockbackV[hitboxID];
					collision_list[| i].owner.hsp = attackProperty.airKnockbackH[hitboxID] * owner.image_xscale;
				}
				else if attackProperty.launches[hitboxID] {
					collision_list[| i].owner.vsp = attackProperty.LaunchKnockbackV[hitboxID];
					collision_list[| i].owner.hsp = attackProperty.LaunchKnockbackH[hitboxID] * owner.image_xscale;
					collision_list[| i].owner.grounded = false;
				}
				else collision_list[| i].owner.vsp = 0;
				owner.pushbackVel = attackProperty.pushback[hitboxID];
				owner.heldOpponent = noone;
				
				hasHit = true;
				collision_list[| i].owner.hitstun = attackProperty.attackHitstun[hitboxID];
				ds_list_add(collision_list[| i].owner.hitByGroup, attackProperty.group[hitboxID]);
				global.hitstop = attackProperty.attackHitstop[hitboxID];
				
				//Allow Cancelling
				owner.cancelable = true;
				
				// Depth Sorting
				owner.depth = -1;
				collision_list[| i].owner.depth = 0;
				
				

				// Reset Frame Advantage Counter
				oGameManager.frameAdvantage = 0;
				
					//Draw hit effect
				var particle = instance_create_layer(x + (attackProperty.particlexOffset[hitboxID] * owner.image_xscale), y - attackProperty.particleyOffset[hitboxID], "Particles", oParticles);
				with particle {
					sprite_index = other.attackProperty.particleEffect[other.hitboxID];
					image_xscale = sign(other.owner.image_xscale);
					lifetime = other.attackProperty.particleDuration[other.hitboxID];
				}
			}
		}
	}
}