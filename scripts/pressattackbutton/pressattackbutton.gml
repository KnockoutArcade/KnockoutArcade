// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PressAttackButton(attack, _late = false)
{	
		// Debug
		//if (attack != 0) show_debug_message("Pressed " + string(attack));
		
		// Input Normal attacks first
		switch attack 
		{
			case 1:
				if (prevState == eState.STANDING_LIGHT_ATTACK_2 && _late)
				{ 
					state = eState.STANDING_LIGHT_ATTACK_2;
					sprite_index = selectedCharacter.StandLight2.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
				else if (prevState == eState.STANDING_LIGHT_ATTACK_3 && _late)
				{
					state = eState.STANDING_LIGHT_ATTACK_3;
					sprite_index = selectedCharacter.StandLight3.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
				else if (state == eState.JUMPING || state == eState.RUSH_CANCEL_UP)
				{
					state = eState.JUMPING_LIGHT_ATTACK;
					sprite_index = selectedCharacter.JumpingLight.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
				else if (verticalMoveDir = -1)
				{
					state = eState.CROUCHING_LIGHT_ATTACK;
					sprite_index = selectedCharacter.CrouchingLight.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
				else if (state != eState.JUMPSQUAT)
				{ 
					state = eState.STANDING_LIGHT_ATTACK;
					image_index = 0;
					sprite_index = selectedCharacter.StandLight.SpriteId;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
				else
				{
					jumpAttackBuffer = eState.JUMPING_LIGHT_ATTACK;
					//SetSpiritMoveData(false, selectedCharacter.JumpingLight, attack);
				}
			break;
		
			case 2:
				if (state == eState.JUMPING || state == eState.RUSH_CANCEL_UP) 
				{
					state = eState.JUMPING_MEDIUM_ATTACK;
					sprite_index = selectedCharacter.JumpingMedium.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
				else if (verticalMoveDir == -1)
				{
					state = eState.CROUCHING_MEDIUM_ATTACK;
					sprite_index = selectedCharacter.CrouchingMedium.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
				else if (state != eState.JUMPSQUAT)
				{
					state = eState.STANDING_MEDIUM_ATTACK;
					sprite_index = selectedCharacter.StandMedium.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
				else
				{
					jumpAttackBuffer = eState.JUMPING_MEDIUM_ATTACK;
				}
			break;
			
			case 3:
				if (state == eState.JUMPING || state == eState.RUSH_CANCEL_UP)
				{
				 	state = eState.JUMPING_HEAVY_ATTACK;
					sprite_index = selectedCharacter.JumpingHeavy.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
				else if (verticalMoveDir == -1)
				{
					state = eState.CROUCHING_HEAVY_ATTACK;
					sprite_index = selectedCharacter.CrouchingHeavy.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
				else if (state != eState.JUMPSQUAT)
				{
					state = eState.STANDING_HEAVY_ATTACK;
					sprite_index = selectedCharacter.StandHeavy.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
				else
				{
					jumpAttackBuffer = eState.JUMPING_HEAVY_ATTACK;
				}
			break;
			
			case 4:
				if (state != eState.JUMPING && state != eState.JUMPSQUAT && state != eState.RUSH_CANCEL_UP) 
				{
					state = eState.GRAB;
					sprite_index = selectedCharacter.Grab.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
			break;
			
			case 5:
				if (state != eState.JUMPSQUAT && movedir == 0 && verticalMoveDir == 0 && !hasUsedAirNeutralSpecial)
				{
					state = eState.NEUTRAL_SPECIAL;
					sprite_index = selectedCharacter.NeutralSpecial.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					// reset special move enhancers
					ResetEnhancer();
					
					
				} 
				else if (state != eState.JUMPSQUAT && movedir != 0 && verticalMoveDir == 0 && !hasUsedAirSideSpecial)
				{
					state = eState.SIDE_SPECIAL;
					sprite_index = selectedCharacter.SideSpecial.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					// reset special move enhancers
					ResetEnhancer();
					
					// Special rule for singleplayer: Turn around to face the inputted direction
					if (global.gameMode == GAMEMODE.PLATFORMING)
					{
						image_xscale = movedir;
					}
					
					
				}
				else if (verticalMoveDir == 1 && !hasUsedAirUpSpecial)
				{
					state = eState.UP_SPECIAL
					sprite_index = selectedCharacter.UpSpecial.SpriteId;
					image_index = 0;
					
					// Special rule for singleplayer: Turn around to face the inputted direction
					if (global.gameMode == GAMEMODE.PLATFORMING && movedir != 0)
					{
						image_xscale = movedir;
					}
					
					// reset special move enhancers
					ResetEnhancer();
					
					// reset anim timer
					animTimer = 0;
					
					
				}
				else if (verticalMoveDir == -1 && state != eState.JUMPSQUAT && !hasUsedAirDownSpecial)
				{
					state = eState.DOWN_SPECIAL
					sprite_index = selectedCharacter.DownSpecial.SpriteId;
					image_index = 0;
					
					// Special rule for singleplayer: Turn around to face the inputted direction
					if (global.gameMode == GAMEMODE.PLATFORMING && movedir != 0)
					{
						image_xscale = movedir;
					}
					
					// reset anim timer
					animTimer = 0;
					
					// reset special move enhancers
					ResetEnhancer();
					
					
				}
			break;
			
			case 6:
				if (superMeter >= 50 && !timeStopActivated && !spiritBroken)
				{
					superMeter -= 50;
					state = eState.SUPER;
					sprite_index = selectedCharacter.Super.SpriteId;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
					
					
				}
			break;
			
			case 7: // Taunt
			{
				if (grounded && selectedCharacter.Name == "Russel")
				{
					state = eState.TAUNT;
					sprite_index = sRussel_Taunt;
					image_index = 0;
					
					// reset anim timer
					animTimer = 0;
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
				sprite_index = selectedCharacter.CommandNormal1.SpriteId;
				image_index = 0;
					
				// reset anim timer
				animTimer = 0;
					
				
			}
		}
		if (variable_struct_exists(selectedCharacter, "CommandNormal2"))
		{
			if (attack == selectedCharacter.CommandNormal2.CommandNormalData.Button && inputDirection == selectedCharacter.CommandNormal2.CommandNormalData.NumpadDirection && grounded != selectedCharacter.CommandNormal2.CommandNormalData.GroundOrAir)
			{
				state = eState.COMMAND_NORMAL_2;
				sprite_index = selectedCharacter.CommandNormal2.SpriteId;
				image_index = 0;
					
				// reset anim timer
				animTimer = 0;
					
				
			}
		}
		if (variable_struct_exists(selectedCharacter, "CommandNormal3"))
		{
			if (attack == selectedCharacter.CommandNormal3.CommandNormalData.Button && inputDirection == selectedCharacter.CommandNormal3.CommandNormalData.NumpadDirection && grounded != selectedCharacter.CommandNormal3.CommandNormalData.GroundOrAir)
			{
				state = eState.COMMAND_NORMAL_3;
				sprite_index = selectedCharacter.CommandNormal3.SpriteId;
				image_index = 0;
					
				// reset anim timer
				animTimer = 0;
					
				
			}
		}
		
		
	// Clears the hitBy data to allow attacks to connect properly
	//ds_list_clear(hitByGroup);
	if (hostObject != noone)
	{
		if (hostObject.target != noone)
		{
			ds_list_clear(hostObject.target.hitByGroup);
		}
	}
	else
	{
		ClearVictimHitByGroups();
	}

	cancelable = false;
}