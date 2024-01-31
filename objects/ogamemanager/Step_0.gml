/// @description Insert description here
// You can write your code in this editor

switch (global.gameMode)
{
	case GAMEMODE.VERSUS:
	{
		// This will tell us if someone has won, so we can stop any match resetting
		var winConditionMet = (global.p1Rounds >= 2 || global.p2Rounds >= 2);
		
		// A player is defeated
		if (p1.hp <= 0 || p2.hp <= 0)
		{
			p1.isEXFlash = false;
			p2.isEXFlash = false;
			
			// Disable inputs for players
			p1.isInCutscene = true; 
			p2.isInCutscene = true;
			instance_destroy(oTimeStop);
			audio_resume_sound(testBGM);
			
			
			gameHaltTimer++;
		
			if (gameHaltTimer == 300 && !winConditionMet)
			{
				ResetGame();

				SetupGame();
		
				global.gameHalt = 0;
				global.game_paused = false;
				gameHaltTimer = 0;
			}
			else if (gameHaltTimer >= 180 && gameHaltTimer < 300)
			{
				global.game_paused = false;
			}
			else if (gameHaltTimer >= 60 && gameHaltTimer < 180)
			{
				// Slowdown the game by pausing and unpausing
				if (gameHaltTimer mod 3 >= 1)
				{
					global.game_paused = true;
				}
				else
				{
					global.game_paused = false;
				}
			}
			else if (gameHaltTimer == 1)
			{
				// Immediately pause the game
				global.game_paused = true;
				
				if (p2.hp <= 0)
				{
					global.p1Rounds++;
				}
				
				if (p1.hp <= 0)
				{
					global.p2Rounds++;
				}
				
				if (p1.hp <= 0 && p2.hp <= 0)
				{
					var particle = instance_create_layer(global.camObj.x-80, 0, "KO_Text", oParticles);
					with (particle) 
					{
						sprite_index = sDoubleKOText;
						image_index = true;
						lifetime = 59;
					}
				}
				else
				{
					if ((p2.hp <= 0 && (p1.state == eState.SUPER || p1.installActivated || p1.timeStopActivated)) || 
						 (p1.hp <= 0 && (p2.state == eState.SUPER || p2.installActivated || p2.timeStopActivated)))
					{
						var superBackground = instance_create_layer(global.camObj.x, global.camObj.y + 60, "KO_Text", oSuperKO);
						with (superBackground) 
						{
							depth = 650;
							lifetime = 89;
						}
					}
					var particle = instance_create_layer(global.camObj.x-80, 0, "KO_Text", oParticles);
					with (particle) 
					{
						sprite_index = sKOText;
						image_index = true;
						lifetime = 59;
					}
				}
			}
		}

		// Time runs out
		if (global.gameTimer == 0)
		{
			global.gameHalt = true;
			gameHaltTimer++;
	
			if (gameHaltTimer == 90 && !winConditionMet)
			{
				ResetGame();
		
				SetupGame();
		
				global.gameHalt = 0;
				gameHaltTimer = 0;
			}
			else if (gameHaltTimer == 1)
			{
				if (p1.hp/p1.maxHitPoints > p2.hp/p2.maxHitPoints)
				{
					global.p1Rounds++;
				}
				else if (p2.hp/p2.maxHitPoints > p1.hp/p1.maxHitPoints)
				{
					global.p2Rounds++;
				}
				else // both are equal
				{
					global.p1Rounds++;
					global.p2Rounds++;
				}
		
				// Display Time's up text
				var particle = instance_create_layer(global.camObj.x-80, 0, "KO_Text", oParticles);
				with (particle) 
				{
					sprite_index = sTimeUp;
					image_index = true;
					lifetime = 89;
				}
			}
		}
		
		// When a player meets the win requirement for the match return players to the character selection screen
		if (global.p1Rounds >=2 && global.p2Rounds >= 2)
		{
			if(gameHaltTimer == 90) // ensure this doesn't play unless the KO animation is completed
			{				
				var particle = instance_create_layer(global.camObj.x-80, 0, "KO_Text", oParticles);
				with (particle)
				{
					sprite_index = sDraw;
					image_index = true;
					lifetime = 1000000000;
				}
			}
			else if(gameHaltTimer >= 220)
			{
				state = 1;
				audio_stop_sound(testBGM);
				ResultsScreen();
			}
		}
		else if (global.p1Rounds >= 2)
		{
			if(gameHaltTimer == 90) // ensure this doesn't play unless the KO animation is completed
			{				
				var particle = instance_create_layer(global.camObj.x-80, 0, "KO_Text", oParticles);
				with (particle)
				{
					sprite_index = sPlayer1Wins;
					image_index = true;
					lifetime = 1000000000;
				}
			}
			else if(gameHaltTimer >= 220)
			{
				state = 1;
				audio_stop_sound(testBGM);
				ResultsScreen();
			}
		}
		else if (global.p2Rounds >= 2)
		{
			if(gameHaltTimer == 90)
			{
				var particle = instance_create_layer(global.camObj.x-80, 0, "KO_Text", oParticles);
				with (particle)
				{
					sprite_index = sPlayer2Wins;
					image_index = true;
					lifetime = 1000000000;
				}
			}
			else if(gameHaltTimer >= 220)
			{
				state = 1;
				audio_stop_sound(testBGM);
				ResultsScreen();
			}
		}
		

		// handle intros 
		if (p1.hasPerformedIntro && p2.hasPerformedIntro && !global.hasCompletedIntros) 
		{
			global.hasCompletedIntros = true;
			var particle = instance_create_layer(80, 0, "Particles", oParticles);
			with (particle) 
			{
				sprite_index = sRound1Start;
				lifetime = 110;
			}
		}



		// Frame-by-frame
		if (keyboard_check_pressed(vk_tab) || global.frameskip < 0)
		{
			if (!global.game_paused)
			{
				global.game_paused = true;
				global.frameskip = 0;
			}
			else 
			{
				global.game_paused = false;
			}
		}

		if (global.game_paused && keyboard_check_pressed(ord("O")))
		{
			global.frameskip = 1;
		}

		if (global.frameskip > 0)
		{
			global.game_paused = false;
			global.frameskip = -1;
		}


	}
	break;
	
	case GAMEMODE.PLATFORMING:
	{
		// When a player completes a level
		if (global.hasCompletedLevel)
		{
			global.gameHalt = true;
			
			levelCompleteTimer++;
			
			if (levelCompleteTimer == 10)
			{
				levelCompleteParticle = instance_create_layer(global.camObj.x-80, 0, "KO_Text", oParticles);
				with (levelCompleteParticle) 
				{
					sprite_index = sLevelComplete;
					image_index = true;
					lifetime = 99999;
				}
				
				p1.state = eState.ROUND_WIN;
			}
			
			// Once we have done the level complete animation
			if (levelCompleteParticle != noone)
			{
				if (levelCompleteParticle.image_index >= 18)
				{
					// Stop the sprite from animating on its own
					levelCompleteParticle.image_speed = 0;
				}
			}
			
			// Display the results for time
			if (levelCompleteTimer == 100)
			{
				// Set the display's image index
				levelCompleteParticle.image_index = 19;
				
				// Create the text object to render how much time has been spent
				levelCompleteTimeScore = instance_create_layer(global.camObj.x-40, 65, "Timer", oSingleplayerResultsText); 
				with (levelCompleteTimeScore) 
				{
					textToRender = string(other.singleplayerTimer.stringMinutes + ":" + other.singleplayerTimer.stringSeconds + "." + other.singleplayerTimer.stringMilliseconds);
				}
			}
			
			// Display the results for money
			if (levelCompleteTimer == 130)
			{
				// Set the display's image index
				levelCompleteParticle.image_index = 20;
				
				// Create the text object to render how much money the player earned
				levelCompleteMoneyScore = instance_create_layer(global.camObj.x-32, 74, "Timer", oSingleplayerResultsText); 
				with (levelCompleteMoneyScore) 
				{
					textToRender = string("$" + string(other.singleplayerCoinCount.coinScoreTens) + string(other.singleplayerCoinCount.coinScoreOnes) + string(".") + string(other.singleplayerCoinCount.coinScoreTenths) + string(other.singleplayerCoinCount.coinScoreHundredths));
				}
			}
			
			// Display the results for damage
			if (levelCompleteTimer == 160)
			{
				// Set the display's image index
				levelCompleteParticle.image_index = 21;
				
				// Create the text object to render how much damage the player has taken
				levelCompleteDamageScore = instance_create_layer(global.camObj.x-24, 83, "Timer", oSingleplayerResultsText); 
				with (levelCompleteDamageScore) 
				{
					textToRender = string(other.p1.totalDamageTaken);
				}
			}
			
			// Display the results for KOs
			if (levelCompleteTimer == 190)
			{
				// Set the display's image index
				levelCompleteParticle.image_index = 22;
				
				// Create the text object to render how many things the player has destroyed
				levelCompleteKOScore = instance_create_layer(global.camObj.x-45, 92, "Timer", oSingleplayerResultsText); 
				with (levelCompleteKOScore) 
				{
					textToRender = string(other.p1.totalKOs);
				}
			}
			
			// After displaying all the stats, display rank
			if (levelCompleteTimer == 230)
			{
				// Set the display's image index
				levelCompleteParticle.image_index = 23;
			}
			
			// Once enough time has passed, exit singleplayer level
			if (levelCompleteTimer == 500)
			{
				room_goto(global.campaignMapRoom);
				global.hasCompletedLevel = false;
				
				// Reset level Complete vars
				levelCompleteTimer = 0;
				levelCompleteParticle = noone; // Pointer to the particle effect responsible for putting the results on the screen
				levelCompleteTimeScore = noone; // Pointer to the text object that renders the time achieved on the level
				levelCompleteMoneyScore = noone; // Pointer to text object for the amount of money achieved on this level
				levelCompleteDamageScore = noone; // Pointer to the text object for the amount of damage recieved
				levelCompleteKOScore = noone; // Pointer to thet ext object for the number of enemies defeated
			}
		}
		
		
		
		
		
		
		
		
		// handle intros
		if (p1.hasPerformedIntro && !global.hasCompletedIntros) 
		{
			global.hasCompletedIntros = true;
			var particle = instance_create_layer(0, 0, "Particles", oParticles);
			with (particle) 
			{
				sprite_index = sRound1Start;
				lifetime = 110;
				startDelay = global.campaignStartLevelDelay;
				
				// Set invisible so we don't see it flicker for 1 frame if it's supposed to be delayed
				if (startDelay > 0)
				{
					visible = false;
				}
				
				// Reset Start Delay
				global.campaignStartLevelDelay = 0;
			}
		}
		
		// Frame-by-frame
		if (keyboard_check_pressed(vk_tab) || global.frameskip < 0)
		{
			if (!global.game_paused)
			{
				global.game_paused = true;
				global.frameskip = 0;
			}
			else 
			{
				global.game_paused = false;
			}
		}

		if (global.game_paused && keyboard_check_pressed(ord("O")))
		{
			global.frameskip = 1;
		}

		if (global.frameskip > 0)
		{
			global.game_paused = false;
			global.frameskip = -1;
		}
	}
	break;
}
