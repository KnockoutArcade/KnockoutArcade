// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CancelData(_array, _attack, _late)
{
	// Convert the player's input direction into numpad notation
	#region
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
	#endregion
	// Check to see if the player has inputted an attack AND if the inputted attack is a valid cancel
	
	// Side Special
	if ((_array.MoveCanCancelInto & 8 == 8) && (_attack == 5 && movedir != 0 && verticalMoveDir == 0))
	{
		if (_late)
		{
			LateCancelIntoMove(eState.SIDE_SPECIAL, selectedCharacter.SideSpecial, _attack);
		}
		else
		{
		 	CancelIntoMove(eState.SIDE_SPECIAL, selectedCharacter.SideSpecial.SpriteId, 1);
		}
	}
	// Neutral Special
	else if ((_array.MoveCanCancelInto & 16 == 16) && (_attack == 5 && movedir == 0 && verticalMoveDir == 0))
	{
		if (_late)
			{
				LateCancelIntoMove(eState.NEUTRAL_SPECIAL, selectedCharacter.NeutralSpecial, _attack);
			}
		else
			{
				CancelIntoMove(eState.NEUTRAL_SPECIAL, selectedCharacter.NeutralSpecial.SpriteId, 1);
			}
	}
	// Standing Light 1
	else if ((_array.MoveCanCancelInto & 32 == 32) && (_attack == 1 && verticalMoveDir == 0) && grounded)
	{
		if (_late)
			{
				LateCancelIntoMove(eState.STANDING_LIGHT_ATTACK, selectedCharacter.StandLight, _attack);
			}
		else
			{
				CancelIntoMove(eState.STANDING_LIGHT_ATTACK, selectedCharacter.StandLight.SpriteId, 1);
			}
	}
	// Standing Light 2
	else if ((_array.MoveCanCancelInto & 64 == 64) && (_attack == 1 && verticalMoveDir == 0) && grounded)
	{
		if (_late)
			{
				LateCancelIntoMove(eState.STANDING_LIGHT_ATTACK_2, selectedCharacter.StandLight2, _attack);
			}
		else
			{
				CancelIntoMove(eState.STANDING_LIGHT_ATTACK_2, selectedCharacter.StandLight2.SpriteId, 1);
			}
	}
	// Standing Light 3
	else if ((_array.MoveCanCancelInto & 128 == 128) && (_attack == 1 && verticalMoveDir == 0) && grounded)
	{
		if (_late)
			{
				LateCancelIntoMove(eState.STANDING_LIGHT_ATTACK_3, selectedCharacter.StandLight3, _attack);
			}
		else
			{
				CancelIntoMove(eState.STANDING_LIGHT_ATTACK_3, selectedCharacter.StandLight3.SpriteId, 1);
			}
	}
	// Standing Medium
	else if ((_array.MoveCanCancelInto & 256 == 256) && (_attack == 2 && verticalMoveDir == 0) && grounded)
		{
			if (_late)
			{
				LateCancelIntoMove(eState.STANDING_MEDIUM_ATTACK, selectedCharacter.StandMedium, _attack);
			}
			else
			{
				CancelIntoMove(eState.STANDING_MEDIUM_ATTACK, selectedCharacter.StandMedium.SpriteId, 1);
			}
		}
	// Standing Heavy
	else if ((_array.MoveCanCancelInto & 512 == 512) && (_attack == 3 && verticalMoveDir == 0) && grounded)
		{
			if (_late)
			{
				LateCancelIntoMove(eState.STANDING_HEAVY_ATTACK, selectedCharacter.StandHeavy, _attack);
			}
			else
			{
				CancelIntoMove(eState.STANDING_HEAVY_ATTACK, selectedCharacter.StandHeavy.SpriteId, 1);
			}
		}
	// Crouching Light
	else if ((_array.MoveCanCancelInto & 1024 == 1024) && (_attack == 1 && verticalMoveDir == -1) && grounded)
		{
			if (_late)
			{
				LateCancelIntoMove(eState.CROUCHING_LIGHT_ATTACK, selectedCharacter.CrouchingLight, _attack);
			}
			else
			{
				CancelIntoMove(eState.CROUCHING_LIGHT_ATTACK, selectedCharacter.CrouchingLight.SpriteId, 1);
			}
		}
	// Crouching Medium
	else if ((_array.MoveCanCancelInto & 2048 == 2048) && (_attack == 2 && verticalMoveDir == -1) && grounded)
		{
			if (_late)
			{
				LateCancelIntoMove(eState.CROUCHING_MEDIUM_ATTACK, selectedCharacter.CrouchingMedium, _attack);
			}
			else
			{
				CancelIntoMove(eState.CROUCHING_MEDIUM_ATTACK, selectedCharacter.CrouchingMedium.SpriteId, 1);
			}
		}
	// Crouching Heavy
	else if ((_array.MoveCanCancelInto & 4096 == 4096) && (_attack == 3 && verticalMoveDir == -1) && grounded)
		{
			if (_late)
			{
				LateCancelIntoMove(eState.CROUCHING_HEAVY_ATTACK, selectedCharacter.CrouchingHeavy, _attack);
			}
			else
			{
				CancelIntoMove(eState.CROUCHING_HEAVY_ATTACK, selectedCharacter.CrouchingHeavy.SpriteId, 1);
			}
		}
	// Jumping Light
	else if ((_array.MoveCanCancelInto & 8192 == 8192) && (_attack == 1) && !grounded)
		{
			if (_late)
			{
				LateCancelIntoMove(eState.JUMPING_LIGHT_ATTACK, selectedCharacter.JumpingLight, _attack);
			}
			else
			{
				CancelIntoMove(eState.JUMPING_LIGHT_ATTACK, selectedCharacter.JumpingLight.SpriteId, 1);
			}
		}
	// Jumping Medium
	else if ((_array.MoveCanCancelInto & 16384 == 16384) && (_attack == 2) && !grounded)
		{
			if (_late)
			{
				LateCancelIntoMove(eState.JUMPING_MEDIUM_ATTACK, selectedCharacter.JumpingMedium, _attack);
			}
			else
			{
				CancelIntoMove(eState.JUMPING_MEDIUM_ATTACK, selectedCharacter.JumpingMedium.SpriteId, 1);
			}
		}
	// Jumping Heavy
	else if ((_array.MoveCanCancelInto & 32768 == 32768) && (_attack == 3) && !grounded)
		{
			if (_late)
			{
				LateCancelIntoMove(eState.JUMPING_HEAVY_ATTACK, selectedCharacter.JumpingHeavy, _attack);
			}
			else
			{
				CancelIntoMove(eState.JUMPING_HEAVY_ATTACK, selectedCharacter.JumpingHeavy.SpriteId, 1);
			}
		}
	// Up Special
	else if ((_array.MoveCanCancelInto & 65536 == 65536) && (_attack == 5 && movedir == 0 && verticalMoveDir == 1))
	{
		if (_late)
		{
			LateCancelIntoMove(eState.UP_SPECIAL, selectedCharacter.UpSpecial, _attack);
		}
		else
		{
			CancelIntoMove(eState.UP_SPECIAL, selectedCharacter.UpSpecial.SpriteId, 1);
		}
	}
	// Down Special
	else if ((_array.MoveCanCancelInto & 131072 == 131072) && (_attack == 5 && movedir == 0 && verticalMoveDir == -1))
	{
		if (_late)
		{
			LateCancelIntoMove(eState.DOWN_SPECIAL, selectedCharacter.DownSpecial, _attack);
		}
		else
		{
			CancelIntoMove(eState.DOWN_SPECIAL, selectedCharacter.DownSpecial.SpriteId, 1);
		}
	}
	// Super
	else if ((_array.MoveCanCancelInto & 4194304 == 4194304) && (_attack == 6 && superMeter >= 50))
	{
		if (_late)
		{
			LateCancelIntoMove(eState.SUPER, selectedCharacter.Super, _attack);
		}
		else
		{
			superMeter -= 50;
			CancelIntoMove(eState.SUPER, selectedCharacter.Super.SpriteId, 1);
		}
	}
	
	
	// Command Normal 1
	if (variable_struct_exists(selectedCharacter, "CommandNormal1"))
	{
		if ((_array.MoveCanCancelInto & 524288 == 524288) && (_attack == selectedCharacter.CommandNormal1.CommandNormalData.Button && inputDirection == selectedCharacter.CommandNormal1.CommandNormalData.NumpadDirection && grounded != selectedCharacter.CommandNormal1.CommandNormalData.GroundOrAir))
		{
			if (_late)
			{
				LateCancelIntoMove(eState.COMMAND_NORMAL_1, selectedCharacter.CommandNormal1, _attack);
			}
			else
			{
				CancelIntoMove(eState.COMMAND_NORMAL_1, selectedCharacter.CommandNormal1.SpriteId, 1);
			}
		}
	}
	// Command Normal 2
	if (variable_struct_exists(selectedCharacter, "CommandNormal2"))
	{
		if ((_array.MoveCanCancelInto & 1048576 == 1048576) && (_attack == selectedCharacter.CommandNormal2.CommandNormalData.Button && inputDirection == selectedCharacter.CommandNormal2.CommandNormalData.NumpadDirection && grounded != selectedCharacter.CommandNormal2.CommandNormalData.GroundOrAir))
		{
			if (_late)
			{
				LateCancelIntoMove(eState.COMMAND_NORMAL_2, selectedCharacter.CommandNormal2, _attack);
			}
			else
			{
				CancelIntoMove(eState.COMMAND_NORMAL_2, selectedCharacter.CommandNormal2.SpriteId, 1);
			}
		}
	}
	// Command Normal 3
	if (variable_struct_exists(selectedCharacter, "CommandNormal3"))
	{
		if ((_array.MoveCanCancelInto & 2097152 == 2097152) && (_attack == selectedCharacter.CommandNormal3.CommandNormalData.Button && inputDirection == selectedCharacter.CommandNormal3.CommandNormalData.NumpadDirection && grounded != selectedCharacter.CommandNormal3.CommandNormalData.GroundOrAir))
		{
			if (_late)
			{
				LateCancelIntoMove(eState.COMMAND_NORMAL_3, selectedCharacter.CommandNormal3, _attack);
			}
			else
			{
				CancelIntoMove(eState.COMMAND_NORMAL_3, selectedCharacter.CommandNormal3.SpriteId, 1);
			}
		}
	}
}
