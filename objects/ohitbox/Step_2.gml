/// @description Insert description here
// You can write your code in this editor


visible = global.toggleHitboxVisibility;

if (attackProperty.AttackType == eAttackType.GRAB)
{
	sprite_index = sGrabBox;
}

if (lifetime < 1 && !isProjectile)
{
	instance_destroy();
}

if (spirit == noone)
{
	x = owner.x + attackProperty.WidthOffset * sign(owner.image_xscale);
	y = owner.y - attackProperty.HeightOffset * sign(owner.image_yscale);
}
else
{
	x = spirit.x + attackProperty.WidthOffset * sign(spirit.image_xscale);
	y = spirit.y - attackProperty.HeightOffset * sign(spirit.image_yscale);
}

// Handle non-projectiles
if (!isProjectile)
{
	if (!global.game_paused && owner.state != eState.HITSTOP)
	{
		lifetime--;
	}

	if (!owner.inAttackState)
	{
		instance_destroy();
	}

	// Prevent air moves from being lows
	if (!owner.grounded && attackProperty.AttackType == eAttackType.LOW)
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
			if (collision_list[| i].owner.x >= owner.x)
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
			var gotHitBy = ds_list_find_index(collision_list[| i].owner.hitByGroup, attackProperty.Group);
			var hasHitThis = ds_list_find_index(hasHit, collision_list[| i].owner.id); // Search the hasHit list for objects that this hitbox has hit
			
			if (collision_list[| i].owner != owner && hasHitThis == -1 && gotHitBy == -1 && !collision_list[| i].owner.invincible) 
			{
				//Set who the player is currently targeting
				owner.target = collision_list[| i].owner.id;

				// Throw Teching
				if (attackProperty.AttackType == eAttackType.GRAB && (collision_list[| i].owner.state == eState.GRAB || collision_list[| i].owner.state == eState.HOLD) && collision_list[| i].owner.animTimer <= 8)
				{
					owner.state = eState.THROW_TECH;
					owner.hsp = -2 * owner.image_xscale;
					owner.animTimer = 0;
					
					if (spirit != noone)
					{
						spirit.state = eState.THROW_TECH;
						spirit.hsp = -2 * owner.image_xscale;
						spirit.animTimer = 0;
					}

					collision_list[| i].owner.state = eState.THROW_TECH;
					collision_list[| i].owner.hsp = -2 * collision_list[| i].owner.image_xscale;
					collision_list[| i].owner.animTimer = 0;
					
					if (collision_list[| i].spirit != noone)
					{
						collision_list[| i].spirit.state = eState.THROW_TECH;
						collision_list[| i].spirit.hsp = -2 * collision_list[| i].spirit.image_xscale;
						collision_list[| i].spirit.animTimer = 0;
					}

					// Meter Build - Both players get some meter
					collision_list[| i].owner.superMeter += 5;
					owner.superMeter += 5;
				
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
					owner.state = eState.HOLD;
					owner.animTimer = 0;

					collision_list[| i].owner.state = eState.BEING_GRABBED;
					collision_list[| i].owner.sprite_index = collision_list[| i].owner.CharacterSprites.hurt_Sprite;
					collision_list[| i].owner.animTimer = 0;
					collision_list[| i].owner.x = owner.x + (attackProperty.HoldXOffset * owner.image_xscale);
					collision_list[| i].owner.isShortHopping = false; // Make sure the victim is not using their shorthop fall speed.
					owner.heldOpponent = collision_list[| i].owner;

					// Multiple hitboxes
					ds_list_add(hasHit, collision_list[| i].owner.id);
					ds_list_add(collision_list[| i].owner.hitByGroup, attackProperty.Group);

					// Depth Sorting
					owner.depth = -1;
					collision_list[| i].owner.depth = 0;

					// Reset Frame Advantage Counter
					oGameManager.frameAdvantage = 0;

					var particle = instance_create_layer(collision_list[| i].owner.x, collision_list[| i].owner.y, "Particles", oParticles);
					with(particle)
					{
						lifetime = 10;
						sprite_index = sHitEffect;
						image_xscale = other.owner.image_xscale * -1;
					}

				}
				else if (attackProperty.AttackType == eAttackType.COMMAND_GRAB && // Command Grabs
					collision_list[| i].owner.state != eState.THROW_TECH &&
					collision_list[| i].owner.blockstun < 1 &&
					collision_list[| i].owner.isThrowable)
				{
					// Set the correct states for the attacker and victim
					owner.prevState = eState.COMMAND_GRAB;
					owner.animTimer = 0;

					collision_list[| i].owner.prevState = eState.BEING_GRABBED;
					collision_list[| i].owner.sprite_index = collision_list[| i].owner.CharacterSprites.hurt_Sprite;
					collision_list[| i].owner.animTimer = 0;
					collision_list[| i].owner.x = owner.x + (attackProperty.HoldXOffset * owner.image_xscale);
					collision_list[| i].owner.isShortHopping = false; // Make sure the victim is not using their shorthop fall speed.
					owner.heldOpponent = collision_list[| i].owner;
					owner.target = collision_list[| i].owner;
				
					owner.hitstop = attackProperty.AttackHitStop;
					if (spirit != noone) spirit.hitstop = attackProperty.AttackHitStop;
					collision_list[| i].owner.hitstop = attackProperty.AttackHitStop;
				
					// Multiple hitboxes
					ds_list_add(hasHit, collision_list[| i].owner.id);
					ds_list_add(collision_list[| i].owner.hitByGroup, attackProperty.Group);

					// Depth Sorting
					owner.depth = -1;
					collision_list[| i].owner.depth = 0;

					// Reset Frame Advantage Counter
					oGameManager.frameAdvantage = 0;

					var particle = instance_create_layer(collision_list[| i].owner.x, collision_list[| i].owner.y, "Particles", oParticles);
					with(particle)
					{
						lifetime = 10;
						sprite_index = sHitEffect;
						image_xscale = other.owner.image_xscale * -1;
					}

					// Cancel into the command grab move
					ds_list_clear(owner.hitByGroup);
					if (spirit != noone)
					{
						ds_list_clear(spirit.hitByGroup);
					}
					if (owner.target != noone)
					{
						ds_list_clear(owner.target.hitByGroup);
					}
					owner.animOffset = 0;

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
					(((attackProperty.AttackType == eAttackType.LOW && (collision_list[| i].owner.verticalMoveDir == -1 || collision_list[| i].owner.toggleIdleBlock)) ||
						attackProperty.AttackType == eAttackType.MID ||
						(attackProperty.AttackType == eAttackType.HIGH && collision_list[| i].owner.verticalMoveDir != -1))) &&
					(collision_list[| i].owner.movedir == blockingDirection || collision_list[| i].owner.toggleIdleBlock)// Check if the opponent is holding back
				{
					collision_list[| i].owner.prevState = eState.BLOCKING;
					collision_list[| i].owner.state = eState.HITSTOP; // Set the player's state to hitstop

					owner.prevState = owner.state; // Set the owner's previous state
					owner.state = eState.HITSTOP;
					if (spirit != noone)
					{
						spirit.prevState = spirit.state; // Set the owner's previous state
						spirit.state = eState.HITSTOP;
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
					owner.superMeter += floor(attackProperty.MeterGain * 0.75);

					collision_list[| i].owner.knockbackVel = attackProperty.KnockBack;
					owner.pushbackVel = attackProperty.Pushback;
					collision_list[| i].owner.blockstun = attackProperty.BlockStun;
					collision_list[| i].owner.shuffle = 0;
					
					// Handle Hitstop
					owner.hitstop = attackProperty.AttackHitStop;
					if (spirit != noone) spirit.hitstop = attackProperty.AttackHitStop;
					collision_list[| i].owner.hitstop = attackProperty.AttackHitStop;
				
					// Allow Cancelling
					owner.cancelable = true;

					// Multiple hitboxes
					ds_list_add(hasHit, collision_list[| i].owner.id);
					ds_list_add(collision_list[| i].owner.hitByGroup, attackProperty.Group);

					// Depth Sorting
					owner.depth = -1;
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
				}
				//Hitting	
				else if (attackProperty.AttackType != eAttackType.GRAB && attackProperty.AttackType != eAttackType.COMMAND_GRAB)
				{
					if (collision_list[| i].owner.state != eState.BEING_GRABBED)
					{
						collision_list[| i].owner.sprite_index = collision_list[| i].owner.CharacterSprites.hurt_Sprite;
						if (collision_list[| i].spirit != noone) collision_list[| i].spirit.sprite_index = collision_list[| i].spirit.CharacterSprites.hurt_Sprite;
					}

					// Set the correct Sprite
					if (!collision_list[| i].owner.isDestructibleObject) // Check if the hurbox is attatched to a destructible object
					{
						collision_list[| i].owner.prevState = eState.HURT; // Set the victim's previous state to HURT
						collision_list[| i].owner.isShortHopping = false; // Make sure the victim is not using their shorthop fall speed.
					}

					collision_list[| i].owner.state = eState.HITSTOP;
					if (collision_list[| i].spirit != noone) collision_list[| i].spirit.state = eState.HITSTOP;

					// Properties on Counter Hit
					if (collision_list[| i].owner.inAttackState)
					{
						// Determine if we should display the coutner hit text on the p1 or p2 side
						var isP2 = (owner.playerID == 2);

						ProcessHit(counterHitProperty, collision_list[| i]);

						// Display counterhit text
						if (other.counterHitProperty.CounterHitLevel == 1)
						{
							var counterParticle = instance_create_layer((global.camObj.x - 80 + 23) + (111 * isP2), 61, "Particles", oParticles);
							with(counterParticle)
							{
								owner = other.owner;
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
								owner = other.owner;
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
								owner = other.owner;
								lifetime = owner.hitstop;
								sprite_index = sCOUNTERtext;
								depth = 2;
							}
						}

					}
					else
					{ // on Regular Hit
						ProcessHit(attackProperty, collision_list[| i]);
					}

					//Allow Cancelling
					owner.cancelable = true;
					if (spirit != noone) spirit.cancelable = true;

					// Depth Sorting
					owner.depth = -1;
					collision_list[| i].owner.depth = 0;

					// Apply proper knockback direction to Destructable Objects
					if (collision_list[| i].owner.isDestructibleObject)
					{
						collision_list[| i].owner.knockbackDirection = sign(image_xscale);
					}

					// Reset Frame Advantage Counter
					oGameManager.frameAdvantage = 0;
				}
			}
		}
	}
}
else
{
	if (!global.game_paused && owner.playerOwner.state != eState.HITSTOP)
	{
		lifetime--;
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
			// This code handles multiple hitboxes being used
			// It checks to see if the ID of this hitbox is contained within the hitByGroup list of the victim.
			// Whenever a hitbox connects, it adds its ID to the hitByGroup list to the victim
			var gotHitBy = ds_list_find_index(collision_list[| i].owner.hitByGroup, attackProperty.Group);
			var hasHitThis = ds_list_find_index(hasHit, collision_list[| i].owner.id); // Search the hasHit list for objects that this hitbox has hit 
			if (collision_list[| i].owner != owner.playerOwner && collision_list[| i].owner != owner.spiritOwner && hasHitThis == -1 && gotHitBy == -1 && !collision_list[| i].owner.invincible && !collision_list[| i].owner.projectileInvincible) 
			{
				// Calculate blocking direction
				if (collision_list[| i].owner.x >= owner.playerOwner.x)
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
				if (owner.playerOwner.spiritObject != noone)
				{
					collision_list[| i].owner.image_xscale = owner.playerOwner.spiritObject.image_xscale * -1;
				}

				//Set who the player is currently targeting
				owner.playerOwner.target = collision_list[| i].owner.id;

				// Projectiles cannot be grabs or throws, so the code for them is ommitted here

				// BLOCKING Check to see if we are blocking correctly
				if (collision_list[| i].owner.canBlock) &&
					((attackProperty.AttackType == eAttackType.LOW && collision_list[| i].owner.verticalMoveDir == -1)
						|| attackProperty.AttackType == eAttackType.MID ||
						(attackProperty.AttackType == eAttackType.HIGH && collision_list[| i].owner.verticalMoveDir != -1)) &&
					(collision_list[| i].owner.movedir == blockingDirection)
				{

					collision_list[| i].owner.prevState = eState.BLOCKING;
					collision_list[| i].owner.state = eState.HITSTOP; // Set the player's state to hitstop

					// Handle if the opponent is Crouch blocking or not
					if (collision_list[| i].owner.verticalMoveDir == -1)
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
					owner.playerOwner.superMeter += floor(attackProperty.MeterGain * 0.75);

					collision_list[| i].owner.knockbackVel = attackProperty.KnockBack;
					collision_list[| i].owner.blockstun = attackProperty.BlockStun;
					collision_list[| i].owner.shuffle = 0;
					
					owner.hitstop = attackProperty.AttackHitStop;
					if (spirit != noone) spirit.hitstop = attackProperty.AttackHitStop;
					collision_list[| i].owner.hitstop = attackProperty.AttackHitStop;
				
					// Multiple hitboxes
					ds_list_add(hasHit, collision_list[| i].owner.id);
					ds_list_add(collision_list[| i].owner.hitByGroup, attackProperty.Group);

					// Depth Sorting
					owner.depth = -1;
					collision_list[| i].owner.depth = 0;

					// Remove 1 health from the projectile
					owner.projectileHealth--;

					// Reset Frame Advantage Counter
					oGameManager.frameAdvantage = 0;

					var particle = instance_create_layer(collision_list[| i].owner.x, collision_list[| i].owner.y, "Particles", oParticles);
					with(particle)
					{
						lifetime = 10;
						sprite_index = sBlockEffect;
						image_xscale = collision_list[| i].owner.image_xscale;
					}
				}
				//Hitting	
				else if (attackProperty.AttackType != eAttackType.GRAB)
				{
					if (collision_list[| i].owner.state != eState.BEING_GRABBED)
					{
						collision_list[| i].owner.sprite_index = collision_list[| i].owner.CharacterSprites.hurt_Sprite;
					}

					// Set the correct Sprite
					if (!collision_list[| i].owner.isDestructibleObject) // Check if the hurbox is attatched to a destructible object
					{
						collision_list[| i].owner.prevState = eState.HURT; // Set the victim's previous state to HURT
						collision_list[| i].owner.isShortHopping = false; // Make sure the victim is not using their shorthop fall speed.
					}

					collision_list[| i].owner.state = eState.HITSTOP;

					// Properties on Counter Hit
					if (collision_list[| i].owner.inAttackState)
					{
						// Determine if we should display the coutner hit text on the p1 or p2 side
						var isP2 = (owner.playerOwner.playerID == 2);

						ProcessHit(counterHitProperty, collision_list[| i]);

						// Display counterhit text
						if (other.counterHitProperty.CounterHitLevel == 1)
						{
							var counterParticle = instance_create_layer((global.camObj.x - 80 + 23) + (111 * isP2), 61, "Particles", oParticles);
							with(counterParticle)
							{
								owner = other.owner;
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
								owner = other.owner;
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
								owner = other.owner;
								lifetime = owner.hitstop;
								sprite_index = sCOUNTERtext;
								depth = 2;
							}
						}

					}
					else
					{ // on Regular Hit
						ProcessHit(attackProperty, collision_list[| i]);
					}


					// Depth Sorting
					owner.depth = -1;
					collision_list[| i].owner.depth = 0;

					// Apply proper knockback direction to Destructable Objects
					if (collision_list[| i].owner.isDestructibleObject)
					{
						collision_list[| i].owner.knockbackDirection = sign(image_xscale);
					}

					// Reset Frame Advantage Counter
					oGameManager.frameAdvantage = 0;

					// Remove 1 health from the projectile
					owner.projectileHealth--;

					//Draw hit effect
					var particle = instance_create_layer(x + (attackProperty.ParticleXOffset * owner.image_xscale), y - attackProperty.ParticleYOffset, "Particles", oParticles);
					with(particle)
					{
						sprite_index = asset_get_index(other.attackProperty.ParticleEffect);
						image_xscale = sign(other.owner.image_xscale);
						lifetime = other.attackProperty.ParticleDuration;
					}
				}
			}
		}
	}
}