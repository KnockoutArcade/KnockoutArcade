sceneInfo = [
	[Cutscene_SetPlayerState, oRussel, eState.IDLE],
	[Cutscene_SetObjectVelocity, oRussel, 0, 0],
	[Cutscene_PanCameraLinear, 1360, 0, 60],
	[Cutscene_Wait, 30],
	[Cutscene_TeleportObject, oFightTrigger, x, y],
	[Cutscene_DestroyObject, inst_6EC7AA8F]
];