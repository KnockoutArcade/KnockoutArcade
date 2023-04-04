/// @description Insert description here
// You can write your code in this editor


visible = global.toggleHitboxVisibility;

if (attackProperty.attackType[hitboxID] == eAttackType.GRAB)
{
	sprite_index = sGrabBox;
}

if (lifetime < 1 && !isProjectile)
{
	instance_destroy();
}

if (!global.game_paused) 
{
	lifetime--;
}

x = owner.x + attackProperty.widthOffset[hitboxID] * sign(owner.image_xscale);
y = owner.y - attackProperty.heightOfset[hitboxID] * sign(owner.image_yscale);

// Handle non-projectiles
if (!isProjectile)
{
	if (!owner.inAttackState)
	{
		instance_destroy();
	}

	var collisionCheck = place_meeting(x,y, oPlayerHurtbox);
	var collisionID = noone;

	if (collisionCheck)
	{
		// Creates a list containing all of the hurtboxes we're colliding with.
		var collision_list = ds_list_create();
		collisionID = instance_place_list(x,y, oPlayerHurtbox, collision_list, false);
	
		// If the hurtbox we're touching isn't our own AND that hitbox hasn't hit anything
		// Iterates over every hurtbox being collided with to check if it can be hit.
		for (var i = 0; i < collisionID; i++;) 
		{
		
			// This code handles multiple hitboxes being used
			// It checks to see if the ID of this hitbox is contained within the hitByGroup list of the victim.
			// Whenever a hitbox connects, it adds its ID to the hitByGroup list to the victim
			var gotHitBy = ds_list_find_index(collision_list[| i].owner.hitByGroup, attackProperty.group[hitboxID])
			if (collision_list[| i].owner != owner && !hasHit && gotHitBy == -1 && !collision_list[| i].owner.invincible) 
			{
				//Set who the player is currently targeting
				owner.target = collision_list[| i].owner.id;
			
				// Throw Teching
				if (attackProperty.attackType[hitboxID] == eAttackType.GRAB && (collision_list[| i].owner.state == eState.GRAB || collision_list[| i].owner.state == eState.HOLD) && collision_list[| i].owner.animTimer <= 8)
				{
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
				} 
				else if (attackProperty.attackType[hitboxID] == eAttackType.GRAB && // Grabbing
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
					with (particle) 
					{
						lifetime = 10;
						sprite_index = sHitEffect;
						image_xscale = other.owner.image_xscale * -1;
					}
				
				} 
				else if (attackProperty.attackType[hitboxID] == eAttackType.COMMAND_GRAB && // Command Grabs
						collision_list[| i].owner.state != eState.THROW_TECH &&
						collision_list[| i].owner.blockstun < 1 &&
						collision_list[| i].owner.isThrowable)
				{
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
					with (particle) 
					{
						lifetime = 10;
						sprite_index = sHitEffect;
						image_xscale = other.owner.image_xscale * -1;
					}
				}
				else if (collision_list[| i].owner.canBlock && // Blocking
					((attackProperty.attackType[hitboxID] == eAttackType.LOW && collision_list[| i].owner.verticalMoveDir == -1) || 
					attackProperty.attackType[hitboxID] == eAttackType.MID || 
					(attackProperty.attackType[hitboxID] == eAttackType.HIGH && collision_list[| i].owner.verticalMoveDir != -1)))
				{
					// Check to see if we are blocking correctly
					collision_list[| i].owner.prevState = eState.BLOCKING;
					collision_list[| i].owner.state = eState.HITSTOP; // Set the player's state to hitstop
				
					owner.prevState = owner.state; // Set the owner's previous state
					owner.state = eState.HITSTOP;
				
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
					with (particle) 
					{
						lifetime = 10;
						sprite_index = sBlockEffect;
						image_xscale = collision_list[| i].owner.image_xscale;
					}
				}
				//Hitting	
				else if (attackProperty.attackType[hitboxID] != eAttackType.GRAB && attackProperty.attackType[hitboxID] != eAttackType.COMMAND_GRAB) 
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
						var isP2 = (owner.playerID == 2);
					
						ProcessHit(counterHitProperty, collision_list[| i]);
					
						// Display counterhit text
						if (other.counterHitProperty.counterHitLevel[hitboxID] == 1)
						{
							var counterParticle = instance_create_layer((global.camObj.x - 80 + 23) + (111* isP2), 61, "Particles", oParticles);
							with (counterParticle) 
							{
								lifetime = global.hitstop;
								sprite_index = sSmallCounter;
								depth = 2;
							}
						}
						else if (other.counterHitProperty.counterHitLevel[hitboxID] == 2)
						{
							var counterParticle = instance_create_layer((global.camObj.x - 80 + 30) + (97 * isP2), 70, "Particles", oParticles);
							with (counterParticle) 
							{
								lifetime = global.hitstop;
								sprite_index = sMediumCounter;
								depth = 2;
							}
						} 
						else if (other.counterHitProperty.counterHitLevel[hitboxID] == 3)
						{
							var counterParticle = instance_create_layer(global.camObj.x - 80, 0, "Particles", oParticles);
							with (counterParticle) 
							{
								lifetime = global.hitstop;
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
				
						//Draw hit effect
					var particle = instance_create_layer(x + (attackProperty.particlexOffset[hitboxID] * owner.image_xscale), y - attackProperty.particleyOffset[hitboxID], "Particles", oParticles);
					with (particle) 
					{
						sprite_index = other.attackProperty.particleEffect[other.hitboxID];
						image_xscale = sign(other.owner.image_xscale);
						lifetime = other.attackProperty.particleDuration[other.hitboxID];
					}
				}
			}
		}
	}
}
else
{
	var collisionCheck = place_meeting(x,y, oPlayerHurtbox);
	var collisionID = noone;

	if (collisionCheck)
	{
		// Creates a list containing all of the hurtboxes we're colliding with.
		var collision_list = ds_list_create();
		collisionID = instance_place_list(x,y, oPlayerHurtbox, collision_list, false);
	
		// If the hurtbox we're touching isn't our own AND that hitbox hasn't hit anything
		// Iterates over every hurtbox being collided with to check if it can be hit.
		for (var i = 0; i < collisionID; i++;) 
		{
		
			// This code handles multiple hitboxes being used
			// It checks to see if the ID of this hitbox is contained within the hitByGroup list of the victim.
			// Whenever a hitbox connects, it adds its ID to the hitByGroup list to the victim
			var gotHitBy = ds_list_find_index(collision_list[| i].owner.hitByGroup, attackProperty.group[hitboxID])
			if (collision_list[| i].owner != owner.playerOwner && !hasHit && gotHitBy == -1 && !collision_list[| i].owner.invincible) 
			{
				//Set who the player is currently targeting
				owner.playerOwner.target = collision_list[| i].owner.id;
			
				// Projectiles cannot be grabs or throws, so the code for them is ommitted here

				// BLOCKING Check to see if we are blocking correctly
				if (collision_list[| i].owner.canBlock) && 
					((attackProperty.attackType[hitboxID] == eAttackType.LOW && collision_list[| i].owner.verticalMoveDir == -1) 
					|| attackProperty.attackType[hitboxID] == eAttackType.MID || 
					(attackProperty.attackType[hitboxID] == eAttackType.HIGH && collision_list[| i].owner.verticalMoveDir != -1))
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
					collision_list[| i].owner.superMeter += floor(attackProperty.meterGain[hitboxID] * 0.5);
					owner.playerOwner.superMeter += floor(attackProperty.meterGain[hitboxID] * 0.75);
				
					collision_list[| i].owner.knockbackVel = attackProperty.knockback[hitboxID];
					owner.playerOwner.pushbackVel = attackProperty.pushback[hitboxID];
					hasHit = true;
					collision_list[| i].owner.blockstun = attackProperty.blockstun[hitboxID];
					collision_list[| i].owner.shuffle = 0;
					global.hitstop = attackProperty.attackHitstop[hitboxID];
				
					// Multiple hitboxes
					ds_list_add(collision_list[| i].owner.hitByGroup, attackProperty.group[hitboxID]);
				
					// Depth Sorting
					owner.depth = -1;
					collision_list[| i].owner.depth = 0;
					
					// Remove 1 health from the projectile
					owner.projectileHealth--;
				
					// Reset Frame Advantage Counter
					oGameManager.frameAdvantage = 0;
				
					var particle = instance_create_layer(collision_list[| i].owner.x, collision_list[| i].owner.y, "Particles", oParticles);
					with (particle) 
					{
						lifetime = 10;
						sprite_index = sBlockEffect;
						image_xscale = collision_list[| i].owner.image_xscale;
					}
				}
				//Hitting	
				else if (attackProperty.attackType[hitboxID] != eAttackType.GRAB)
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
						if (other.counterHitProperty.counterHitLevel[hitboxID] == 1)
						{
							var counterParticle = instance_create_layer((global.camObj.x - 80 + 23) + (111* isP2), 61, "Particles", oParticles);
							with (counterParticle) 
							{
								lifetime = global.hitstop;
								sprite_index = sSmallCounter;
								depth = 2;
							}
						}
						else if (other.counterHitProperty.counterHitLevel[hitboxID] == 2)
						{
							var counterParticle = instance_create_layer((global.camObj.x - 80 + 30) + (97 * isP2), 70, "Particles", oParticles);
							with (counterParticle) 
							{
								lifetime = global.hitstop;
								sprite_index = sMediumCounter;
								depth = 2;
							}
						} 
						else if (other.counterHitProperty.counterHitLevel[hitboxID] == 3)
						{
							var counterParticle = instance_create_layer(global.camObj.x - 80, 0, "Particles", oParticles);
							with (counterParticle) 
							{
								lifetime = global.hitstop;
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
					var particle = instance_create_layer(x + (attackProperty.particlexOffset[hitboxID] * owner.image_xscale), y - attackProperty.particleyOffset[hitboxID], "Particles", oParticles);
					with (particle) 
					{
						sprite_index = other.attackProperty.particleEffect[other.hitboxID];
						image_xscale = sign(other.owner.image_xscale);
						lifetime = other.attackProperty.particleDuration[other.hitboxID];
					}
				}
			}
		}
	}
}