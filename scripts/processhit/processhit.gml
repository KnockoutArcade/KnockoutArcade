// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ProcessHit(attackProperty, collision_list, finalBlowSuper)
{
	if (!isProjectile)
	{
		// Combo Scaling
		owner.combo++; // Add 1 to our combo length
		var scaledDamage = attackProperty.Damage + (owner.damageBonus / 100 * attackProperty.Damage); // Set the initial amount of damage to do
		var scaleAmount = 1 - (.1 * owner.comboScaling) // The amount to scale the combo by (decreases by 10% each for each scale)
		scaleAmount = max(scaleAmount, ScalingMinimum);
		
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
		if (finalBlowSuper)
		{
			if (collision_list.owner.hp - scaledDamage <= 0 && !attackProperty.FinalBlow)
			{
				collision_list.owner.hp = 1;
			}
			else
			{
				collision_list.owner.hp -= scaledDamage;
			}
		}
		else
		{
			collision_list.owner.hp -= scaledDamage;
		}
		
		collision_list.owner.knockbackVel = attackProperty.KnockBack * collision_list.owner.knockbackMultiplier;
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
					if (finalBlowSuper)
					{
						if (collision_list.owner.hp - scaledDamage <= 0 && !attackProperty.FinalBlow)
						{
							collision_list.owner.spiritCurrentHealth = 1;
						}
						else
						{
							collision_list.owner.spiritCurrentHealth -= scaledDamage;
						}
					}
					else
					{
						collision_list.owner.spiritCurrentHealth -= scaledDamage;
					}
					
					collision_list.owner.spiritObject.knockbackVel = attackProperty.KnockBack * collision_list.owner.knockbackMultiplier;
				}
				else
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
		if (!owner.timeStopActivated && !owner.installActivated)
		{
			collision_list.owner.superMeter += floor(attackProperty.MeterGain * 0.25);
			owner.superMeter += floor(attackProperty.MeterGain * owner.meterScaling);
		}
		
		if (!collision_list.owner.grounded)
		{
			collision_list.owner.vsp = attackProperty.AirKnockbackVertical * collision_list.owner.knockbackMultiplier;
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
				collision_list.owner.spiritObject.vsp = attackProperty.AirKnockbackVertical * collision_list.owner.knockbackMultiplier;
				collision_list.owner.spiritObject.hsp = attackProperty.AirKnockbackHorizontal * collision_list.owner.knockbackMultiplier * -collision_list.owner.spiritObject.image_xscale;
			}
		}
		else if (attackProperty.Launches)
		{
			collision_list.owner.vsp = attackProperty.LaunchKnockbackVertical * collision_list.owner.knockbackMultiplier;
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
				collision_list.owner.spiritObject.vsp =  attackProperty.LaunchKnockbackVertical * collision_list.owner.knockbackMultiplier;
				collision_list.owner.spiritObject.hsp = attackProperty.LaunchKnockbackHorizontal * collision_list.owner.knockbackMultiplier * -collision_list.owner.spiritObject.image_xscale;
				collision_list.owner.spiritObject.grounded = false;
			}
		
			// This fixes and issue where Destructible Objects would slide once they hit the ground.
			if (collision_list.owner.isDestructibleObject)
			{
				collision_list.owner.knockbackVel = 0;
			}
		}
		else 
		{
			collision_list.owner.vsp = 0;
			if (collision_list.owner.spiritObject != noone) 
			{
				collision_list.owner.spiritObject.vsp = 0;
			}
		}
	
		if (owner.grounded)
		{
			owner.pushbackVel = attackProperty.Pushback;
		}
		owner.heldOpponent = noone;

		ds_list_add(hasHit, collision_list.owner.id);
		collision_list.owner.hitstun = attackProperty.AttackHitStun;
		if (collision_list.owner.spiritObject != noone) 
		{
			collision_list.owner.spiritObject.hitstun = attackProperty.AttackHitStun;
		}
		ds_list_add(collision_list.owner.hitByGroup, attackProperty.Group);
		
		// Handle time stop
		if (attackProperty.ActivateTimeStop)
		{
			owner.timeStopActivated = true;
			owner.activateFreeze = true;
			global.freezeTimer = true;
			audio_pause_sound(testBGM);
		}
		
		// Handle Hitstop
		owner.hitstop = attackProperty.AttackHitStop;
		collision_list.owner.hitstop = attackProperty.AttackHitStop;
		if (collision_list.owner.spiritObject != noone) 
		{
			collision_list.owner.spiritObject.hitstop = attackProperty.AttackHitStop;
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
	}
	else
	{
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
		collision_list.owner.hp -= scaledDamage;
		collision_list.owner.knockbackVel = attackProperty.KnockBack * collision_list.owner.knockbackMultiplier;
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
					collision_list.owner.spiritCurrentHealth -= scaledDamage;
					collision_list.owner.spiritObject.knockbackVel = attackProperty.KnockBack * collision_list.owner.knockbackMultiplier;
				}
				else
				{
					// Instantly kills the spirit if its current move makes it vulnerable
					collision_list.owner.spiritCurrentHealth -= collision_list.owner.spiritMaxHealth;
				}
			}
		}
					
		owner.playerOwner.comboDamage += scaledDamage;
		owner.playerOwner.storedComboDamage = owner.playerOwner.comboDamage;
					
		// Meter Build - P1 gets 100% meter, P2 gets 25%
		if (!owner.playerOwner.timeStopActivated && !owner.playerOwner.installActivated)
		{
			collision_list.owner.superMeter += floor(attackProperty.MeterGain * 0.25);
			owner.playerOwner.superMeter += floor(attackProperty.MeterGain * owner.playerOwner.meterScaling);
		}
					
		if (!collision_list.owner.grounded)
		{
			collision_list.owner.vsp = attackProperty.AirKnockbackVertical * collision_list.owner.knockbackMultiplier;
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
				collision_list.owner.spiritObject.vsp = attackProperty.AirKnockbackVertical * collision_list.owner.knockbackMultiplier;
				collision_list.owner.spiritObject.hsp = attackProperty.AirKnockbackHorizontal * collision_list.owner.knockbackMultiplier * -collision_list.owner.spiritObject.image_xscale;
			}
		}
		else if (attackProperty.Launches)
		{
			collision_list.owner.vsp = attackProperty.LaunchKnockbackVertical * collision_list.owner.knockbackMultiplier;
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
				collision_list.owner.spiritObject.vsp =  attackProperty.LaunchKnockbackVertical * collision_list.owner.knockbackMultiplier;
				collision_list.owner.spiritObject.hsp = attackProperty.LaunchKnockbackHorizontal * collision_list.owner.knockbackMultiplier * -collision_list.owner.spiritObject.image_xscale;
				collision_list.owner.spiritObject.grounded = false;
			}
		
			// This fixes and issue where Destructible Objects would slide once they hit the ground.
			if (collision_list.owner.isDestructibleObject)
			{
				collision_list.owner.knockbackVel = 0;
			}
		}
		else 
		{
			collision_list.owner.vsp = 0;
			if (collision_list.owner.spiritObject != noone) 
			{
				collision_list.owner.spiritObject.vsp = 0;
			}
		}

		ds_list_add(hasHit, collision_list.owner.id);
		collision_list.owner.hitstun = attackProperty.AttackHitStun;
		if (collision_list.owner.spiritObject != noone) 
		{
			collision_list.owner.spiritObject.hitstun = attackProperty.AttackHitStun;
		}
		ds_list_add(collision_list.owner.hitByGroup, attackProperty.Group);
		
		// Handle Hitstop
		owner.hitstop = attackProperty.AttackHitStop;
		collision_list.owner.hitstop = attackProperty.AttackHitStop;
		if (collision_list.owner.spiritObject != noone) 
		{
			collision_list.owner.spiritObject.hitstop = attackProperty.AttackHitStop;
		}
	}
}