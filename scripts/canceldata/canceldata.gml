// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CancelData(_array, _attack, _late){
	
	for (var i = 0; i < array_length(_array); i++;) {
		switch _array[i] {
			case -1 : {
			
			}
			break;
			
			case eState.STANDING_LIGHT_ATTACK : {
				if _attack == 1 && verticalMoveDir != -1 && grounded {
					if _late LateCancelIntoMove(eState.STANDING_LIGHT_ATTACK, global.stRusselMoves.stRusselStandLight, _attack);
					else CancelIntoMove(eState.STANDING_LIGHT_ATTACK, global.stRusselMoves.stRusselStandLight.spriteID, 1);
				}
			}
			break;
		
			case eState.STANDING_LIGHT_ATTACK_2 : {
				if _attack == 1 && verticalMoveDir != -1 && grounded {
					if _late LateCancelIntoMove(eState.STANDING_LIGHT_ATTACK_2, global.stRusselMoves.stRusselStandLight2, _attack);
					else CancelIntoMove(eState.STANDING_LIGHT_ATTACK_2, global.stRusselMoves.stRusselStandLight2.spriteID, 1);
				}
			}
			break;
			
			case eState.STANDING_LIGHT_ATTACK_3 : {
				if _attack == 1 && verticalMoveDir != -1 && grounded {
					if _late LateCancelIntoMove(eState.STANDING_LIGHT_ATTACK_3, global.stRusselMoves.stRusselStandLight3, _attack);
					else CancelIntoMove(eState.STANDING_LIGHT_ATTACK_3, global.stRusselMoves.stRusselStandLight3.spriteID, 1);
				}
			}
			break;
			
			case eState.STANDING_MEDIUM_ATTACK : {
				if _attack == 2 && verticalMoveDir != -1 && grounded {
					if _late LateCancelIntoMove(eState.STANDING_MEDIUM_ATTACK, global.stRusselMoves.stRusselStandMedium, _attack);
					else CancelIntoMove(eState.STANDING_MEDIUM_ATTACK, global.stRusselMoves.stRusselStandMedium.spriteID, 1);
				}
			}
			break;
			
			case eState.STANDING_HEAVY_ATTACK : {
				if _attack == 3 && verticalMoveDir != -1 && grounded {
					if _late LateCancelIntoMove(eState.STANDING_HEAVY_ATTACK, global.stRusselMoves.stRusselStandHeavy, _attack);
					else CancelIntoMove(eState.STANDING_HEAVY_ATTACK, global.stRusselMoves.stRusselStandHeavy.spriteID, 1);
				}
			}
			break;
			
			// Crouching Attacks
			case eState.CROUCHING_LIGHT_ATTACK : {
				if _attack == 1 && verticalMoveDir == -1 && grounded {
					if _late LateCancelIntoMove(eState.CROUCHING_LIGHT_ATTACK, global.stRusselMoves.stRusselCrouchingLight, _attack);
					else CancelIntoMove(eState.CROUCHING_LIGHT_ATTACK, global.stRusselMoves.stRusselCrouchingLight.spriteID, 1);
				}
			}
			break;
			
			case eState.CROUCHING_MEDIUM_ATTACK : {
				if _attack == 2 && verticalMoveDir == -1 && grounded {
					if _late LateCancelIntoMove(eState.CROUCHING_MEDIUM_ATTACK, global.stRusselMoves.stRusselCrouchingMedium, _attack);
					else CancelIntoMove(eState.CROUCHING_MEDIUM_ATTACK, global.stRusselMoves.stRusselCrouchingMedium.spriteID, 1);
				}
			}
			break;
			
			case eState.CROUCHING_HEAVY_ATTACK : {
				if _attack == 3 && verticalMoveDir == -1 && grounded {
					if _late LateCancelIntoMove(eState.CROUCHING_HEAVY_ATTACK, global.stRusselMoves.stRusselCrouchingHeavy, _attack);
					else CancelIntoMove(eState.CROUCHING_HEAVY_ATTACK, global.stRusselMoves.stRusselCrouchingHeavy.spriteID, 1);
				}
			}
			break;
			
			// Specials
			case eState.NEUTRAL_SPECIAL : {
				if _attack == 5 && verticalMoveDir != -1 && movedir == 0{
					if _late LateCancelIntoMove(eState.NEUTRAL_SPECIAL, global.stRusselMoves.stRusselNeutralSpecial, _attack);
					else CancelIntoMove(eState.NEUTRAL_SPECIAL, global.stRusselMoves.stRusselNeutralSpecial.spriteID, 1);
				}
			}
			break;
			 
			 case eState.SIDE_SPECIAL : {
				if _attack == 5 && verticalMoveDir != -1 && movedir != 0{
					if _late LateCancelIntoMove(eState.SIDE_SPECIAL, global.stRusselMoves.stRusselSideSpecial, _attack);
					else CancelIntoMove(eState.SIDE_SPECIAL, global.stRusselMoves.stRusselSideSpecial.spriteID, 1);
				}
			}
			break;
		}
	}
}