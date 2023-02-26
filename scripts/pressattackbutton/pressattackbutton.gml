// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PressAttackButton(attack)
{
	
	
		switch attack 
		{
			case 1:
				if (prevState == eState.STANDING_LIGHT_ATTACK_2)
				{ 
				state = eState.STANDING_LIGHT_ATTACK_2;
				}
				else if (prevState == eState.STANDING_LIGHT_ATTACK_3)
				{
					state = eState.STANDING_LIGHT_ATTACK_3;
				}
				else if (state == eState.JUMPING)
				{
					state = eState.JUMPING_LIGHT_ATTACK;
				}
				else if (verticalMoveDir = -1)
				{
					state = eState.CROUCHING_LIGHT_ATTACK;
				}
				else
				{ 
					state = eState.STANDING_LIGHT_ATTACK;
					image_index = 0;
				}
				
				// Clears the hitBy data to allow attacks to connect properly
				ds_list_clear(hitByGroup);
				ds_list_clear(opponent.hitByGroup);
			break;
		
			case 2:
				if (state == eState.JUMPING) 
				{
					state = eState.JUMPING_MEDIUM_ATTACK;
				}
				else if (verticalMoveDir == -1)
				{
					state = eState.CROUCHING_MEDIUM_ATTACK;
				}
				else
				{
					state = eState.STANDING_MEDIUM_ATTACK;
					image_index = 0;
				}
				// Clears the hitBy data to allow attacks to connect properly
				ds_list_clear(hitByGroup);
				ds_list_clear(opponent.hitByGroup);
			break;
			
			case 3:
				if (state == eState.JUMPING)
				{
				 	state = eState.JUMPING_HEAVY_ATTACK;
				}
				else if (verticalMoveDir == -1)
				{
					state = eState.CROUCHING_HEAVY_ATTACK;
				}
				else 
				{
					state = eState.STANDING_HEAVY_ATTACK;
					image_index = 0;
				}
				// Clears the hitBy data to allow attacks to connect properly
				ds_list_clear(hitByGroup);
				ds_list_clear(opponent.hitByGroup);
			break;
			
			case 4:
				if (state != eState.JUMPING && state != eState.JUMPSQUAT) 
				{
					state = eState.GRAB;
					sprite_index = sRussel_Grab;
					image_index = 0;
				}
				// Clears the hitBy data to allow attacks to connect properly
				ds_list_clear(hitByGroup);
				ds_list_clear(opponent.hitByGroup);
			break;
			
			case 5:
				if (state != eState.JUMPSQUAT && movedir == 0)
				{
					state = eState.NEUTRAL_SPECIAL;
					sprite_index = sRussel_NSpecial;
					image_index = 0;
				} 
				else if (state != eState.JUMPSQUAT && movedir != 0)
				{
					state = eState.SIDE_SPECIAL;
					sprite_index = sRussel_SideSpecial;
					image_index = 0;
				}
				// Clears the hitBy data to allow attacks to connect properly
				ds_list_clear(hitByGroup);
				ds_list_clear(opponent.hitByGroup);
			break;
		}
	cancelable = false;
		
}