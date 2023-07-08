// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// Update the spirit's move whenever the host performs an attack
function SetSpiritMoveData(enhancement, move, attack)
{
	if (spirit != noone && spiritSummoned && move.SpiritData.PerformAttack)
	{
		spiritObject.state = state;
		if (!enhancement)
		{
			spiritObject.attack = attack;
		}
		spiritObject.animTimer = 0;
	}
	if (move.SpiritData.ReturnToPlayer && spiritState) 
	{
		spiritObject.nextToPlayer = true;
	}
}