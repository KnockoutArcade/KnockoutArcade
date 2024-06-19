// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// attackProperty - The data for this move's hitbox. Only contains either normal hit data OR counter hit data, but not both.
// collision_list - The object that is getting hit
// finalBlowSuper - Whether this attack will trigger the final blow effect

// activateTimeStop - Whether this attack will activate time stop

function ProcessHit(attackProperty, collision_list, finalBlowSuper, activateTimeStop = false)
{
	if (!isProjectile)
	{
		// Attack hit script
		if (attackProperty.UseHitScript)
		{
			var scriptToExecute = asset_get_index(attackProperty.SupplementaryHitScript);
			
			scriptToExecute();
		}
		
		// Combo Scaling
		owner.combo++; // Add 1 to our combo length
		var scaledDamage = attackProperty.Damage + (owner.damageBonus / 100 * attackProperty.Damage); // Set the initial amount of damage to do
		var scaleAmount = 1 - (.1 * owner.comboScaling) // The amount to scale the combo by (decreases by 10% each for each scale)
		
		// If the attack is a super, use the minimum super scaling. Otherwise, do normal damage scaling.
		if (finalBlowSuper)
		{
			scaleAmount = max(scaleAmount, SuperScalingMinimum);
			show_debug_message("super scaling");
		}
		else
		{
			scaleAmount = max(scaleAmount, ScalingMinimum);
			show_debug_message("normal scaling");
		}
		
		
		if (owner.combo > 2) 
		{
			scaledDamage *= scaleAmount; // The amount of damage this hit will do. Important that this is updated before scaling is updated
			if (attackProperty.Damage + (owner.damageBonus / 100 * attackProperty.Damage) > 1) // If the attack's base damage is less than 1, allow decimals
			{
				scaledDamage = round(scaledDamage); // Round the damage to the nearest whole number
				scaledDamage = max(scaledDamage, 1); // The lowest amount of damage a move can do must be 1 HP
			}
			else
			{
				scaledDamage = max(scaledDamage, 0.1); // The lowest amount of damage possible must be 0.1 HP
			}
		} // increase the level of scaling for the combo
		else if (owner.combo == 2)
		{
			owner.startCombo = true;
		} // Tells the game to display the combo counter when the combo is at least 2 hits long
			
		owner.comboScaling += attackProperty.ComboScaling;
		
		// Apply Damage
		if (!global.roundOver) // ... but only if the round isn't over
		{
			// If this attack is a final blow (and the opponent isn't being counter hit, counter hits don't have this property)
			if (finalBlowSuper && !collision_list.owner.inAttackState)
			{
				// TODO: Make sure the character editor includes FinalBlow in the counter hit data
				
				if (collision_list.owner.hp - scaledDamage <= 0 && !attackProperty.FinalBlow)
				{
					collision_list.owner.hp = 1;
					// Add the damage to the victim's total damage taken (for singleplayer)
					collision_list.owner.totalDamageTaken += scaledDamage;
				}
				else
				{
					collision_list.owner.hp -= scaledDamage;
					// Add the damage to the victim's total damage taken (for singleplayer)
					collision_list.owner.totalDamageTaken += scaledDamage;
				}
			}
			else
			{
				collision_list.owner.hp -= scaledDamage;
				// Add the damage to the victim's total damage taken (for singleplayer)
				collision_list.owner.totalDamageTaken += scaledDamage;
			}
		}
		
		// Death detection
		var playerHasDied = false;
		// If the target's hp hits 0...
		if (collision_list.owner.hp <= 0)
		{
			// Add 1 to the total KOs of this hitbox's owner
			owner.totalKOs += 1;
			// Signal that the player has died
			playerHasDied = true;
		}
		
		// Apply Gravity Scaling
		if (!collision_list.owner.grounded || attackProperty.Launches)
		{
			// If the opponent is in the air, or if this attack launches, increase gravity scaling
			collision_list.owner.gravityScaling += attackProperty.GravityScaling;
			
			// Affect any spirit's gravity scaling
			if (collision_list.owner.spiritObject != noone) 
			{
				collision_list.owner.spiritObject.gravityScaling += attackProperty.GravityScaling;
			}
		}
		
		
		// Apply grounded knockback
		collision_list.owner.knockbackVel = attackProperty.KnockBack * collision_list.owner.knockbackMultiplier;
		collision_list.owner.wallBouncing = attackProperty.CausesWallbounce;
		if (collision_list.owner.spiritObject != noone || collision_list.owner.pendingToggle) 
		{
			if (collision_list.owner.pendingToggle)
			{
				collision_list.owner.spiritCurrentHealth -= scaledDamage;
				if (!collision_list.owner.spiritState)
				{
					with (collision_list.owner)
					{
						SummonSpirit();
						if (selectedCharacter.UniqueData.LinkMovesetsWithSpirits)
						{
							currentMovesetID = selectedCharacter.UniqueData.SpiritOnMoveset;
							OverwriteMoveset();
						}
					}
					collision_list.owner.spiritObject.knockbackVel = attackProperty.KnockBack * collision_list.owner.knockbackMultiplier;
				}
				else
				{
					with (collision_list.owner)
					{
						DeactivateSpirit(false);
						if (selectedCharacter.UniqueData.LinkMovesetsWithSpirits)
						{
							currentMovesetID = selectedCharacter.UniqueData.SpiritOffMoveset;
							OverwriteMoveset();
						}
					}
				}
			}
			else
			{
				if (!collision_list.owner.spiritObject.vulnerable)
				{
					if (finalBlowSuper && !collision_list.owner.spiritInstall)
					{
						if (collision_list.owner.hp - scaledDamage <= 0 && !attackProperty.FinalBlow)
						{
							collision_list.owner.spiritCurrentHealth = 1;
						}
						else if (!collision_list.owner.spiritInstall)
						{
							collision_list.owner.spiritCurrentHealth -= scaledDamage;
						}
					}
					else if (!collision_list.owner.spiritInstall)
					{
						collision_list.owner.spiritCurrentHealth -= scaledDamage;
					}
					
					collision_list.owner.spiritObject.knockbackVel = attackProperty.KnockBack * collision_list.owner.knockbackMultiplier;
				}
				else if (!collision_list.owner.spiritInstall)
				{
					// Instantly kills the spirit if its current move makes it vulnerable
					collision_list.owner.spiritCurrentHealth -= collision_list.owner.spiritMaxHealth;
				}
			}
		}
		
		// Record Combo Damage
		owner.comboDamage += scaledDamage;
		owner.storedComboDamage = owner.comboDamage;
		
		// Meter Build - P1 gets 100% meter, P2 gets 25%
		collision_list.owner.superMeter += floor(attackProperty.MeterGain * 0.25);
		if (!owner.timeStopActivated && !owner.installActivated)
		{
			owner.superMeter += floor(attackProperty.MeterGain * owner.meterScaling);
		}
		
		if (!collision_list.owner.grounded) // On Air hit, set knockback velocity
		{
			// Upwards velocity (affected by gravity scaling)
			collision_list.owner.vsp = attackProperty.AirKnockbackVertical * collision_list.owner.knockbackMultiplier * (1 - (max((collision_list.owner.gravityScaling - 5), 0) / GravityScalingMaximum));
			
			// Horizontal direction of destructible objects are based on the player hitting them
			if (collision_list.owner.isDestructibleObject)
			{
				collision_list.owner.hsp = attackProperty.AirKnockbackHorizontal * collision_list.owner.knockbackMultiplier * owner.image_xscale;
			}
			else
			{
				collision_list.owner.hsp = attackProperty.AirKnockbackHorizontal * collision_list.owner.knockbackMultiplier * -collision_list.owner.image_xscale;
			}
			
			// Affect any spirit's knockback velocities.
			if (collision_list.owner.spiritObject != noone) 
			{
				collision_list.owner.spiritObject.vsp = attackProperty.AirKnockbackVertical * collision_list.owner.knockbackMultiplier * (1 - (max((collision_list.owner.gravityScaling - 5), 0) / GravityScalingMaximum));
				collision_list.owner.spiritObject.hsp = attackProperty.AirKnockbackHorizontal * collision_list.owner.knockbackMultiplier * -collision_list.owner.spiritObject.image_xscale;
			}
		}
		else if (attackProperty.Launches) // Handle Launches
		{
			// vertical knockback (affected by scaling)
			collision_list.owner.vsp = attackProperty.LaunchKnockbackVertical * collision_list.owner.knockbackMultiplier * (1 - (max((collision_list.owner.gravityScaling - 5), 0) / GravityScalingMaximum));
			
			// Horizontal direction of destructible objects are based on the player hitting them
			if (collision_list.owner.isDestructibleObject)
			{
				collision_list.owner.hsp = attackProperty.LaunchKnockbackHorizontal * collision_list.owner.knockbackMultiplier * owner.image_xscale;
			}
			else
			{
				collision_list.owner.hsp = attackProperty.LaunchKnockbackHorizontal * collision_list.owner.knockbackMultiplier * -collision_list.owner.image_xscale;
			}
			collision_list.owner.grounded = false;
			
			if (collision_list.owner.spiritObject != noone) 
			{
				collision_list.owner.spiritObject.vsp =  attackProperty.LaunchKnockbackVertical * collision_list.owner.knockbackMultiplier * (1 - (max((collision_list.owner.gravityScaling - 5), 0) / GravityScalingMaximum));
				collision_list.owner.spiritObject.hsp = attackProperty.LaunchKnockbackHorizontal * collision_list.owner.knockbackMultiplier * -collision_list.owner.spiritObject.image_xscale;
				collision_list.owner.spiritObject.grounded = false;
			}
		
			// This fixes and issue where Destructible Objects would slide once they hit the ground.
			if (collision_list.owner.isDestructibleObject)
			{
				collision_list.owner.knockbackVel = 0;
			}
		}
		else // Handle grounded hits that don't launch
		{
			if (!playerHasDied) // if the player isn't dead, don't launch them
			{
				collision_list.owner.vsp = 0;
				if (collision_list.owner.spiritObject != noone) 
				{
					collision_list.owner.spiritObject.vsp = 0;
				}
			}
			else // if the player has died, launch them a little bit
			{
				// This code allows weak hits that end the round to launch the opponent.
				// We don't currently have a "crumple" or "kneel-fall" animation, so
				// we are going to launch the opponent a little bit instead.
				
				collision_list.owner.vsp = -2;
				collision_list.owner.grounded = false;
				collision_list.owner.hsp = 2 * -collision_list.owner.image_xscale; 
				
				if (collision_list.owner.spiritObject != noone) 
				{
					collision_list.owner.spiritObject.vsp = -2;
					collision_list.owner.spiritObject.hsp = 2 * -collision_list.owner.spiritObject.image_xscale;
					collision_list.owner.spiritObject.grounded = false;
				}
			}
		}
		
		// Apply pushback
		if (owner.grounded)
		{
			owner.pushbackVel = attackProperty.Pushback;
		}
		
		// Reset held opponent
		owner.heldOpponent = noone;
		
		// Prevent the victim from blocking
		collision_list.owner.canBlock = false;
		
		// Add this victim to the list of things this hitbox has already hit
		ds_list_add(hasHit, collision_list.owner.id);
		
		// Set hitstun
		collision_list.owner.hitstun = attackProperty.AttackHitStun;
		if (collision_list.owner.spiritObject != noone) 
		{
			collision_list.owner.spiritObject.hitstun = attackProperty.AttackHitStun;
		}
		
		// Add the group that this hitbox belongs to to the opponent's hitByGroup
		ds_list_add(collision_list.owner.hitByGroup, attackProperty.Group);
		
		// Handle time stop
		if (activateTimeStop)
		{
			owner.timeStopActivated = true;
			owner.activateFreeze = true;
			global.freezeTimer = true;
			audio_pause_sound(testBGM);
		}
		
		// Handle Hitstop
		owner.hitstop = attackProperty.AttackHitStop;
		collision_list.owner.hitstop = attackProperty.AttackHitStop;
		collision_list.owner.inAttackState = false;
		if (collision_list.owner.spiritObject != noone) 
		{
			collision_list.owner.spiritObject.hitstop = attackProperty.AttackHitStop;
			collision_list.owner.spiritObject.inAttackState = false;
		}
		
		// Play sound effect
		if (attackProperty.HitSound != "")
		{
			audio_play_sound(asset_get_index(attackProperty.HitSound), 0, false);
		}
		
		//Draw hit effect
		var particle = noone;
		if (spirit != noone)
		{
			var particle = instance_create_layer(x + (attackProperty.ParticleXOffset * spirit.image_xscale), y - attackProperty.ParticleYOffset, "Particles", oParticles);
			particle.image_xscale = sign(spirit.image_xscale);
		}
		else
		{
			var particle = instance_create_layer(x + (attackProperty.ParticleXOffset * owner.image_xscale), y - attackProperty.ParticleYOffset, "Particles", oParticles);
			particle.image_xscale = sign(owner.image_xscale);
		}
		
		particle.sprite_index = asset_get_index(attackProperty.ParticleEffect);
		particle.lifetime = attackProperty.ParticleDuration;
		
		// Handle Screen Shake
		global.camObj.isScreenShaking = true; // Set screen shake to true
		global.camObj.screenShakeLevel = counterHitProperty.CounterHitLevel; // Set the screen shake level
		global.camObj.screenShakeDuration = attackProperty.AttackHitStop; // Set the screen shake duration
	}
	else
	{
		// Attack hit script
		if (attackProperty.UseHitScript)
		{
			var scriptToExecute = asset_get_index(attackProperty.SupplementaryHitScript);
			
			scriptToExecute();
		}
		
		// Combo Scaling
		owner.playerOwner.combo++; // Add 1 to our combo length
		var scaledDamage = attackProperty.Damage + (owner.playerOwner.damageBonus / 100 * attackProperty.Damage); // Set the initial amount of damage to do
		var scaleAmount = 1 - (.1 * owner.playerOwner.comboScaling) // The amount to scale the combo by (decreases by 10% each for each scale)
		scaleAmount = max(scaleAmount, ScalingMinimum);
					
		if (owner.playerOwner.combo > 2) 
		{
			scaledDamage *= scaleAmount; // The amount of damage this hit will do. Important that this is updated before scaling is updated
			scaledDamage = round(scaledDamage); // Round the damage to the nearest whole number
			scaledDamage = max(scaledDamage, 1); // The lowest amount of damage a move can do must be 1 HP
		} // increase the level of scaling for the combo
		else if (owner.playerOwner.combo == 2)
		{
			owner.playerOwner.startCombo = true;
		} // Tells the game to display the combo counter when the combo is at least 2 hits long
				
		owner.playerOwner.comboScaling += attackProperty.ComboScaling;
				
		// Apply Damage
		if (!global.roundOver) // ... but only if the round isn't over
		{
			collision_list.owner.hp -= scaledDamage;
			// Add the damage to the victim's total damage
			collision_list.owner.totalDamageTaken -= scaledDamage;
		}
		
		// Death detection
		var playerHasDied = false;
		// If the target's hp hits 0...
		if (collision_list.owner.hp <= 0)
		{
			// Add 1 to the total KOs of this projectile's owner
			owner.playerOwner.totalKOs += 1;
			// Signal that the player has died
			playerHasDied = true;
		}
		
		// Apply Gravity Scaling
		if (!collision_list.owner.grounded || attackProperty.Launches)
		{
			// If the opponent is in the air, or if this attack launches, increase gravity scaling
			collision_list.owner.gravityScaling += attackProperty.GravityScaling;
			
			// Affect any spirit's gravity scaling
			if (collision_list.owner.spiritObject != noone) 
			{
				collision_list.owner.spiritObject.gravityScaling += attackProperty.GravityScaling;
			}
		}
		
		
		collision_list.owner.knockbackVel = attackProperty.KnockBack * collision_list.owner.knockbackMultiplier;
		collision_list.owner.wallBouncing = attackProperty.CausesWallbounce;
		if (collision_list.owner.spiritObject != noone || collision_list.owner.pendingToggle) 
		{
			if (collision_list.owner.pendingToggle)
			{
				collision_list.owner.spiritCurrentHealth -= scaledDamage;
				if (!collision_list.owner.spiritState)
				{
					with (collision_list.owner)
					{
						SummonSpirit();
						if (selectedCharacter.UniqueData.LinkMovesetsWithSpirits)
						{
							currentMovesetID = selectedCharacter.UniqueData.SpiritOnMoveset;
							OverwriteMoveset();
						}
					}
					collision_list.owner.spiritObject.knockbackVel = attackProperty.KnockBack * collision_list.owner.knockbackMultiplier;
				}
				else
				{
					with (collision_list.owner)
					{
						DeactivateSpirit(false);
						if (selectedCharacter.UniqueData.LinkMovesetsWithSpirits)
						{
							currentMovesetID = selectedCharacter.UniqueData.SpiritOffMoveset;
							OverwriteMoveset();
						}
					}
				}
			}
			else
			{
				if (!collision_list.owner.spiritObject.vulnerable && !collision_list.owner.spiritInstall)
				{
					collision_list.owner.spiritCurrentHealth -= scaledDamage;
					collision_list.owner.spiritObject.knockbackVel = attackProperty.KnockBack * collision_list.owner.knockbackMultiplier;
				}
				else if (!collision_list.owner.spiritInstall)
				{
					// Instantly kills the spirit if its current move makes it vulnerable
					collision_list.owner.spiritCurrentHealth -= collision_list.owner.spiritMaxHealth;
				}
			}
		}
					
		owner.playerOwner.comboDamage += scaledDamage;
		owner.playerOwner.storedComboDamage = owner.playerOwner.comboDamage;
		
		collision_list.owner.superMeter += floor(attackProperty.MeterGain * 0.25);
		// Meter Build - P1 gets 100% meter, P2 gets 25%
		if (!owner.playerOwner.timeStopActivated && !owner.playerOwner.installActivated)
		{
			owner.playerOwner.superMeter += floor(attackProperty.MeterGain * owner.playerOwner.meterScaling);
		}
					
		if (!collision_list.owner.grounded)
		{
			collision_list.owner.vsp = attackProperty.AirKnockbackVertical * collision_list.owner.knockbackMultiplier * (1 - (max((collision_list.owner.gravityScaling - 5), 0) / GravityScalingMaximum));
			// Horizontal direction of destructible objects are based on the player hitting them
			if (collision_list.owner.isDestructibleObject)
			{
				collision_list.owner.hsp = attackProperty.AirKnockbackHorizontal * collision_list.owner.knockbackMultiplier * owner.image_xscale;
			}
			else
			{
				collision_list.owner.hsp = attackProperty.AirKnockbackHorizontal * collision_list.owner.knockbackMultiplier * -collision_list.owner.image_xscale;
			}
			
			if (collision_list.owner.spiritObject != noone) 
			{
				collision_list.owner.spiritObject.vsp = attackProperty.AirKnockbackVertical * collision_list.owner.knockbackMultiplier * (1 - (max((collision_list.owner.gravityScaling - 5), 0) / GravityScalingMaximum));
				collision_list.owner.spiritObject.hsp = attackProperty.AirKnockbackHorizontal * collision_list.owner.knockbackMultiplier * -collision_list.owner.spiritObject.image_xscale;
			}
		}
		else if (attackProperty.Launches)
		{
			collision_list.owner.vsp = attackProperty.LaunchKnockbackVertical * collision_list.owner.knockbackMultiplier * (1 - (max((collision_list.owner.gravityScaling - 5), 0) / GravityScalingMaximum));
			// Horizontal direction of destructible objects are based on the player hitting them
			if (collision_list.owner.isDestructibleObject)
			{
				collision_list.owner.hsp = attackProperty.LaunchKnockbackHorizontal * collision_list.owner.knockbackMultiplier * owner.image_xscale;
			}
			else
			{
				collision_list.owner.hsp = attackProperty.LaunchKnockbackHorizontal * collision_list.owner.knockbackMultiplier * -collision_list.owner.image_xscale;
			}
			collision_list.owner.grounded = false;
			
			if (collision_list.owner.spiritObject != noone) 
			{
				collision_list.owner.spiritObject.vsp =  attackProperty.LaunchKnockbackVertical * collision_list.owner.knockbackMultiplier * (1 - (max((collision_list.owner.gravityScaling - 5), 0) / GravityScalingMaximum));
				collision_list.owner.spiritObject.hsp = attackProperty.LaunchKnockbackHorizontal * collision_list.owner.knockbackMultiplier * -collision_list.owner.spiritObject.image_xscale;
				collision_list.owner.spiritObject.grounded = false;
			}
		
			// This fixes and issue where Destructible Objects would slide once they hit the ground.
			if (collision_list.owner.isDestructibleObject)
			{
				collision_list.owner.knockbackVel = 0;
			}
		}
		else // Handle ground hits that don't launch
		{
			if (!playerHasDied) // if the player isn't dead, don't launch them
			{
				collision_list.owner.vsp = 0;
				if (collision_list.owner.spiritObject != noone) 
				{
					collision_list.owner.spiritObject.vsp = 0;
				}
			}
			else // if the player has died, launch them a little bit
			{
				// This code allows weak hits that end the round to launch the opponent.
				// We don't currently have a "crumple" or "kneel-fall" animation, so
				// we are going to launch the opponent a little bit instead.
				
				collision_list.owner.vsp = -2;
				collision_list.owner.grounded = false;
				collision_list.owner.hsp = 2 * -collision_list.owner.image_xscale; 
				
				if (collision_list.owner.spiritObject != noone) 
				{
					collision_list.owner.spiritObject.vsp = -2;
					collision_list.owner.spiritObject.hsp = 2 * -collision_list.owner.spiritObject.image_xscale;
					collision_list.owner.spiritObject.grounded = false;
				}
			}
		}

		ds_list_add(hasHit, collision_list.owner.id);
		collision_list.owner.hitstun = attackProperty.AttackHitStun;
		if (collision_list.owner.spiritObject != noone) 
		{
			collision_list.owner.spiritObject.hitstun = attackProperty.AttackHitStun;
		}
		ds_list_add(collision_list.owner.hitByGroup, attackProperty.Group);
		// Since this is a projectile, add its ID to the target's projectileHitBy list
		ds_list_add(collision_list.owner.projectileHitByGroup, id);
		
		// Handle Hitstop
		owner.hitstop = attackProperty.AttackHitStop;
		collision_list.owner.hitstop = attackProperty.AttackHitStop;
		collision_list.owner.inAttackState = false;
		if (collision_list.owner.spiritObject != noone) 
		{
			collision_list.owner.spiritObject.hitstop = attackProperty.AttackHitStop;
			collision_list.owner.spiritObject.inAttackState = false;
		}
		
		//Draw hit effect
		var particle = noone;
		if (spirit != noone)
		{
			var particle = instance_create_layer(x + (attackProperty.ParticleXOffset * spirit.image_xscale), y - attackProperty.ParticleYOffset, "Particles", oParticles);
			particle.image_xscale = sign(spirit.image_xscale);
		}
		else
		{
			var particle = instance_create_layer(x + (attackProperty.ParticleXOffset * owner.image_xscale), y - attackProperty.ParticleYOffset, "Particles", oParticles);
			particle.image_xscale = sign(owner.image_xscale);
		}
		
		particle.sprite_index = asset_get_index(attackProperty.ParticleEffect);
		particle.lifetime = attackProperty.ParticleDuration;
		
		// Play sound effect
		if (attackProperty.HitSound != "")
		{
			audio_play_sound(asset_get_index(attackProperty.HitSound), 0, false);
		}
		
		// Handle Screen Shake
		global.camObj.isScreenShaking = true; // Set screen shake to true
		global.camObj.screenShakeLevel = counterHitProperty.CounterHitLevel; // Set the screen shake level
		global.camObj.screenShakeDuration = attackProperty.AttackHitStop; // Set the screen shake duration
	}
}