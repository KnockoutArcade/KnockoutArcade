// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// This funtion returns the move that corresponds with the player's current state.
// This makes it easier to determine which move's cancel data to use for the
// current attack.

function FindAttackState(stateToSearch){
	switch (stateToSearch)
	{
		case eState.STANDING_LIGHT_ATTACK : 
		{
			return selectedCharacter.StandLight;
		}
		break;
	
		case eState.STANDING_LIGHT_ATTACK_2 : 
		{
			return selectedCharacter.StandLight2;
		}
		break;
		
		case eState.STANDING_LIGHT_ATTACK_3 : 
		{
			return selectedCharacter.StandLight3;
		}
		break;
		
		case eState.STANDING_MEDIUM_ATTACK : 
		{
			return selectedCharacter.StandMedium;
		}
		break;
		
		case eState.STANDING_HEAVY_ATTACK : 
		{
			return selectedCharacter.StandHeavy;
		}
		break;
			
		// Crouching Attacks
		case eState.CROUCHING_LIGHT_ATTACK : 
		{
			return selectedCharacter.CrouchingLight;
		}
		break;
		
		case eState.CROUCHING_MEDIUM_ATTACK : 
		{
			return selectedCharacter.CrouchingMedium;
		}
		break;
		
		case eState.CROUCHING_HEAVY_ATTACK : 
		{
			return selectedCharacter.CrouchingHeavy;
		}
		break;
		
		// Jumping Attacks
		case eState.JUMPING_LIGHT_ATTACK : 
		{
			return selectedCharacter.JumpingLight;
		}
		break;
		
		case eState.JUMPING_MEDIUM_ATTACK : 
		{
			return selectedCharacter.JumpingMedium;
		}
		break;
		
		case eState.JUMPING_HEAVY_ATTACK : 
		{
			return selectedCharacter.JumpingHeavy;
		}
		break;
		
		//Throws
		case eState.FORWARD_THROW : 
		{
			return selectedCharacter.ForwardThrow;
		}
		break;
		
		case eState.BACKWARD_THROW : 
		{
			return selectedCharacter.BackwardThrow;
		}
		break;
		
		// Command Normals
		case eState.COMMAND_NORMAL_1 : 
		{
			return selectedCharacter.CommandNormal1;
		}
		break;
		case eState.COMMAND_NORMAL_2 : 
		{
			return selectedCharacter.CommandNormal2;
		}
		break;
		case eState.COMMAND_NORMAL_3 : 
		{
			return selectedCharacter.CommandNormal3;
		}
		break;
		
		// Specials
		case eState.NEUTRAL_SPECIAL : 
		{
			return selectedCharacter.NeutralSpecial;
		}
		break;
		 
		case eState.SIDE_SPECIAL : 
		{
			return selectedCharacter.SideSpecial;
		}
		break;
		
		case eState.UP_SPECIAL : 
		{
			return selectedCharacter.UpSpecial;
		}
		break;
		
		case eState.DOWN_SPECIAL : 
		{
			return selectedCharacter.DownSpecial;
		}
		break;
		
		// Enhanced Specials
		case eState.ENHANCED_NEUTRAL_SPECIAL : 
		{
			return selectedCharacter.EnhancedNeutralSpecial;
		}
		break;
		 
		case eState.ENHANCED_SIDE_SPECIAL : 
		{
			return selectedCharacter.EnhancedSideSpecial;
		}
		break;
		
		case eState.ENHANCED_UP_SPECIAL : 
		{
			return selectedCharacter.EnhancedUpSpecial;
		}
		break;
		
		case eState.ENHANCED_DOWN_SPECIAL : 
		{
			return selectedCharacter.EnhancedDownSpecial;
		}
		break;
		case eState.ENHANCED_NEUTRAL_SPECIAL_2 : 
		{
			return selectedCharacter.EnhancedNeutralSpecial2;
		}
		break;
		 
		case eState.ENHANCED_SIDE_SPECIAL_2 : 
		{
			return selectedCharacter.EnhancedSideSpecial2;
		}
		break;
		
		case eState.ENHANCED_UP_SPECIAL_2 : 
		{
			return selectedCharacter.EnhancedUpSpecial2;
		}
		break;
		
		case eState.ENHANCED_DOWN_SPECIAL_2 : 
		{
			return selectedCharacter.EnhancedDownSpecial2;
		}
		break;
		
		// Rekka States
		case eState.REKKA_LAUNCHER : 
		{
			return selectedCharacter.RekkaLauncher;
		}
		break;
		 
		case eState.REKKA_FINISHER : 
		{
			return selectedCharacter.RekkaFinisher;
		}
		break;
		
		case eState.REKKA_CONNECTER : 
		{
			return selectedCharacter.RekkaConnecter;
		}
		break;
		
		case eState.REKKA_LOW : 
		{
			return selectedCharacter.RekkaLow;
		}
		break;
		
		case eState.REKKA_HIGH : 
		{
			return selectedCharacter.RekkaHigh;
		}
		break;
		
		// Default Case
		default:
		{
			return -1;
		}
		break;
	}
}