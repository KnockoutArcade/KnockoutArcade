// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SetupGame()
{
	switch (global.gameMode) 
	{
		case GAMEMODE.TRAINING:
		{
			global.hasCompletedIntros = true;
			global.currentRound = 0;
		}
		case GAMEMODE.VERSUS:
		{
			// Set the current state of the game manager
			state = eGameManagerState.DURING_MATCH;
			
			if (room == rRusselStage)
			{
				p1 = instance_create_layer(129, 104, "Instances", global.p1SelectedCharacter);
				p1.playerID = 1;
				p1.controller = global.player1ControllerSlot;
				
				p2 = instance_create_layer(199, 104, "Instances", global.p2SelectedCharacter);
				p2.playerID = 2;
				p2.controller = global.player2ControllerSlot;
			} 
			else if (room != rStageArcade)
			{
				p1 = instance_create_layer(104, 104, "Instances", global.p1SelectedCharacter);
				p1.playerID = 1;
				p1.controller = global.player1ControllerSlot;
				
				p2 = instance_create_layer(216, 104, "Instances", global.p2SelectedCharacter);
				p2.playerID = 2;
				p2.controller = global.player2ControllerSlot;
			}
			else
			{
				p1 = instance_create_layer(32, 104, "Instances", global.p1SelectedCharacter);
				p1.playerID = 1;
				p1.controller = global.player1ControllerSlot;
				
				p2 = instance_create_layer(128, 104, "Instances", global.p2SelectedCharacter);
				p2.playerID = 2;
				p2.controller = global.player2ControllerSlot;
			}
	
			// Setup Camera
			global.camObj = instance_create_layer(80, 0, "Instances", oCamera);
			global.camObj.p1 = p1;
			global.camObj.p2 = p2;

			global.currentRound++;
	
			with (p2) 
			{
				image_xscale *= -1;
				opponent = other.p1;
				hasPerformedIntro = false;
				if (global.currentRound != 1 || global.isDoingRematch || global.gameMode == GAMEMODE.TRAINING)
				{
					hasPerformedIntro = true;
				}
				PaletteSetup(global.p2PaletteID, selectedCharacter);
				isInCutscene = true;
				teamID = 2; // Set this player's team score
				
				controllerSlot = global.player2ControllerSlot;
			}
			with (p1) 
			{
				opponent = other.p2;
				hasPerformedIntro = false;
				if (global.currentRound != 1 || global.isDoingRematch || global.gameMode == GAMEMODE.TRAINING)
				{
					hasPerformedIntro = true;
				}
				PaletteSetup(global.p1PaletteID, selectedCharacter);
				isInCutscene = true;
				teamID = 1; // Set this player's team score
				
				controllerSlot = global.player1ControllerSlot;
			}
		
			#region Spawn AI opponent
			if (global.gameMode != GAMEMODE.TRAINING && p2.controllerSlot == -1)
			{
				var p2AIController = instance_create_depth(0, 0, 0, oAIController);
				var p2AIBehavior = instance_create_depth(0, 0, 0, oAIBehavior_VersusCPU_Test);
				
				p2.controllerID = p2AIController;
				p2AIBehavior.characterID = p2; // Who this AI is controlling
				p2AIBehavior.controllerID = p2AIController; // The controller object to communicate with
				p2AIBehavior.opponent = p1; // Who this AI is targeting
			}
			
			if (global.gameMode != GAMEMODE.TRAINING && p1.controllerSlot == -1)
			{
				var p1AIController = instance_create_depth(0, 0, 0, oAIController);
				var p1AIBehavior = instance_create_depth(0, 0, 0, oAIBehavior_VersusCPU_Test);
				
				p1.controllerID = p1AIController;
				p1AIBehavior.characterID = p1; // Who this AI is controlling
				p1AIBehavior.controllerID = p1AIController; // The controller object to communicate with
				p1AIBehavior.opponent = p2; // Who this AI is targeting
			}
			#endregion
		
			// Special Charge Icon (for Beverly)
			specialChargeIcon1 = instance_create_layer(63, 24, "UI", oSpecialChargeIcon);
			with (specialChargeIcon1)
			{
				owner = other.p1;
				ui_offsetX = x;
				ui_offsetY = y;
			}
			
			specialChargeIcon2 = instance_create_layer(97, 24, "UI", oSpecialChargeIcon);
			with (specialChargeIcon2)
			{
				owner = other.p2;
				ui_offsetX = x;
				ui_offsetY = y;
				image_xscale = -1;
			}
			
			healthbar1 = instance_create_layer(71, 16, "UI", oHealthbar);
			with (healthbar1) 
			{
				attatchedTo = other.p1;
				image_xscale = -39;
				ui_xOffset = x;
				ui_yOffset = y;
			}
	
			healthbar2 = instance_create_layer(89, 16, "UI", oHealthbar);
			with (healthbar2) 
			{
				attatchedTo = other.p2;
				image_xscale = 39;
				ui_xOffset = x;
				ui_yOffset = y;
				
				sprite_index = sHealthbar_Blue;
				healthbarDamageSprite = sHealthbar_Damage_Blue;
			}
			
			if (p1.spirit != noone)
			{
				spiritbar1 = instance_create_layer(66, 30, "UI", oSpiritBar);
				with (spiritbar1) 
				{
					attatchedTo = other.p1;
					image_xscale = -44;
					ui_xOffset = x + 2;
					ui_yOffset = y;
				}
			}
	
			if (p2.spirit != noone)
			{
				spiritbar2 = instance_create_layer(94, 30, "UI", oSpiritBar);
				with (spiritbar2) 
				{
					attatchedTo = other.p2;
					image_xscale = 44;
					ui_xOffset = x - 2;
					ui_yOffset = y;
				}
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
				ui_yOffset = y;
			}
				// Player 2
			p2SuperMeter = instance_create_layer(97, 106, "SuperMeter", oSuperMeterUI);
			with (p2SuperMeter) 
			{
				owner = other.p2;
				ui_xOffset = x;
				ui_yOffset = y;
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
			hudObject.p1Reference = p1;
			hudObject.p2Reference = p2;
			
			// Round Counter
			p1RoundCounter = instance_create_layer(70, 4, "UI", oRoundCounter);
			with (p1RoundCounter) 
			{
				owner = 1;
				ui_xOffset = x;
				ui_yOffset = y;
			}

			p2RoundCounter = instance_create_layer(90, 4, "UI", oRoundCounter);
			with (p2RoundCounter) 
			{
				image_xscale = -1;
				owner = 2;
				ui_xOffset = x;
				ui_yOffset = y;
			}
			
			
			
			// Frame Advantage
			frameAdvantage = 0;
			calculateFrameData = false;
	
			global.gameHalt = false;
			gameHaltTimer = 0;
	
			if (global.hasCompletedIntros && global.gameMode != GAMEMODE.TRAINING) 
			{
				var particle = instance_create_layer((room_width / 2) - 80, 0, "Particles", oParticles);
				with (particle) 
				{
					if (global.currentRound == 1)
					{
						if (global.isDoingRematch)
						{
							sprite_index = sRunItBack;
							lifetime = 80;
						}
						else
						{
							sprite_index = sRound1Start;
							lifetime = 110;
						}
						
					}
					if (global.currentRound == 2)
					{
						sprite_index = sRound2Start;
						lifetime = 110;
					}
					if (global.currentRound == 3)
					{
						sprite_index = sFinalRoundStart;
						lifetime = 110;
					}
				}
				global.isDoingRematch = false;
			}
		}
		break;
		
		case GAMEMODE.PLATFORMING:
		{
			// Safegaurd
			global.isDoingRematch = false;
			
			//Setup Player
			p1 = instance_create_layer(global.p1StartingPositionX, global.p1StartingPositionY, "Instances", global.p1SelectedCharacter);
			
			//Setup Camera
			global.camObj = instance_create_layer(global.p1StartingPositionX - 80, 0, "Instances", oCamera);
			global.camObj.p1 = p1;
			
			//Setup Controller
			p1.controllerSlot = global.player1ControllerSlot;
			
			//Set the player's ID
			p1.playerID = 1;
			
			//Setup Player Data
			with (p1) 
			{
				opponent = noone;
				hasPerformedIntro = true;
				PaletteSetup(global.p1PaletteID, selectedCharacter);
				isInCutscene = true;
				
				teamID = 1; // Set this player's team score
				
				// There's not a reason for the player to be locked to the screen
				shouldStayOnScreen = false;
			}
			
			//Setup Health Bar
			healthbar1 = instance_create_layer(63, 16, "UI", oHealthbar);
			with (healthbar1) 
			{
				attatchedTo = other.p1;
				image_xscale = -38;
				MaxLength = 38;
				initialHealthXscale = -38;
				ui_xOffset = x;
				ui_yOffset = y;
			}
			
			// Create Super Meter UI for Player 1
			p1SuperMeter = instance_create_layer(2, 106, "UI", oSuperMeterUI);
			with (p1SuperMeter)
			{
				owner = other.p1;
				ui_xOffset = x;
				ui_yOffset = y;
			}
			
			// Create spirit bar if the character has one
			if (p1.spirit != noone)
			{
				spiritbar1 = instance_create_layer(21, 26, "UI", oSpiritBar);
				with (spiritbar1) 
				{
					attatchedTo = other.p1;
					image_xscale = -33;
					ui_xOffset = x + 2;
					ui_yOffset = y;
				}
			}
			
			// Set up the HUD
			hudObject = instance_create_layer(0, 0, "UI", oUIHUD);
			with (hudObject)
			{
				p1Character = global.p1SelectedCharacter;
				p1Reference = other.p1;
				
				sprite_index = sUIBaseSingleplayer;
			}
			
			// Coin Count
			singleplayerCoinCount = instance_create_layer(83, 10, "UI", oSingleplayerCoinCount);
			with (singleplayerCoinCount)
			{
				owner = other.p1;
				ui_xOffset = x;
				ui_yOffset = y;
				depth -= 1;
			}
			
			// Timer
			singleplayerTimer = instance_create_layer(83, 17, "UI", oSingleplayerTimer);
			with (singleplayerTimer)
			{
				owner = other.p1;
				ui_xOffset = x;
				ui_yOffset = y;
				depth -= 1;
			}
			
			//Frame Advantage Debug
			frameAdvantage = 0;
			calculateFrameData = false;
			
			//Unhalt the game
			global.gameHalt = false;
			gameHaltTimer = 0;
			
			
			// Set up some vars for the player if we are transitioning from another room
			if (global.roomTransitionData.isActive)
			{
				p1.x = global.roomTransitionData.newX;
				p1.y = global.roomTransitionData.newY;
				p1.hsp = global.roomTransitionData.newHSP;
				p1.vsp = global.roomTransitionData.newVSP;
				p1.animTimer = global.roomTransitionData.currentAnimTimer;
				p1.grounded = global.roomTransitionData.newGrounded;
				p1.jumpHsp = global.roomTransitionData.newJumpHSP;
				
				if (sign(p1.hsp) != 0)
				{
					p1.image_xscale = sign(p1.hsp);
				}
				
				p1.state = global.roomTransitionData.newState;
				p1.hp = global.roomTransitionData.currentHealth;
				p1.superMeter = global.roomTransitionData.currentSuperMeter;
				
				global.camObj.x = global.roomTransitionData.newCamX;
				global.camObj.y = global.roomTransitionData.newCamY;
				
				global.hasCompletedIntros = true;
				
				p1.isInCutscene = false;
			}
			
			
			
			//Handle Intros
			if (global.hasCompletedIntros && !global.roomTransitionData.isActive) 
			{
				var particle = instance_create_layer(80, 0, "Particles", oParticles);
				with (particle) 
				{
					startDelay = global.campaignStartLevelDelay;
					sprite_index = sRound1Start;
					lifetime = 110;
					
					if (startDelay > 0)
					{
						visible = false;
					}
					
					global.campaignStartLevelDelay = 0;
				}
			}
			
			global.roomTransitionData.isActive = false;
		}
		break;
	}
}