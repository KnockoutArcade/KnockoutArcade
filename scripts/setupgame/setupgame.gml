// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetupGame(){
	if room != rStageArcade {
		p1 = instance_create_layer(104, 104, "Instances", oRussel);
		p2 = instance_create_layer(216, 104, "Instances", oRussel);
	} else {
		p1 = instance_create_layer(32, 104, "Instances", oRussel);
		p2 = instance_create_layer(128, 104, "Instances", oRussel);
	}
	
	// Setup Camera
	global.camObj = instance_create_layer(80, 0, "Instances", oCamera);
	global.camObj.p1 = p1;
	global.camObj.p2 = p2;

	ControllerSetup();
	
	p1.controller = global.player1ControllerSlot;
	p2.controller = global.player2ControllerSlot;

	p1.playerID = 1;
	p2.playerID = 2;
	
	global.currentRound++;
	
	with p2 {
		image_xscale *= -1;
		opponent = other.p1;
		if global.currentRound = 1 hasPerformedIntro = false;
		PaletteSetup(global.p2PaletteID, global.RusselPalettes);
	}
	with p1 {
		opponent = other.p2;
		if global.currentRound = 1 hasPerformedIntro = false;
		PaletteSetup(global.p1PaletteID, global.RusselPalettes);
	}
		
	
	healthbar1 = instance_create_layer(71, 16, "UI", oHealthbar);
	with healthbar1 {
		attatchedTo = other.p1;
		image_xscale = -39;
		ui_xOffset = 71;
	}
	
	healthbar2 = instance_create_layer(89, 16, "UI", oHealthbar);
	with healthbar2 {
		attatchedTo = other.p2;
		image_xscale = 39;
		ui_xOffset = 89;
	}
	
	TimerObject = instance_create_layer(73, 24, "Timer", oTimer);
	global.gameTimer = 99;
	
	// Create Super Meter UI
		// Player 1
	p1SuperMeter = instance_create_layer(2, 106, "UI", oSuperMeterUI);
	with p1SuperMeter {
		owner = other.p1;
		ui_xOffset = x;
	}
		// Player 2
	p2SuperMeter = instance_create_layer(97, 106, "UI", oSuperMeterUI);
	with p2SuperMeter {
		owner = other.p2;
		ui_xOffset = x;
		meterDir = 1;
		sprite_index = sSuperMeterP2;
	}
	
	frameAdvantage = 0;
	calculateFrameData = false;
	
	global.gameHalt = false;
	gameHaltTimer = 0;
	
	if global.hasCompletedIntros == true {
		var particle = instance_create_layer(80, 0, "Particles", oParticles);
		with particle {
			sprite_index = sRound1Start;
			lifetime = 110;
		}
	}
	
	global.game_paused = true;
}