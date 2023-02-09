/// @description Insert description here
// You can write your code in this editor



// A player is defeated
if p1.hp == 0 || p2.hp == 0 {
	global.gameHalt = true;
	gameHaltTimer++;
	
	if gameHaltTimer == 90 {
		ResetGame();
		
		SetupGame();
		
		global.gameHalt = 0;
		gameHaltTimer = 0;
	}
	if gameHaltTimer == 1 {
		if p1.hp > 0 global.p1Rounds++;
		if p2.hp > 0 global.p2Rounds++;
		var particle = instance_create_layer(global.camObj.x-80, 0, "KO_Text", oParticles);
		with particle {
		sprite_index = sKOText;
		image_index = true;
		lifetime = 89;
	}
	}
}

// Time runs out
if global.gameTimer == 0 {
	global.gameHalt = true;
	gameHaltTimer++;
	
	if gameHaltTimer == 90 {
		ResetGame();
		
		SetupGame();
		
		global.gameHalt = 0;
		gameHaltTimer = 0;
	}
	if gameHaltTimer == 1 {
		if p1.hp > p2.hp global.p1Rounds++;
		if p2.hp > p1.hp global.p2Rounds++;
		var particle = instance_create_layer(0, 0, "KO_Text", oParticles);
		with particle {
		sprite_index = sTimeUp;
		image_index = true;
		lifetime = 89;
	}
	}
}

// handle intros
if p1.hasPerformedIntro && p2.hasPerformedIntro && global.hasCompletedIntros == false {
	global.hasCompletedIntros = true;
	var particle = instance_create_layer(80, 0, "Particles", oParticles);
	with particle {
		sprite_index = sRound1Start;
		lifetime = 110;
	}
}



// Frame-by-frame
if (keyboard_check_pressed(vk_tab)) or (global.frameskip < 0)
{
	if (global.game_paused = false)
	{
		global.game_paused = true;
		global.frameskip = 0;
	}
	else global.game_paused = false;
}

if (global.game_paused) and (keyboard_check_pressed(ord("O")))
{
	global.frameskip = 1;
}

if (global.frameskip > 0)
{
	global.game_paused = false;
	global.frameskip = -1;
}

