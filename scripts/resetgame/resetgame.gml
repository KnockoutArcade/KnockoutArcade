// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ResetGame(){
	instance_destroy(oPlayerController);
	instance_destroy(oRussel);
	instance_destroy(oBeverly);
	
	instance_destroy(oHitbox);
	instance_destroy(oPlayerHurtbox);
	instance_destroy(oHealthbar);
	instance_destroy(oTimer);
	instance_destroy(oSuperMeterUI);
	
	instance_destroy(global.camObj);
}