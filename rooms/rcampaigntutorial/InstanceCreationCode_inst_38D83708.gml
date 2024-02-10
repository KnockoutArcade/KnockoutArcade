sceneInfo = [
	[Cutscene_SetPlayerState, oBeverly, eState.IDLE],
	[Cutscene_SetObjectVelocity, oBeverly, 0, 0],
	[Cutscene_PanCameraLinear, 1360, 0, 60],
	[Cutscene_Wait, 30],
	[Cutscene_TeleportObject, oFightTrigger, x, y],
	[Cutscene_DestroyObject, inst_6EC7AA8F]
];