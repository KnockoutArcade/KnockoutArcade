// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ActivateRushCancel()
{
	for (var i = 0; i < instance_number(oThrowEnvDetection); i++;)
	{
		var throwEnvDetectionBox = instance_find(oThrowEnvDetection, i);
		instance_destroy(throwEnvDetectionBox);
	}
	
	if (state != eState.HITSTOP)
	{
		stateBeforeFreeze = state;
	}
	else
	{
		stateBeforeFreeze = prevState;
	}
	// This if statement is temporary, as the player doesn't turn around but the opponent is behind them
	if (stateBeforeFreeze == eState.BACKWARD_THROW)
	{
		image_xscale *= -1;
	}
	
	rcActivated = true;
	rcFreezeTimer = 0;
	superMeter -= 50;
	projectileInvincible = true;
	hitstop = 0;
	activateFreeze = true;
	global.freezeTimer = true;
	state = eState.SCREEN_FREEZE;
	instance_create_layer(x, y, "Instances", oRushCancel);
}