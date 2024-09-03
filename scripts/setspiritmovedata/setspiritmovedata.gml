// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Update the spirit's move whenever the host performs an attack
function SetSpiritMoveData(moveState)
{
	/*
	switch (moveState)
	{
		#region Lights
		case eState.STANDING_LIGHT_ATTACK:
		{
			moveToPerform = selectedCharacter.StandLight;
		}
		break;
		case eState.STANDING_LIGHT_ATTACK_2:
		{
			moveToPerform = selectedCharacter.StandLight2;
		}
		break;
		case eState.STANDING_LIGHT_ATTACK_3:
		{
			moveToPerform = selectedCharacter.StandLight3;
		}
		break;
		case eState.JUMPING_LIGHT_ATTACK:
		{
			moveToPerform = selectedCharacter.JumpingLight;
		}
		break;
		case eState.CROUCHING_LIGHT_ATTACK:
		{
			moveToPerform = selectedCharacter.CrouchingLight;
		}
		break;
		#endregion
		
		#region Mediums
		case eState.STANDING_MEDIUM_ATTACK:
		{
			moveToPerform = selectedCharacter.StandMedium;
		}
		break;
		case eState.JUMPING_MEDIUM_ATTACK:
		{
			moveToPerform = selectedCharacter.JumpingMedium;
		}
		break;
		case eState.CROUCHING_MEDIUM_ATTACK:
		{
			moveToPerform = selectedCharacter.CrouchingMedium;
		}
		break;
		#endregion
		
		#region Heavies
		case eState.STANDING_HEAVY_ATTACK:
		{
			moveToPerform = selectedCharacter.StandHeavy;
		}
		break;
		case eState.JUMPING_HEAVY_ATTACK:
		{
			moveToPerform = selectedCharacter.JumpingHeavy;
		}
		break;
		case eState.CROUCHING_HEAVY_ATTACK:
		{
			moveToPerform = selectedCharacter.CrouchingHeavy;
		}
		break;
		#endregion
		
		#region Specials
		case eState.NEUTRAL_SPECIAL:
		{
			moveToPerform = selectedCharacter.StandHeavy;
		}
		break;
		case eState.ENHANCED_NEUTRAL_SPECIAL:
		{
			moveToPerform = selectedCharacter.StandHeavy;
		}
		break;
		case eState.ENHANCED_NEUTRAL_SPECIAL_2:
		{
			moveToPerform = selectedCharacter.StandHeavy;
		}
		break;
		#endregion
	}
	*/
	
	/*
	if (spirit != noone && spiritON && move.SpiritData.PerformAttack)
	{
		spiritObject.spiritState = eSpiritState.ATTACK;
		
		switch (attack)
		{
			case 1:
			{
				if (prevState == eState.STANDING_LIGHT_ATTACK_2)
				{ 
					spiritObject.moveToPerform = spiritObject.selectedCharacter.StandLight2;
				}
				else if (prevState == eState.STANDING_LIGHT_ATTACK_3)
				{
					spiritObject.moveToPerform = spiritObject.selectedCharacter.StandLight3;
				}
				else if (state == eState.JUMPING || state == eState.RUSH_CANCEL_UP)
				{
					spiritObject.moveToPerform = spiritObject.selectedCharacter.JumpingLight;
				}
				else if (verticalMoveDir = -1)
				{
					spiritObject.moveToPerform = spiritObject.selectedCharacter.CrouchingLight;
				}
				else if (state != eState.JUMPSQUAT)
				{ 
					spiritObject.moveToPerform = spiritObject.selectedCharacter.StandLight;
				}
			}
			break;
		}
		
		
		spiritObject.attack = attack;
		spiritObject.animTimer = 1;
	}
	if (move.SpiritData.ReturnToPlayer && spiritON) 
	{
		spiritObject.nextToPlayer = true;
	}
	*/
}