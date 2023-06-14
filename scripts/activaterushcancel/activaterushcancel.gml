// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ActivateRushCancel()
{
	rcActivated = true;
	rcFreezeTimer = 0;
	superMeter -= 50;
	projectileInvincible = true;
	global.hitstop = 0;
	activateFreeze = true;
	global.freezeTimer = true;
	state = eState.SCREEN_FREEZE;
	instance_create_layer(x, y, "Instances", oRushCancel);
}