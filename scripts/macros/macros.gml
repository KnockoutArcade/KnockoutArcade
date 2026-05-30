// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function macros()
{
	#macro ScalingMinimum .1 // The lowest amount of damage a scaled attack can do in a combo (in terms of percentage of base damage)
	#macro SuperScalingMinimum .4 // The lowest amount of damage a super can do (in terms of percentage of base damage)
	#macro GravityScalingMaximum 25 // The value used to determine the rate at which moves scale their vertical knockback.
	#macro MaximumPushbackDuration 5 // The longest amount of time (in frames) we can get pushed back for
	#macro ControllerSaveVersionNumber 2 // Which version of the controls we're using
	#macro ThrowTechDistance 5 // How far to push players away on a throw tech
}

enum GAMEMODE
{
	MENU,
	VERSUS,
	PLATFORMING,
	TRAINING,
}

enum CONTROLLER_TYPES
{
	PAD,
	WASD,
	ARROWS
}