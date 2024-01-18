// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// ownerType is used to differentiate between projectiles and non-projectiles

function HandleHitboxCollision(ownerType)
{
	if (!global.game_paused && ownerType.state != eState.HITSTOP && !isProjectile)
	{
		lifetime--;
	}

	if (!ownerType.inAttackState && !isProjectile)
	{
		instance_destroy();
	}

	// Prevent air moves from being lows
	if (!ownerType.grounded && attackProperty.AttackType == eAttackType.LOW)
	{
		attackProperty.AttackType = eAttackType.MID;
	}

	var collisionCheck = place_meeting(x, y, oPlayerHurtbox);
	var collisionID = noone;

	if (collisionCheck)
	{
		// Creates a list containing all of the hurtboxes we're colliding with.
		var collision_list = ds_list_create();
		collisionID = instance_place_list(x, y, oPlayerHurtbox, collision_list, false);

		// If the hurtbox we're touching isn't our own AND that hitbox hasn't hit anything
		// Iterates over every hurtbox being collided with to check if it can be hit.
		for (var i = 0; i < collisionID; i++;)
		{
			// Calculate blocking direction
			if (collision_list[| i].owner.x >= ownerType.x)
			{
				// Owner is on the left side
				var ownerOnSide = -1;
			}
			else
			{
				// Owner is on right side
				var ownerOnSide = 1;
			}

			var blockingDirection = -ownerOnSide;

			// Turns the target around if the spirit is attacking from behind
			if (collision_list[| i].owner != owner && spirit != noone)
			{
				collision_list[| i].owner.image_xscale = spirit.image_xscale * -1;
			}

			// This code handles multiple hitboxes being used
			// It checks to see if the ID of this hitbox is contained within the hitByGroup list of the victim.
			// Whenever a hitbox connects, it adds its ID to the hitByGroup list to the victim
			var gotHitBy = ds_list_find_index(collision_list[| i].owner.hitByGroup, attackProperty.Group); // Checks if the group value has already hit the target
			var hasHitThis = ds_list_find_index(hasHit, collision_list[| i].owner.id); // Search the hasHit list for objects that this hitbox has hit
			
			// Multiple projectiles may be hitting the same target.
			// If this is the case, we want to ignore gotHitBy, since otherwise only one of the projectiles 
			// could hit at a time if they share the same group value.
			// This code will check if this projectile has already hit before, and if not, ignore group IDs
			if (isProjectile)
			{
				var hasThisProjectileAlreadyHitTarget = ds_list_find_index(collision_list[| i].owner.projectileHitByGroup, id);
				
				// If this projectile has not hit, ignore group IDs
				if (hasThisProjectileAlreadyHitTarget == -1)
				{
					gotHitBy = -1;
				}
			}
			else
			{
				var hasThisProjectileAlreadyHitTarget = -1;
			}
			
			if (collision_list[| i].owner != ownerType && hasHitThis == -1 && gotHitBy == -1 && hasThisProjectileAlreadyHitTarget == -1 && !collision_list[| i].owner.invincible) 
			{
				//Set who the player is currently targeting
				ownerType.target = collision_list[| i].owner.id;

				// Throw Teching
				if (attackProperty.AttackType == eAttackType.GRAB && (collision_list[| i].owner.state == eState.GRAB || collision_list[| i].owner.state == eState.HOLD) && collision_list[| i].owner.animTimer <= 8)
				{
					// Put both players in a throw tech state
					ownerType.state = eState.THROW_TECH;
					ownerType.hsp = -5 * ownerType.image_xscale;
					ownerType.animTimer = 0;
					
					if (spirit != noone)
					{
						spirit.state = eState.THROW_TECH;
						spirit.hsp = -5 * ownerType.image_xscale;
						spirit.animTimer = 0;
					}

					collision_list[| i].owner.state = eState.THROW_TECH;
					collision_list[| i].owner.hsp = -5 * collision_list[| i].owner.image_xscale;
					collision_list[| i].owner.animTimer = 0;
					
					if (collision_list[| i].spirit != noone)
					{
						collision_list[| i].spirit.state = eState.THROW_TECH;
						collision_list[| i].spirit.hsp = -5 * collision_list[| i].spirit.image_xscale;
						collision_list[| i].spirit.animTimer = 0;
					}

					// Meter Build - Both players get some meter
					collision_list[| i].owner.superMeter += 5;
					ownerType.superMeter += 5;
					
					// Draw tech effect
					var particle = instance_create_layer((owner.x + collision_list[| i].owner.x) / 2, owner.y - 16, "Particles", oParticles);
					with(particle)
					{
						lifetime = 30;
						sprite_index = sThrowTechEffect;
						image_xscale = 1;
					}
					
					ds_list_add(hasHit, collision_list[| i].owner.id);
				} 
				else if (attackProperty.AttackType == eAttackType.GRAB && // Grabbing
					collision_list[| i].owner.hitstun < 1 &&
					collision_list[| i].owner.blockstun < 1 &&
					collision_list[| i].owner.grounded &&
					collision_list[| i].owner.state != eState.THROW_TECH &&
					collision_list[| i].owner.state != eState.JUMPSQUAT &&
					collision_list[| i].owner.isThrowable)
				{
					// Set the correct states for the attacker and victim
					ownerType.state = eState.HOLD;
					ownerType.animTimer = 0;

					collision_list[| i].owner.state = eState.BEING_GRABBED;
					collision_list[| i].owner.sprite_index = collision_list[| i].owner.CharacterSprites.hurt_Sprite;
					collision_list[| i].owner.animTimer = 0;
					collision_list[| i].owner.x = ownerType.x + (attackProperty.HoldXOffset * ownerType.image_xscale);
					collision_list[| i].owner.isShortHopping = false; // Make sure the victim is not using their shorthop fall speed.
					ownerType.heldOpponent = collision_list[| i].owner;

					// Multiple hitboxes
					ds_list_add(hasHit, collision_list[| i].owner.id);
					ds_list_add(collision_list[| i].owner.hitByGroup, attackProperty.Group);

					// Depth Sorting
					ownerType.depth = -1;
					collision_list[| i].owner.depth = 0;

					// Reset Frame Advantage Counter
					oGameManager.frameAdvantage = 0;
					
					// Draw grab effect
					var particle = instance_create_layer(x + (attackProperty.ParticleXOffset * ownerType.image_xscale), y - attackProperty.ParticleYOffset, "Particles", oParticles);
					with(particle)
					{
						lifetime = other.attackProperty.ParticleDuration;
						sprite_index = asset_get_index(other.attackProperty.ParticleEffect);
						image_xscale = ownerType.image_xscale * -1;
					}

				}
				else if (attackProperty.AttackType == eAttackType.COMMAND_GRAB && // Command Grabs
					collision_list[| i].owner.state != eState.THROW_TECH &&
					collision_list[| i].owner.blockstun < 1 &&
					collision_list[| i].owner.isThrowable)
				{
					// Set the correct states for the attacker and victim
					ownerType.prevState = eState.COMMAND_GRAB;
					ownerType.animTimer = 0;

					collision_list[| i].owner.prevState = eState.BEING_GRABBED;
					collision_list[| i].owner.sprite_index = collision_list[| i].owner.CharacterSprites.hurt_Sprite;
					collision_list[| i].owner.animTimer = 0;
					collision_list[| i].owner.x = ownerType.x + (attackProperty.HoldXOffset * ownerType.image_xscale);
					collision_list[| i].owner.isShortHopping = false; // Make sure the victim is not using their shorthop fall speed.
					ownerType.heldOpponent = collision_list[| i].owner;
					ownerType.target = collision_list[| i].owner;
				
					ownerType.hitstop = attackProperty.AttackHitStop;
					if (spirit != noone) 
					{
						spirit.hitstop = attackProperty.AttackHitStop;
					}
					collision_list[| i].owner.hitstop = attackProperty.AttackHitStop;
				
					// Multiple hitboxes
					ds_list_add(hasHit, collision_list[| i].owner.id);
					ds_list_add(collision_list[| i].owner.hitByGroup, attackProperty.Group);

					// Depth Sorting
					ownerType.depth = -1;
					collision_list[| i].owner.depth = 0;

					// Reset Frame Advantage Counter
					oGameManager.frameAdvantage = 0;

					// Draw grab effect
					var particle = instance_create_layer(x + (attackProperty.ParticleXOffset * ownerType.image_xscale), y - attackProperty.ParticleYOffset, "Particles", oParticles);
					with(particle)
					{
						lifetime = other.attackProperty.ParticleDuration;
						sprite_index = asset_get_index(other.attackProperty.ParticleEffect);
						image_xscale = ownerType.image_xscale * -1;
					}

					// Cancel into the command grab move
					ds_list_clear(ownerType.hitByGroup);
					if (spirit != noone)
					{
						ds_list_clear(spirit.hitByGroup);
					}
					if (ownerType.target != noone)
					{
						ds_list_clear(ownerType.target.hitByGroup);
					}
					ownerType.animOffset = 0;

					// Iterates through every hurtbox in the scene and destroys each one that isn't a primary hurtbox
					for (var i = 0; i < instance_number(oPlayerHurtbox); i++;)
					{
						var hurtbox = instance_find(oPlayerHurtbox, i);

						if (!hurtbox.primary && hurtbox.owner == id)
						{
							instance_destroy(hurtbox);
						}
					}

					instance_destroy(oHitbox);

				}
				else if (collision_list[| i].owner.canBlock) && // Blocking
					(collision_list[| i].owner.isAbleToBlock) &&
					(((attackProperty.AttackType == eAttackType.LOW && (collision_list[| i].owner.verticalMoveDir == -1 || collision_list[| i].owner.toggleIdleBlock)) ||
						attackProperty.AttackType == eAttackType.MID ||
						(attackProperty.AttackType == eAttackType.HIGH && collision_list[| i].owner.verticalMoveDir != -1))) &&
					(collision_list[| i].owner.movedir == blockingDirection || collision_list[| i].owner.toggleIdleBlock)// Check if the opponent is holding back
				{
					collision_list[| i].owner.prevState = eState.BLOCKING;
					collision_list[| i].owner.state = eState.HITSTOP; // Set the player's state to hitstop
					
					if (spirit != noone)
					{
						spirit.prevState = spirit.state; // Set the owner's previous state
						spirit.state = eState.HITSTOP;
					}
					
					// Face opponent towards the source of damage;
					if (!collision_list[| i].owner.isDestructibleObject)
					{
						collision_list[| i].owner.image_xscale = ownerOnSide;
					}

					// Handle if the opponent is Crouch blocking or not
					if (collision_list[| i].owner.verticalMoveDir == -1 || attackProperty.AttackType == eAttackType.LOW)
					{
						collision_list[| i].owner.sprite_index = sRussel_Crouch_Block;
						collision_list[| i].owner.isCrouchBlocking = true;
					}
					else
					{
						collision_list[| i].owner.sprite_index = sRussel_Block;
						collision_list[| i].owner.isCrouchBlocking = false;
					}

					// Meter Build - P1 gets 75% meter, P2 gets 50%
					collision_list[| i].owner.superMeter += floor(attackProperty.MeterGain * 0.5);
					if (ownerType.state != eState.SUPER && !ownerType.installActivated && !ownerType.timeStopActivated)
					{
						ownerType.superMeter += floor(attackProperty.MeterGain * 0.75);
					}

					collision_list[| i].owner.knockbackVel = attackProperty.KnockBack;
					
					collision_list[| i].owner.blockstun = attackProperty.BlockStun;
					collision_list[| i].owner.shuffle = 0;
					
					// Handle Hitstop
					if (spirit != noone) 
					{
						spirit.hitstop = attackProperty.AttackHitStop;
					}
					collision_list[| i].owner.hitstop = attackProperty.AttackHitStop;
					
					// If this is not a projectile...
					if (!isProjectile)
					{
						ownerType.prevState = ownerType.state; // Set the owner's previous state
						ownerType.state = eState.HITSTOP;
						
						// Apply pushback
						ownerType.pushbackVel = attackProperty.Pushback;
						
						// Apply hitstop
						ownerType.hitstop = attackProperty.AttackHitStop;
						
						// Allow Cancelling
						ownerType.cancelable = true;
					}
					
					// Multiple hitboxes
					ds_list_add(hasHit, collision_list[| i].owner.id);
					ds_list_add(collision_list[| i].owner.hitByGroup, attackProperty.Group);
					// If this is a projectile, add its ID to the target's projectileHitBy list
					if (isProjectile)
					{
						ds_list_add(collision_list[| i].owner.projectileHitByGroup, id);
					}

					// Depth Sorting
					ownerType.depth = -1;
					collision_list[| i].owner.depth = 0;

					// Reset Frame Advantage Counter
					oGameManager.frameAdvantage = 0;

					var particle = instance_create_layer(collision_list[| i].owner.x, collision_list[| i].owner.y, "Particles", oParticles);
					with(particle)
					{
						lifetime = 10;
						sprite_index = sBlockEffect;
						image_xscale = collision_list[| i].owner.image_xscale;
					}

					//Play sound effect
					audio_play_sound(sfx_blocking, 1, false);
					
					
					// Handle Destroying Projectile
					if (isProjectile)
					{
						instance_destroy();
						instance_destroy(owner);
					}
				}
				//Hitting	
				else if (attackProperty.AttackType != eAttackType.GRAB && attackProperty.AttackType != eAttackType.COMMAND_GRAB)
				{
					// Set the opponent's sprite to their hurt sprite (unless being grabbed)
					if (collision_list[| i].owner.state != eState.BEING_GRABBED)
					{
						collision_list[| i].owner.sprite_index = collision_list[| i].owner.CharacterSprites.hurt_Sprite;
						if (collision_list[| i].spirit != noone) collision_list[| i].spirit.sprite_index = collision_list[| i].spirit.CharacterSprites.hurt_Sprite;
					}
					
					// Face opponent towards the source of damage;
					if (!collision_list[| i].owner.isDestructibleObject && collision_list[| i].owner.state != eState.BEING_GRABBED)
					{
						collision_list[| i].owner.image_xscale = ownerOnSide;
					}
					
					// Set the correct prevState
					if (!collision_list[| i].owner.isDestructibleObject) // Check if the hurbox is attatched to a destructible object
					{
						collision_list[| i].owner.prevState = eState.HURT; // Set the victim's previous state to HURT
						collision_list[| i].owner.isShortHopping = false; // Make sure the victim is not using their shorthop fall speed.
					}
					
					// Set opponent's correct state
					collision_list[| i].owner.state = eState.HITSTOP;
					if (collision_list[| i].spirit != noone) 
					{
						collision_list[| i].spirit.state = eState.HITSTOP;
					}

					
					
					// Properties on Counter Hit
					if (collision_list[| i].owner.inAttackState)
					{
						// Determine if we should display the coutner hit text on the p1 or p2 side
						var isP2 = (ownerType.playerID == 2);

						if (!isProjectile)
						{
							ProcessHit(counterHitProperty, collision_list[| i], finalBlowSuper, attackProperty.ActivateTimeStop);
						}
						else
						{
							ProcessHit(counterHitProperty, collision_list[| i], finalBlowSuper);
						}

						// Display counterhit text
						if (other.counterHitProperty.CounterHitLevel == 1)
						{
							var counterParticle = instance_create_layer((global.camObj.x - 80 + 23) + (111 * isP2), 61, "Particles", oParticles);
							with(counterParticle)
							{
								owner = ownerType;
								lifetime = owner.hitstop;
								sprite_index = sSmallCounter;
								depth = 2;
							}
						}
						else if (other.counterHitProperty.CounterHitLevel == 2)
						{
							var counterParticle = instance_create_layer((global.camObj.x - 80 + 30) + (97 * isP2), 70, "Particles", oParticles);
							with(counterParticle)
							{
								owner = ownerType;
								lifetime = owner.hitstop;
								sprite_index = sMediumCounter;
								depth = 2;
							}
						}
						else if (other.counterHitProperty.CounterHitLevel == 3)
						{
							var counterParticle = instance_create_layer(global.camObj.x - 80, 0, "Particles", oParticles);
							with(counterParticle)
							{
								owner = ownerType;
								lifetime = owner.hitstop;
								sprite_index = sCOUNTERtext;
								depth = 2;
							}
						}

					}
					else
					{ // on Regular Hit
						if (!isProjectile)
						{
							ProcessHit(attackProperty, collision_list[| i], finalBlowSuper, attackProperty.ActivateTimeStop);
						}
						else
						{
							ProcessHit(attackProperty, collision_list[| i], finalBlowSuper);
						}
						
					}

					//Allow Cancelling
					ownerType.cancelable = true;
					if (spirit != noone) spirit.cancelable = true;

					// Depth Sorting
					ownerType.depth = -1;
					collision_list[| i].owner.depth = 0;

					// Apply proper knockback direction to Destructable Objects
					if (collision_list[| i].owner.isDestructibleObject)
					{
						collision_list[| i].owner.knockbackDirection = sign(image_xscale);
					}

					// Reset Frame Advantage Counter
					oGameManager.frameAdvantage = 0;
					
					// Handle Destroying Projectile
					if (isProjectile)
					{
						instance_destroy();
						instance_destroy(owner);
					}
				}
			}
		}
		
		ds_list_destroy(collision_list);
	}
}