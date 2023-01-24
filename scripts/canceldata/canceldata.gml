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
					if _late LateCancelIntoMove(eState.STANDING_LIGHT_ATTACK, global.stRusselMoves.StandLight, _attack);
					else CancelIntoMove(eState.STANDING_LIGHT_ATTACK, global.stRusselMoves.StandLight.spriteID, 1);
				}
			}
			break;
		
			case eState.STANDING_LIGHT_ATTACK_2 : {
				if _attack == 1 && verticalMoveDir != -1 && grounded {
					if _late LateCancelIntoMove(eState.STANDING_LIGHT_ATTACK_2, global.stRusselMoves.StandLight2, _attack);
					else CancelIntoMove(eState.STANDING_LIGHT_ATTACK_2, global.stRusselMoves.StandLight2.spriteID, 1);
				}
			}
			break;
			
			case eState.STANDING_LIGHT_ATTACK_3 : {
				if _attack == 1 && verticalMoveDir != -1 && grounded {
					if _late LateCancelIntoMove(eState.STANDING_LIGHT_ATTACK_3, global.stRusselMoves.StandLight3, _attack);
					else CancelIntoMove(eState.STANDING_LIGHT_ATTACK_3, global.stRusselMoves.StandLight3.spriteID, 1);
				}
			}
			break;
			
			case eState.STANDING_MEDIUM_ATTACK : {
				if _attack == 2 && verticalMoveDir != -1 && grounded {
					if _late LateCancelIntoMove(eState.STANDING_MEDIUM_ATTACK, global.stRusselMoves.StandMedium, _attack);
					else CancelIntoMove(eState.STANDING_MEDIUM_ATTACK, global.stRusselMoves.StandMedium.spriteID, 1);
				}
			}
			break;
			
			case eState.STANDING_HEAVY_ATTACK : {
				if _attack == 3 && verticalMoveDir != -1 && grounded {
					if _late LateCancelIntoMove(eState.STANDING_HEAVY_ATTACK, global.stRusselMoves.StandHeavy, _attack);
					else CancelIntoMove(eState.STANDING_HEAVY_ATTACK, global.stRusselMoves.StandHeavy.spriteID, 1);
				}
			}
			break;
			
			// Crouching Attacks
			case eState.CROUCHING_LIGHT_ATTACK : {
				if _attack == 1 && verticalMoveDir == -1 && grounded {
					if _late LateCancelIntoMove(eState.CROUCHING_LIGHT_ATTACK, global.stRusselMoves.CrouchingLight, _attack);
					else CancelIntoMove(eState.CROUCHING_LIGHT_ATTACK, global.stRusselMoves.CrouchingLight.spriteID, 1);
				}
			}
			break;
			
			case eState.CROUCHING_MEDIUM_ATTACK : {
				if _attack == 2 && verticalMoveDir == -1 && grounded {
					if _late LateCancelIntoMove(eState.CROUCHING_MEDIUM_ATTACK, global.stRusselMoves.CrouchingMedium, _attack);
					else CancelIntoMove(eState.CROUCHING_MEDIUM_ATTACK, global.stRusselMoves.CrouchingMedium.spriteID, 1);
				}
			}
			break;
			
			case eState.CROUCHING_HEAVY_ATTACK : {
				if _attack == 3 && verticalMoveDir == -1 && grounded {
					if _late LateCancelIntoMove(eState.CROUCHING_HEAVY_ATTACK, global.stRusselMoves.CrouchingHeavy, _attack);
					else CancelIntoMove(eState.CROUCHING_HEAVY_ATTACK, global.stRusselMoves.CrouchingHeavy.spriteID, 1);
				}
			}
			break;
			
			// Specials
			case eState.NEUTRAL_SPECIAL : {
				if _attack == 5 && verticalMoveDir != -1 && movedir == 0{
					if _late LateCancelIntoMove(eState.NEUTRAL_SPECIAL, global.stRusselMoves.NeutralSpecial, _attack);
					else CancelIntoMove(eState.NEUTRAL_SPECIAL, global.stRusselMoves.NeutralSpecial.spriteID, 1);
				}
			}
			break;
			 
			 case eState.SIDE_SPECIAL : {
				if _attack == 5 && verticalMoveDir != -1 && movedir != 0{
					if _late LateCancelIntoMove(eState.SIDE_SPECIAL, global.stRusselMoves.SideSpecial, _attack);
					else CancelIntoMove(eState.SIDE_SPECIAL, global.stRusselMoves.SideSpecial.spriteID, 1);
				}
			}
			break;
		}
	}
}