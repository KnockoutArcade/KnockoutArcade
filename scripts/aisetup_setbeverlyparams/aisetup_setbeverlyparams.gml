// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AISetup_SetBeverlyParams()
{
	// What moves to use for pressuring the opponent
	// [direction, attack, weight (probability), condition()]
	pressureAttacks = [
	[5, 1, 60, true], [2, 1, 60, true],
	[5, 2, 50, true],
	[6, 4, 50, true],
	[5, 5, 60, true], [4, 5, 60, true],
	];

	pokeAttacks = [
	[5, 2, 80, true], [2, 2, 50, true], [6, 2, 80, true], [4, 2, 30, true],
	[5, 3, 40, true], [2, 3, 40, true],
	[5, 4, 60, true], [2, 4, 70, CPUBehaviorCondition_checkNotSpecialCharge], [6, 4, 50, true],
	[5, 6, 50, CPUBehaviorCondition_check50Meter]
	];

	reversalAttacks = [
	[5, 1, 50, true], [2, 1, 40, true],
	[8, 4, 150, CPUBehaviorCondition_checkSpecialCharge],
	[5, 5, 30, true]
	];

	comboRoutes = [
		// [InputType(-1 = cancel, 0+ = link (delay x frames after move has ended)), direction, attack]
		{
			starter : eState.STANDING_LIGHT_ATTACK,
			condition : true,
			weight : 10,
			route : 
			[
				[-1, 5, 1], [-1, 5, 1]
			]
		},
		{
			starter : eState.STANDING_LIGHT_ATTACK,
			condition : true,
			weight : 10,
			route : 
			[
				[-1, 5, 2], [-1, 6, 2], [-1, 6, 4], [-1, 6, 4], [-1, 6, 4]
			]
		},
		{
			starter : eState.CROUCHING_LIGHT_ATTACK,
			condition : true,
			weight : 10,
			route : 
			[
				[-1, 2, 2], [-1, 2, 3]
			]
		},
		{
			starter : eState.CROUCHING_LIGHT_ATTACK,
			condition : CPUBehaviorCondition_checkSpecialCharge,
			weight : 30,
			route : 
			[
				[-1, 2, 1], [-1, 6, 2], [-1, 2, 4]
			]
		},
		{
			starter : eState.STANDING_MEDIUM_ATTACK,
			condition : CPUBehaviorCondition_check50Meter,
			weight : 20,
			route : 
			[
				[-1, 5, 3], [-1, 5, 6]
			]
		},
		{
			starter : eState.STANDING_MEDIUM_ATTACK,
			condition : true,
			weight : 10,
			route : 
			[
				[-1, 6, 2]
			]
		},
		{
			starter : eState.SIDE_SPECIAL,
			condition : true,
			weight : 20,
			route : 
			[
				[-1, 6, 4], [-1, 6, 4],
			]
		},
		{
			starter : eState.SIDE_SPECIAL,
			condition : true,
			weight : 10,
			route : 
			[
				[-1, 6, 4], [-1, 2, 4],
			]
		},
		{
			starter : eState.SIDE_SPECIAL,
			condition : true,
			weight : 5,
			route : 
			[
				[-1, 6, 4], [-1, 8, 4],
			]
		},
	]
}