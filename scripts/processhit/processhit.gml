// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ProcessHit( attackProperty, collision_list)
{
	// Combo Scaling
	owner.combo++; // Add 1 to our combo length
	var scaledDamage = attackProperty.damage[hitboxID]; // Set the initial amount of damage to do
	var scaleAmount = 1 - (.1 * owner.comboScaling) // The amount to scale the combo by (decreases by 10% each for each scale)
	scaleAmount = max(scaleAmount, ScalingMinimum);
					
	if (owner.combo > 2) 
	{
		scaledDamage *= scaleAmount; // The amount of damage this hit will do. Important that this is updated before scaling is updated
		scaledDamage = round(scaledDamage); // Round the damage to the nearest whole number
		scaledDamage = max(scaledDamage, 1); // The lowest amount of damage a move can do must be 1 HP
		owner.comboScaling += attackProperty.comboScaling[hitboxID];
	} // increase the level of scaling for the combo
	if (owner.combo == 2)
	{
		owner.startCombo = true;
	} // Tells the game to display the combo counter when the combo is at least 2 hits long
					
	// Apply Damage
	collision_list.owner.hp -= scaledDamage;
	collision_list.owner.knockbackVel = attackProperty.knockback[hitboxID] * collision_list.owner.knockbackMultiplier;
					
					
	// Meter Build - P1 gets 100% meter, P2 gets 25%
	collision_list.owner.superMeter += floor(attackProperty.meterGain[hitboxID] * 0.25);
	owner.superMeter += floor(attackProperty.meterGain[hitboxID]);
					
	if (!collision_list.owner.grounded)
	{
		collision_list.owner.vsp = attackProperty.airKnockbackV[hitboxID] * collision_list.owner.knockbackMultiplier;
		collision_list.owner.hsp = attackProperty.airKnockbackH[hitboxID] * owner.image_xscale * collision_list.owner.knockbackMultiplier;
	}
	else if (attackProperty.launches[hitboxID])
	{
		collision_list.owner.vsp = attackProperty.LaunchKnockbackV[hitboxID] * collision_list.owner.knockbackMultiplier;
		collision_list.owner.hsp = attackProperty.LaunchKnockbackH[hitboxID] * owner.image_xscale * collision_list.owner.knockbackMultiplier;
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
	
	owner.pushbackVel = attackProperty.pushback[hitboxID];
	owner.heldOpponent = noone;

	hasHit = true;
	collision_list.owner.hitstun = attackProperty.attackHitstun[hitboxID];
	ds_list_add(collision_list.owner.hitByGroup, attackProperty.group[hitboxID]);
	global.hitstop = attackProperty.attackHitstop[hitboxID];
}