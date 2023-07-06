// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PressAttackButton(attack)
{	
		// Input Normal attacks first
		switch attack 
		{
			case 1:
				if (prevState == eState.STANDING_LIGHT_ATTACK_2)
				{ 
					state = eState.STANDING_LIGHT_ATTACK_2;
					if (spirit != noone && selectedCharacter.StandLight2.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.STANDING_LIGHT_ATTACK_2;
						spiritObject.attack = attack;
					}
				}
				else if (prevState == eState.STANDING_LIGHT_ATTACK_3)
				{
					state = eState.STANDING_LIGHT_ATTACK_3;
					if (spirit != noone && selectedCharacter.StandLight3.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.STANDING_LIGHT_ATTACK_3;
						spiritObject.attack = attack;
					}
				}
				else if (state == eState.JUMPING || state == eState.RUSH_CANCEL_UP)
				{
					state = eState.JUMPING_LIGHT_ATTACK;
					if (spirit != noone && selectedCharacter.JumpingLight.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.JUMPING_LIGHT_ATTACK;
						spiritObject.attack = attack;
					}
				}
				else if (verticalMoveDir = -1)
				{
					state = eState.CROUCHING_LIGHT_ATTACK;
					if (spirit != noone && selectedCharacter.CrouchingLight.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.CROUCHING_LIGHT_ATTACK;
						spiritObject.attack = attack;
					}
				}
				else if (state != eState.JUMPSQUAT)
				{ 
					state = eState.STANDING_LIGHT_ATTACK;
					image_index = 0;
					if (spirit != noone && selectedCharacter.StandLight.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.STANDING_LIGHT_ATTACK;
						spiritObject.attack = attack;
					}
				}
				else
				{
					jumpAttackBuffer = eState.JUMPING_LIGHT_ATTACK;
					if (spirit != noone && selectedCharacter.JumpingLight.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.JUMPING_LIGHT_ATTACK;
						spiritObject.attack = attack;
					}
				}
			break;
		
			case 2:
				if (state == eState.JUMPING || state == eState.RUSH_CANCEL_UP) 
				{
					state = eState.JUMPING_MEDIUM_ATTACK;
					if (spirit != noone && selectedCharacter.JumpingMedium.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.JUMPING_MEDIUM_ATTACK;
						spiritObject.attack = attack;
					}
				}
				else if (verticalMoveDir == -1)
				{
					state = eState.CROUCHING_MEDIUM_ATTACK;
					if (spirit != noone && selectedCharacter.CrouchingMedium.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.CROUCHING_MEDIUM_ATTACK;
						spiritObject.attack = attack;
					}
				}
				else if (state != eState.JUMPSQUAT)
				{
					state = eState.STANDING_MEDIUM_ATTACK;
					image_index = 0;
					if (spirit != noone && selectedCharacter.StandMedium.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.STANDING_MEDIUM_ATTACK;
						spiritObject.attack = attack;
					}
				}
				else
				{
					jumpAttackBuffer = eState.JUMPING_MEDIUM_ATTACK;
					if (spirit != noone && selectedCharacter.JumpingMedium.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.JUMPING_MEDIUM_ATTACK;
						spiritObject.attack = attack;
					}
				}
			break;
			
			case 3:
				if (state == eState.JUMPING || state == eState.RUSH_CANCEL_UP)
				{
				 	state = eState.JUMPING_HEAVY_ATTACK;
					if (spirit != noone && selectedCharacter.JumpingHeavy.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.JUMPING_HEAVY_ATTACK;
						spiritObject.attack = attack;
					}
				}
				else if (verticalMoveDir == -1)
				{
					state = eState.CROUCHING_HEAVY_ATTACK;
					if (spirit != noone && selectedCharacter.CrouchingHeavy.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.CROUCHING_HEAVY_ATTACK;
						spiritObject.attack = attack;
					}
				}
				else if (state != eState.JUMPSQUAT)
				{
					state = eState.STANDING_HEAVY_ATTACK;
					image_index = 0;
					if (spirit != noone && selectedCharacter.StandHeavy.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.STANDING_HEAVY_ATTACK;
						spiritObject.attack = attack;
					}
				}
				else
				{
					jumpAttackBuffer = eState.JUMPING_HEAVY_ATTACK;
					if (spirit != noone && selectedCharacter.JumpingHeavy.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.JUMPING_HEAVY_ATTACK;
						spiritObject.attack = attack;
					}
				}
			break;
			
			case 4:
				if (state != eState.JUMPING && state != eState.JUMPSQUAT && state != eState.RUSH_CANCEL_UP) 
				{
					state = eState.GRAB;
					sprite_index = sRussel_Grab;
					image_index = 0;
					if (spirit != noone && selectedCharacter.Grab.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.GRAB;
						spiritObject.attack = attack;
					}
				}
			break;
			
			case 5:
				if (state != eState.JUMPSQUAT && movedir == 0 && verticalMoveDir == 0)
				{
					state = eState.NEUTRAL_SPECIAL;
					image_index = 0;
					if (spirit != noone && selectedCharacter.NeutralSpecial.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.NEUTRAL_SPECIAL;
						spiritObject.attack = attack;
					}
				} 
				else if (state != eState.JUMPSQUAT && movedir != 0)
				{
					state = eState.SIDE_SPECIAL;
					image_index = 0;
					if (spirit != noone && selectedCharacter.SideSpecial.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.SIDE_SPECIAL;
						spiritObject.attack = attack;
					}
				}
				else if (verticalMoveDir == 1)
				{
					state = eState.UP_SPECIAL
					animTimer = 0;
					image_index = 0;
					if (spirit != noone && selectedCharacter.UpSpecial.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.UP_SPECIAL;
						spiritObject.attack = attack;
					}
				}
				else if (verticalMoveDir == -1 && state != eState.JUMPSQUAT)
				{
					state = eState.DOWN_SPECIAL
					animTimer = 0;
					image_index = 0;
					if (spirit != noone && selectedCharacter.DownSpecial.SpiritData.PerformAttack)
					{
						spiritObject.state = eState.DOWN_SPECIAL;
						spiritObject.attack = attack;
					}
				}
			break;
		}
		
		
		// Handle Command Normals last so they take priority
		
		// Convert the player's input direction into numpad notation
			
		var inputDirection = 5; // Neutral; Default
		// Set input directions
		if (movedir == -image_xscale && verticalMoveDir == -1)
		{
			inputDirection = 1; // Down-back
		}
		else if (movedir == 0 && verticalMoveDir == -1)
		{
			inputDirection = 2; // Down
		}
		else if (movedir == image_xscale && verticalMoveDir == -1)
		{
			inputDirection = 3; // Down-forward
		}
		else if (movedir == -image_xscale && verticalMoveDir == 0)
		{
			inputDirection = 4; // Back
		}
		else if (movedir == 0 && verticalMoveDir == 0)
		{
			inputDirection = 5; // Neutral
		}
		else if (movedir == image_xscale && verticalMoveDir == 0)
		{
			inputDirection = 6; // Forward
		}
		else if (movedir == -image_xscale && verticalMoveDir == 1)
		{
			inputDirection = 7; // Up-back
		}
		else if (movedir == 0 && verticalMoveDir == 1)
		{
			inputDirection = 8; // Up
		}
		else if (movedir == image_xscale && verticalMoveDir == 1)
		{
			inputDirection = 9; // Up-forward
		}
		
		// Check to see if each command normal is defined before processing it.
		if (variable_struct_exists(selectedCharacter, "CommandNormal1"))
		{
			if (attack == selectedCharacter.CommandNormal1.CommandNormalData.Button && inputDirection == selectedCharacter.CommandNormal1.CommandNormalData.NumpadDirection && grounded != selectedCharacter.CommandNormal1.CommandNormalData.GroundOrAir)
			{
				state = eState.COMMAND_NORMAL_1;
				if (spirit != noone && selectedCharacter.CommandNormal1.SpiritData.PerformAttack)
				{
					spiritObject.state = eState.COMMAND_NORMAL_1;
					spiritObject.attack = attack;
				}
			}
		}
		if (variable_struct_exists(selectedCharacter, "CommandNormal2"))
		{
			if (attack == selectedCharacter.CommandNormal2.CommandNormalData.Button && inputDirection == selectedCharacter.CommandNormal2.CommandNormalData.NumpadDirection && grounded != selectedCharacter.CommandNormal2.CommandNormalData.GroundOrAir)
			{
				state = eState.COMMAND_NORMAL_2;
				if (spirit != noone && selectedCharacter.CommandNormal2.SpiritData.PerformAttack)
				{
					spiritObject.state = eState.COMMAND_NORMAL_2;
					spiritObject.attack = attack;
				}
			}
		}
		if (variable_struct_exists(selectedCharacter, "CommandNormal3"))
		{
			if (attack == selectedCharacter.CommandNormal3.CommandNormalData.Button && inputDirection == selectedCharacter.CommandNormal3.CommandNormalData.NumpadDirection && grounded != selectedCharacter.CommandNormal3.CommandNormalData.GroundOrAir)
			{
				state = eState.COMMAND_NORMAL_3;
				if (spirit != noone && selectedCharacter.CommandNormal3.SpiritData.PerformAttack)
				{
					spiritObject.state = eState.COMMAND_NORMAL_3;
					spiritObject.attack = attack;
				}
			}
		}
		
		
	// Clears the hitBy data to allow attacks to connect properly
	ds_list_clear(hitByGroup);
	if (target != noone)
	{
		ds_list_clear(target.hitByGroup);
	}

	cancelable = false;
}