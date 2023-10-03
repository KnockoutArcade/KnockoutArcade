isIntroCutscene = true;

sceneInfo = [
	[Cutscene_HideObject, oRussel, true],
	[Cutscene_Wait, 60],
	[Cutscene_TeleportObject, oRussel, 31, 55],
	[Cutscene_HideObject, oRussel, false],
	[Cutscene_SetPlayerState, oRussel, eState.JUMPING],
	[Cutscene_SetObjectVelocity, oRussel, 1, -3]
];