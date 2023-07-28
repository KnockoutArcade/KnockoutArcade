// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Uses similar functionality to PerformAttack but specifically for projectiles
function PerformProjectile(playerOwner, spiritOwner)
{
	var hitboxPropertiesCopy = hitboxProperties;

	var hitbox = 0;
	if (hasLifetime)
	{
		// Animations
		for (var i = 0; i < selectedProjectile.NumberOfWindows; i++)
		{
			if (animTimer >= selectedProjectile.Window[i].Length)
			{
				image_index = selectedProjectile.Window[i].ImageIndex;
			}
		}

		// Hitboxes
		for (var i = 0; i < hitboxPropertiesCopy.NumberOfHitboxes; i++;)
		{
			if (animTimer == hitboxPropertiesCopy.AttackProperty[i].Start)
			{
				hitbox = instance_create_layer(x + (hitboxPropertiesCopy.AttackProperty[i].WidthOffset * other.image_xscale) + 0.5, y - hitboxPropertiesCopy.AttackProperty[i].HeightOffset, "hitboxes", oHitbox);
				ds_list_add(hitboxID, hitbox);
				with(hitbox)
				{
					lifetime = hitboxPropertiesCopy.AttackProperty[i].Lifetime;
					hitboxID = i;
					image_xscale = hitboxPropertiesCopy.AttackProperty[i].AttackWidth * other.image_xscale;
					image_yscale = hitboxPropertiesCopy.AttackProperty[i].AttackHeight;
					owner = other.id;

					isProjectile = true;

					// Pass through attack data
					attackProperty = hitboxPropertiesCopy.AttackProperty[i];
					counterHitProperty = hitboxPropertiesCopy.CounterHitProperty[i];
				}
			}
		}


		// Re-hitting Hitboxes
		if (hitboxPropertiesCopy.RehitData.NumberOfHits > 0)
		{
			for (var i = 0; i < hitboxPropertiesCopy.RehitData.HitBox; i++;)
			{
				for (var j = 0; j < hitboxPropertiesCopy.RehitData.NumberOfHits; j++;)
				{
					if (animTimer == hitboxPropertiesCopy.RehitData.HitOnFrames[j])
					{
						hitbox = instance_create_layer(x + (hitboxPropertiesCopy.AttackProperty[i].WidthOffset * other.image_xscale) + 0.5, y - hitboxPropertiesCopy.AttackProperty[i].HeightOffset, "hitboxes", oHitbox);
						ds_list_add(hitboxID, hitbox);
						with(hitbox)
						{
							lifetime = hitboxPropertiesCopy.AttackProperty[i].Lifetime;
							hitboxID = i;
							image_xscale = hitboxPropertiesCopy.AttackProperty[i].AttackWidth * other.image_xscale;
							image_yscale = hitboxPropertiesCopy.AttackProperty[i].AttackHeight;
							owner = other.id;

							isProjectile = true;

							// Pass through attack data
							attackProperty = hitboxPropertiesCopy.AttackProperty[i];
							counterHitProperty = hitboxPropertiesCopy.CounterHitProperty[i];
						}

						// Clears the hitBy data to allow attacks to connect properly
						ds_list_clear(playerOwner.hitByGroup);
						if (spiritOwner != noone && spiritOwner.hostObject.target != noone)
						{
							ds_list_clear(spiritOwner.hostObject.target.hitByGroup);
						}
						if (playerOwner.target != noone)
						{
							ds_list_clear(playerOwner.target.hitByGroup);
						}
					}
				}
			}
		}
	}
	else
	{
		animTimer = 0;
		image_speed = 1;

		for (var i = 0; i < hitboxPropertiesCopy.NumberOfHitboxes; i++;)
		{
			hitbox = instance_create_layer(x + (hitboxProperties.AttackData[i].AttackWidth * other.image_xscale) + 0.5, y - hitboxProperties.AttackData[i].HeightOffset, "hitboxes", oHitbox);
			ds_list_add(hitboxID, hitbox);
			with(hitbox)
			{
				hitboxID = i;
				image_xscale = other.hitboxProperties.AttackData[i].AttackWidth * other.image_xscale;
				image_yscale = other.hitboxProperties.AttackData[i].AttackHeight;
				owner = other.id;

				isProjectile = true;

				// Pass through attack data
				attackProperty = other.hitboxProperties.AttackData[i];
				counterHitProperty = other.hitboxProperties.CounterData[i];
			}
		}
	}
}