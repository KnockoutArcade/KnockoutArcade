// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ProcessHit( attackProperty, collision_list)
{
	if (!isProjectile)
	{
		// Combo Scaling
		owner.combo++; // Add 1 to our combo length
		var scaledDamage = attackProperty.Damage; // Set the initial amount of damage to do
		var scaleAmount = 1 - (.1 * owner.comboScaling) // The amount to scale the combo by (decreases by 10% each for each scale)
		scaleAmount = max(scaleAmount, ScalingMinimum);
					
		if (owner.combo > 2) 
		{
			scaledDamage *= scaleAmount; // The amount of damage this hit will do. Important that this is updated before scaling is updated
			scaledDamage = round(scaledDamage); // Round the damage to the nearest whole number
			scaledDamage = max(scaledDamage, 1); // The lowest amount of damage a move can do must be 1 HP
		} // increase the level of scaling for the combo
		else if (owner.combo == 2)
		{
			owner.startCombo = true;
		} // Tells the game to display the combo counter when the combo is at least 2 hits long
			
		owner.comboScaling += attackProperty.ComboScaling;
		
		// Apply Damage
		collision_list.owner.hp -= scaledDamage;
		collision_list.owner.knockbackVel = attackProperty.KnockBack * collision_list.owner.knockbackMultiplier;
		
		// Record Combo Damage
		owner.comboDamage += scaledDamage;
		owner.storedComboDamage = owner.comboDamage;
					
		// Meter Build - P1 gets 100% meter, P2 gets 25%
		collision_list.owner.superMeter += floor(attackProperty.MeterGain * 0.25);
		owner.superMeter += floor(attackProperty.MeterGain * owner.meterScaling);
		
		if (!collision_list.owner.grounded)
		{
			collision_list.owner.vsp = attackProperty.AirKnockbackVertical * collision_list.owner.knockbackMultiplier;
			collision_list.owner.hsp = attackProperty.AirKnockbackHorizontal * owner.image_xscale * collision_list.owner.knockbackMultiplier;
		}
		else if (attackProperty.Launches)
		{
			collision_list.owner.vsp = attackProperty.LaunchKnockbackVertical * collision_list.owner.knockbackMultiplier;
			collision_list.owner.hsp = attackProperty.LaunchKnockbackHorizontal * owner.image_xscale * collision_list.owner.knockbackMultiplier;
			collision_list.owner.grounded = false;
		
			// This fixes and issue where Destructible Objects would slide once they hit the ground.
			if (collision_list.owner.isDestructibleObject)
			{
				collision_list.owner.knockbackVel = 0;
			}
		}
		else 
		{
			collision_list.owner.vsp = 0;
		}
	
		if (owner.grounded)
		{
			owner.pushbackVel = attackProperty.Pushback;
		}
		owner.heldOpponent = noone;

		hasHit = true;
		collision_list.owner.hitstun = attackProperty.AttackHitStun;
		ds_list_add(collision_list.owner.hitByGroup, attackProperty.Group);
		
		// Handle Hitstop
		owner.hitstop = attackProperty.AttackHitStop;
		collision_list.owner.hitstop = attackProperty.AttackHitStop;
	
		
		//Draw hit effect
		var particle = instance_create_layer(x + (attackProperty.ParticleXOffset * owner.image_xscale), y - attackProperty.ParticleYOffset, "Particles", oParticles);
		
		particle.sprite_index = asset_get_index(attackProperty.ParticleEffect);
		particle.image_xscale = sign(owner.image_xscale);
		particle.lifetime = attackProperty.ParticleDuration;
	}
	else
	{
		// Combo Scaling
		owner.playerOwner.combo++; // Add 1 to our combo length
		var scaledDamage = attackProperty.Damage; // Set the initial amount of damage to do
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
					
		owner.playerOwner.comboDamage += scaledDamage;
		owner.playerOwner.storedComboDamage = owner.playerOwner.comboDamage;
					
		// Meter Build - P1 gets 100% meter, P2 gets 25%
		collision_list.owner.superMeter += floor(attackProperty.MeterGain * 0.25);
		owner.playerOwner.superMeter += floor(attackProperty.MeterGain * owner.playerOwner.meterScaling);
					
		if (!collision_list.owner.grounded)
		{
			collision_list.owner.vsp = attackProperty.AirKnockbackVertical * collision_list.owner.knockbackMultiplier;
			collision_list.owner.hsp = attackProperty.AirKnockbackHorizontal * owner.image_xscale * collision_list.owner.knockbackMultiplier;
		}
		else if (attackProperty.Launches)
		{
			collision_list.owner.vsp = attackProperty.LaunchKnockbackVertical * collision_list.owner.knockbackMultiplier;
			collision_list.owner.hsp = attackProperty.LaunchKnockbackHorizontal * owner.image_xscale * collision_list.owner.knockbackMultiplier;
			collision_list.owner.grounded = false;
		
			// This fixes and issue where Destructible Objects would slide once they hit the ground.
			if (collision_list.owner.isDestructibleObject)
			{
				collision_list.owner.knockbackVel = 0;
			}
		}
		else 
		{
			collision_list.owner.vsp = 0;
		}

		hasHit = true;
		collision_list.owner.hitstun = attackProperty.AttackHitStun;
		ds_list_add(collision_list.owner.hitByGroup, attackProperty.Group);
		
		// Handle Hitstop
		owner.hitstop = attackProperty.AttackHitStop;
		collision_list.owner.hitstop = attackProperty.AttackHitStop;
	}
}