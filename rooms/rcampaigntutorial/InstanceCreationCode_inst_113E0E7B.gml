isIntroCutscene = true;

sceneInfo = [
	[Cutscene_HideObject, oBeverly, true],
	[Cutscene_Wait, 90],
	[Cutscene_TeleportObject, oBeverly, 31, 55],
	[Cutscene_HideObject, oBeverly, false],
	[Cutscene_SetPlayerState, oBeverly, eState.JUMPING],
	[Cutscene_SetObjectVelocity, oBeverly, 1, -3]
];