// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CancelData(_array, _attack, _late)
{
	
	for (var i = 0; i < array_length(_array); i++;) {
		switch _array[i] {
			case -1 : {
			
			}
			break;
			
			case eState.STANDING_LIGHT_ATTACK : {
				if (_attack == 1 && verticalMoveDir != -1 && grounded) 
				{
					if (_late)
					{
						LateCancelIntoMove(eState.STANDING_LIGHT_ATTACK, selectedCharacter.StandLight, _attack);
					}
					else
					{ 
						CancelIntoMove(eState.STANDING_LIGHT_ATTACK, selectedCharacter.StandLight.spriteID, 1);
					}
				}
			}
			break;
		
			case eState.STANDING_LIGHT_ATTACK_2 : {
				if (_attack == 1 && verticalMoveDir != -1 && grounded) 
				{
					if (_late)
					{
						LateCancelIntoMove(eState.STANDING_LIGHT_ATTACK_2, selectedCharacter.StandLight2, _attack);
					}
					else
					{
						CancelIntoMove(eState.STANDING_LIGHT_ATTACK_2, selectedCharacter.StandLight2.spriteID, 1);
					}
				}
			}
			break;
			
			case eState.STANDING_LIGHT_ATTACK_3 : {
				if (_attack == 1 && verticalMoveDir != -1 && grounded) 
				{
					if (_late)
					{ 
						LateCancelIntoMove(eState.STANDING_LIGHT_ATTACK_3, selectedCharacter.StandLight3, _attack);
					}
					else
					{
					 	CancelIntoMove(eState.STANDING_LIGHT_ATTACK_3, selectedCharacter.StandLight3.spriteID, 1);
					}
				}
			}
			break;
			
			case eState.STANDING_MEDIUM_ATTACK : {
				if (_attack == 2 && verticalMoveDir != -1 && grounded) 
				{
					if (_late)
					{ 
						LateCancelIntoMove(eState.STANDING_MEDIUM_ATTACK, selectedCharacter.StandMedium, _attack);
					}
					else
					{
						CancelIntoMove(eState.STANDING_MEDIUM_ATTACK, selectedCharacter.StandMedium.spriteID, 1);
					}
				}
			}
			break;
			
			case eState.STANDING_HEAVY_ATTACK : {
				if (_attack == 3 && verticalMoveDir != -1 && grounded) 
				{
					if (_late) 
					{
						LateCancelIntoMove(eState.STANDING_HEAVY_ATTACK, selectedCharacter.StandHeavy, _attack);
					}
					else
					{
					 	CancelIntoMove(eState.STANDING_HEAVY_ATTACK, selectedCharacter.StandHeavy.spriteID, 1);
					}
				}
			}
			break;
			
			// Crouching Attacks
			case eState.CROUCHING_LIGHT_ATTACK : {
				if (_attack == 1 && verticalMoveDir == -1 && grounded) 
				{
					if (_late)
					{ 
						LateCancelIntoMove(eState.CROUCHING_LIGHT_ATTACK, selectedCharacter.CrouchingLight, _attack);
					}
					else
					{
						CancelIntoMove(eState.CROUCHING_LIGHT_ATTACK, selectedCharacter.CrouchingLight.spriteID, 1);
					}
				}
			}
			break;
			
			case eState.CROUCHING_MEDIUM_ATTACK : {
				if (_attack == 2 && verticalMoveDir == -1 && grounded)
				{
					if (_late)
					{
						LateCancelIntoMove(eState.CROUCHING_MEDIUM_ATTACK, selectedCharacter.CrouchingMedium, _attack);
					}
					else
					{
						CancelIntoMove(eState.CROUCHING_MEDIUM_ATTACK, selectedCharacter.CrouchingMedium.spriteID, 1);
					}
				}
			}
			break;
			
			case eState.CROUCHING_HEAVY_ATTACK : {
				if (_attack == 3 && verticalMoveDir == -1 && grounded) 
				{
					if (_late)
					{
						LateCancelIntoMove(eState.CROUCHING_HEAVY_ATTACK, selectedCharacter.CrouchingHeavy, _attack);
					}
					else
					{
						CancelIntoMove(eState.CROUCHING_HEAVY_ATTACK, selectedCharacter.CrouchingHeavy.spriteID, 1);
					}
				}
			}
			break;
			
			// Specials
			case eState.NEUTRAL_SPECIAL : {
				if (_attack == 5 && verticalMoveDir != -1 && movedir == 0)
				{
					if (_late)
					{
						LateCancelIntoMove(eState.NEUTRAL_SPECIAL, selectedCharacter.NeutralSpecial, _attack);
					}
					else
					{
						CancelIntoMove(eState.NEUTRAL_SPECIAL, selectedCharacter.NeutralSpecial.spriteID, 1);
					}
				}
			}
			break;
			 
			 case eState.SIDE_SPECIAL : {
				if (_attack == 5 && verticalMoveDir != -1 && movedir != 0)
				{
					if (_late)
					{
						LateCancelIntoMove(eState.SIDE_SPECIAL, selectedCharacter.SideSpecial, _attack);
					}
					else
					{
					 	CancelIntoMove(eState.SIDE_SPECIAL, selectedCharacter.SideSpecial.spriteID, 1);
					}
				}
			}
			break;
		}
	}
}