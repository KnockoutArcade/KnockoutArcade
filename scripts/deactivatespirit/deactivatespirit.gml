// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DeactivateSpirit(executedBySpirit)
{
	if (!executedBySpirit)
	{
		if (spiritSummoned) 
		{
			instance_create_layer(spiritObject.x, spiritObject.y, "Instances", oSpiritFire);
			instance_destroy(spiritObject.hurtbox);
			instance_destroy(spiritObject);
			spiritObject = noone;
			spiritSummoned = false;
		}
		spiritState = false;
		pendingToggle = false;
		if ((selectedCharacter.JumpType & 1) != 1)
		{
			canDoubleJump = false;
		}
	}
	else
	{
		hostObject.spiritObject = noone;
		hostObject.spiritSummoned = false;
		hostObject.spiritState = false;
		if ((host.JumpType & 1) != 1)
		{
			hostObject.canDoubleJump = false;
		}
		if (host.UniqueData.LinkMovesetsWithSpirits)
		{
			hostObject.currentMovesetID = host.UniqueData.SpiritOffMoveset;
			with(hostObject)
			{
				OverwriteMoveset();
			}
		}
		with(hostObject.hurtbox)
		{
			spiritOwner = noone;
		}
		instance_create_layer(x, y, "Instances", oSpiritFire);
		instance_destroy(hurtbox);
		instance_destroy();
	}
}