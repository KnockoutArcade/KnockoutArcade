// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetupGame()
{
	switch (global.gameMode) 
	{
		case GAMEMODE.VERSUS:
		{
			if (room != rStageArcade)
			{
				p1 = instance_create_layer(104, 104, "Instances", global.p1SelectedCharacter);
				p2 = instance_create_layer(216, 104, "Instances", global.p2SelectedCharacter);
			} 
			else
			{
				p1 = instance_create_layer(32, 104, "Instances", global.p1SelectedCharacter);
				p2 = instance_create_layer(128, 104, "Instances", global.p2SelectedCharacter);
			}
	
			// Setup Camera
			global.camObj = instance_create_layer(80, 0, "Instances", oCamera);
			global.camObj.p1 = p1;
			global.camObj.p2 = p2;
	
			p1.controller = global.player1ControllerSlot;
			p2.controller = global.player2ControllerSlot;

			p1.playerID = 1;
			p2.playerID = 2;
	
			global.currentRound++;
	
			with (p2) 
			{
				image_xscale *= -1;
				opponent = other.p1;
				hasPerformedIntro = global.currentRound != 1;
				PaletteSetup(global.p2PaletteID, global.RusselPalettes);
			}
			with (p1) 
			{
				opponent = other.p2;
				hasPerformedIntro = global.currentRound != 1;
				PaletteSetup(global.p1PaletteID, global.RusselPalettes);
			}
		
			healthbar1 = instance_create_layer(71, 16, "UI", oHealthbar);
			with (healthbar1) 
			{
				attatchedTo = other.p1;
				image_xscale = -39;
				ui_xOffset = 71;
			}
	
			healthbar2 = instance_create_layer(89, 16, "UI", oHealthbar);
			with (healthbar2) 
			{
				attatchedTo = other.p2;
				image_xscale = 39;
				ui_xOffset = 89;
			}
	
			TimerObject = instance_create_layer(73, 24, "Timer", oTimer);
			global.gameTimer = 99;
	
			// Create Super Meter UI
				// Player 1
			p1SuperMeter = instance_create_layer(2, 106, "SuperMeter", oSuperMeterUI);
			with (p1SuperMeter)
			{
				owner = other.p1;
				ui_xOffset = x;
			}
				// Player 2
			p2SuperMeter = instance_create_layer(97, 106, "SuperMeter", oSuperMeterUI);
			with (p2SuperMeter) 
			{
				owner = other.p2;
				ui_xOffset = x;
				meterDir = 1;
				sprite_index = sSuperMeterP2;
			}
	
	
			// Set up the HUD
			hudObject = instance_create_layer(0, 0, "UI", oUIHUD);
			with (hudObject)
			{
				p1Character = global.p1SelectedCharacter;
				p2Character = global.p2SelectedCharacter;
			}
	
			frameAdvantage = 0;
			calculateFrameData = false;
	
			global.gameHalt = false;
			gameHaltTimer = 0;
	
			if (global.hasCompletedIntros) 
			{
				var particle = instance_create_layer(80, 0, "Particles", oParticles);
				with (particle) 
				{
					if(global.currentRound == 1)
					{
						sprite_index = sRound1Start;
						lifetime = 110;
					}
					if(global.currentRound == 2)
					{
						sprite_index = sRound2Start;
						lifetime = 110;
					}
					if(global.currentRound == 3)
					{
						sprite_index = sFinalRoundStart;
						lifetime = 110;
					}
				}
			}
			global.game_paused = true;
		}
		break;
		
		case GAMEMODE.PLATFORMING:
		{
			//Setup Player
			p1 = instance_create_layer(32, 104, "Instances", global.p1SelectedCharacter);
			
			//Setup Camera
			global.camObj = instance_create_layer(80, 0, "Instances", oCamera);
			global.camObj.p1 = p1;
			
			//Setup Controller
			ControllerSetup();
			p1.controller = global.player1ControllerSlot;
			
			//Set the player's ID
			p1.playerID = 1;
			
			//Setup Player Data
			with (p1) 
			{
				opponent = noone;
				hasPerformedIntro = true;
				PaletteSetup(global.p1PaletteID, global.RusselPalettes);
			}
			
			//Setup Health Bar
			healthbar1 = instance_create_layer(71, 16, "UI", oHealthbar);
			with (healthbar1) 
			{
				attatchedTo = other.p1;
				image_xscale = -39;
				ui_xOffset = 71;
			}
			
			//Setup Timer
			TimerObject = instance_create_layer(73, 24, "Timer", oTimer);
			global.gameTimer = 99;
			
			// Create Super Meter UI for Player 1
			p1SuperMeter = instance_create_layer(2, 106, "UI", oSuperMeterUI);
			with (p1SuperMeter)
			{
				owner = other.p1;
				ui_xOffset = x;
			}
			
			// Set up the HUD
			hudObject = instance_create_layer(0, 0, "UI", oUIHUD);
			with (hudObject)
			{
				p1Character = global.p1SelectedCharacter;
			}
			
			//Frame Advantage Debug
			frameAdvantage = 0;
			calculateFrameData = false;
			
			//Unhalt the game
			global.gameHalt = false;
			gameHaltTimer = 0;
			
			//Handle Intros
			if (global.hasCompletedIntros) 
			{
				var particle = instance_create_layer(80, 0, "Particles", oParticles);
				with (particle) 
				{
					sprite_index = sRound1Start;
					lifetime = 110;
				}
			}
			// Unpauses game
			global.game_paused = true;
		}
		break;
	}
}