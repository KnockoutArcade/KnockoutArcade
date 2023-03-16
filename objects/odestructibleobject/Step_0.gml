/// @description Insert description here
// You can write your code in this editor

// Remove this objects collision if it is not supposed to have it
if (!hasWallCollision)
{
	instance_destroy(wallCollisionBox);
}

switch (state)
{
	case eState.IDLE:
	{
		cancelCombo = true; // Combo Counter shouldn't show up on Destructable Objects
		
		if (hp <= 0)
		{
			instance_destroy(hurtbox);
			if (hasWallCollision)
			{
				instance_destroy(wallCollisionBox);
			}
			instance_destroy();
			oPlayerController.target = noone;
		}
	}
	break;
	
	case eState.HITSTOP:
	{
		hitstunShuffleTimer++;
	
		if (!isGrabbed)
		{
			sprite_index = CharacterSprites.hurt_Sprite;
		}
		
		if (hitstunShuffleTimer % 2 == 1)
		{
			shuffle++;
		}

		if (shuffle % 2 == 1)
		{
			x = xHome + min(global.hitstop, 3);
		}
		else 
		{
			x = xHome - min(global.hitstop, 3);
		}
		
		if (global.hitstop == 0)
		{
			state = eState.IDLE;
		}
	}
}


