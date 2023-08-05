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
					SetSpiritMoveData(false, selectedCharacter.StandLight2, attack);
				}
				else if (prevState == eState.STANDING_LIGHT_ATTACK_3)
				{
					state = eState.STANDING_LIGHT_ATTACK_3;
					SetSpiritMoveData(false, selectedCharacter.StandLight3, attack);
				}
				else if (state == eState.JUMPING || state == eState.RUSH_CANCEL_UP)
				{
					state = eState.JUMPING_LIGHT_ATTACK;
					SetSpiritMoveData(false, selectedCharacter.JumpingLight, attack);
				}
				else if (verticalMoveDir = -1)
				{
					state = eState.CROUCHING_LIGHT_ATTACK;
					SetSpiritMoveData(false, selectedCharacter.CrouchingLight, attack);
				}
				else if (state != eState.JUMPSQUAT)
				{ 
					state = eState.STANDING_LIGHT_ATTACK;
					image_index = 0;
					SetSpiritMoveData(false, selectedCharacter.StandLight, attack);
				}
				else
				{
					jumpAttackBuffer = eState.JUMPING_LIGHT_ATTACK;
					SetSpiritMoveData(false, selectedCharacter.JumpingLight, attack);
				}
			break;
		
			case 2:
				if (state == eState.JUMPING || state == eState.RUSH_CANCEL_UP) 
				{
					state = eState.JUMPING_MEDIUM_ATTACK;
					SetSpiritMoveData(false, selectedCharacter.JumpingMedium, attack);
				}
				else if (verticalMoveDir == -1)
				{
					state = eState.CROUCHING_MEDIUM_ATTACK;
					SetSpiritMoveData(false, selectedCharacter.CrouchingMedium, attack);
				}
				else if (state != eState.JUMPSQUAT)
				{
					state = eState.STANDING_MEDIUM_ATTACK;
					image_index = 0;
					SetSpiritMoveData(false, selectedCharacter.StandMedium, attack);
				}
				else
				{
					jumpAttackBuffer = eState.JUMPING_MEDIUM_ATTACK;
					SetSpiritMoveData(false, selectedCharacter.JumpingMedium, attack);
				}
			break;
			
			case 3:
				if (state == eState.JUMPING || state == eState.RUSH_CANCEL_UP)
				{
				 	state = eState.JUMPING_HEAVY_ATTACK;
					SetSpiritMoveData(false, selectedCharacter.JumpingHeavy, attack);
				}
				else if (verticalMoveDir == -1)
				{
					state = eState.CROUCHING_HEAVY_ATTACK;
					SetSpiritMoveData(false, selectedCharacter.CrouchingHeavy, attack);
				}
				else if (state != eState.JUMPSQUAT)
				{
					state = eState.STANDING_HEAVY_ATTACK;
					image_index = 0;
					SetSpiritMoveData(false, selectedCharacter.StandHeavy, attack);
				}
				else
				{
					jumpAttackBuffer = eState.JUMPING_HEAVY_ATTACK;
					SetSpiritMoveData(false, selectedCharacter.JumpingHeavy, attack);
				}
			break;
			
			case 4:
				if (state != eState.JUMPING && state != eState.JUMPSQUAT && state != eState.RUSH_CANCEL_UP) 
				{
					state = eState.GRAB;
					sprite_index = sRussel_Grab;
					image_index = 0;
					SetSpiritMoveData(false, selectedCharacter.Grab, attack);
				}
			break;
			
			case 5:
				if (state != eState.JUMPSQUAT && movedir == 0 && verticalMoveDir == 0)
				{
					state = eState.NEUTRAL_SPECIAL;
					image_index = 0;
					SetSpiritMoveData(false, selectedCharacter.NeutralSpecial, attack);
				} 
				else if (state != eState.JUMPSQUAT && movedir != 0)
				{
					state = eState.SIDE_SPECIAL;
					image_index = 0;
					SetSpiritMoveData(false, selectedCharacter.SideSpecial, attack);
				}
				else if (verticalMoveDir == 1)
				{
					state = eState.UP_SPECIAL
					animTimer = 0;
					image_index = 0;
					SetSpiritMoveData(false, selectedCharacter.UpSpecial, attack);
				}
				else if (verticalMoveDir == -1 && state != eState.JUMPSQUAT)
				{
					state = eState.DOWN_SPECIAL
					animTimer = 0;
					image_index = 0;
					SetSpiritMoveData(false, selectedCharacter.DownSpecial, attack);
				}
			break;
			
			case 6:
				if (superMeter >= 50)
				{
					superMeter -= 50;
					state = eState.SUPER;
					image_index = 0;
					SetSpiritMoveData(false, selectedCharacter.Super, attack);
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
				SetSpiritMoveData(false, selectedCharacter.CommandNormal1, attack);
			}
		}
		if (variable_struct_exists(selectedCharacter, "CommandNormal2"))
		{
			if (attack == selectedCharacter.CommandNormal2.CommandNormalData.Button && inputDirection == selectedCharacter.CommandNormal2.CommandNormalData.NumpadDirection && grounded != selectedCharacter.CommandNormal2.CommandNormalData.GroundOrAir)
			{
				state = eState.COMMAND_NORMAL_2;
				SetSpiritMoveData(false, selectedCharacter.CommandNormal2, attack);
			}
		}
		if (variable_struct_exists(selectedCharacter, "CommandNormal3"))
		{
			if (attack == selectedCharacter.CommandNormal3.CommandNormalData.Button && inputDirection == selectedCharacter.CommandNormal3.CommandNormalData.NumpadDirection && grounded != selectedCharacter.CommandNormal3.CommandNormalData.GroundOrAir)
			{
				state = eState.COMMAND_NORMAL_3;
				SetSpiritMoveData(false, selectedCharacter.CommandNormal3, attack);
			}
		}
		
		
	// Clears the hitBy data to allow attacks to connect properly
	ds_list_clear(hitByGroup);
	if (hostObject != noone)
	{
		if (hostObject.target != noone)
		{
			ds_list_clear(hostObject.target.hitByGroup);
		}
	}
	else if (target != noone)
	{
		ds_list_clear(target.hitByGroup);
	}

	cancelable = false;
}