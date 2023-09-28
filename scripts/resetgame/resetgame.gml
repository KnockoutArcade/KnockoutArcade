// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ResetGame()
{
	instance_destroy(oPlayerController);
	instance_destroy(oRussel);
	instance_destroy(oBeverly);
	instance_destroy(oJay);
	instance_destroy(oSmoothCriminal);
	instance_destroy(oGunther);
	
	instance_destroy(oHitbox);
	instance_destroy(oThrowEnvDetection);
	instance_destroy(oPlayerHurtbox);
	instance_destroy(oHealthbar);
	instance_destroy(oSpiritBar);
	instance_destroy(oUIHUD);
	instance_destroy(oTimer);
	instance_destroy(oSuperMeterUI);
	instance_destroy(oProjectileBase);
	instance_destroy(oSpiritFire);
	instance_destroy(oTimeStop);
	instance_destroy(oSuperKO);
	instance_destroy(oSuperKOFirst);
	instance_destroy(oSuperKOOrange);
	instance_destroy(oRoundCounter);
	
	instance_destroy(global.camObj);
	
	global.freezeTimer = false;
	audio_resume_sound(testBGM);
}