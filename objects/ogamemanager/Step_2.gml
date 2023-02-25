/// @description Insert description here
// You can write your code in this editor



// Frame Advantage
if (p1.FAvictim) || (p2.FAvictim)
{
	// Determine who is attacking and who is getting hit
	if (p1.FAvictim)
	{
		victim = p1;
		nonVictim = p2;
		calculateFrameData = true;
	} 
	else
	{
		victim = p2;
		nonVictim = p1;
		calculateFrameData = true;
	}
}

if global.game_paused exit;

if calculateFrameData 
{
	// Determine whether to use hitstun or blockstun
	var victimStun = max(victim.hitstun, victim.blockstun);
	
	// If the attacker is able to act and the victim is still in hit/blockstun, 
	// the amount of frame advantage is equal however much hitstun/blockstun the victim still has.
	
	if (nonVictim.frameAdvantage) && (!victim.frameAdvantage)  && (victimStun > 0)
	{
		frameAdvantage = victimStun;
	} 
	// If the attaker is still in an attack animation and the victim is no longer in hit/blockstun,
	// then for as long as the attacker is not in an actionable state, decrease the frame advantage
	// by 1 each frame.
	else if (!nonVictim.frameAdvantage) && (victimStun < 1)
	{
		if (nonVictim.state != eState.IDLE && nonVictim.state != eState.WALKING && nonVictim.state != eState.CROUCHING)
		{
			frameAdvantage--;
		}
		else calculateFrameData = false;
	}
}