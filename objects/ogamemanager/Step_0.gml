/// @description Insert description here
// You can write your code in this editor

switch (global.gameMode)
{
	case GAMEMODE.VERSUS:
	{
		// Handle Pausing
		if (state == eGameManagerState.DURING_MATCH && !global.game_paused && !p1.isInCutscene && !p2.isInCutscene) // Check to see if we are in the during match state
		{
			// If p1 pressed pause and the pause menu isn't up already
			if (global.p1ButtonMenuPause && pauseMenuObject == noone)
			{
				pauseMenuButtonHeldTimer_P1++; // increment P1's timer by 1
			}
			else
			{
				pauseMenuButtonHeldTimer_P1 = 0; // reset P1's timer
			}
			
			// If p2 pressed pause and the pause menu isn't up already
			if (global.p2ButtonMenuPause && pauseMenuObject == noone)
			{
				pauseMenuButtonHeldTimer_P2++; // increment P2's timer by 1
			}
			else
			{
				pauseMenuButtonHeldTimer_P2 = 0; // reset P2's timer
			}
			
			// If a player has reached the hold requirement...
			if (pauseMenuButtonHeldTimer_P1 == pauseMenuHoldRequirement || pauseMenuButtonHeldTimer_P2 == pauseMenuHoldRequirement)
			{
				// Create the Pause menu
				pauseMenuObject = instance_create_depth(global.camObj.x-80, global.camObj.y, -10000, oPauseMenu);
				
				// Set the pause menu's owner
				pauseMenuObject.owner = id;
				
				// If P2 has been holding for longer, make them the person who paused the game
				if (pauseMenuButtonHeldTimer_P2 > pauseMenuButtonHeldTimer_P1)
				{
					// set Player number to 1, and set the proper opening animation
					pauseMenuObject.playerNumber = 1;
					pauseMenuObject.sprite_index = sPauseMenu_Open_P2;
				}
				else // otherwise, P1 has paused the game
				{
					// set Player number to 0 (animation already set by default)
					pauseMenuObject.playerNumber = 0;
				}
				
				// Pause the game
				global.game_paused = true;
				
				// reset the pause button timers
				pauseMenuButtonHeldTimer_P1 = 0;
				pauseMenuButtonHeldTimer_P2 = 0;
			}
		}
		
		// This will tell us if someone has won, so we can stop any match resetting
		var winConditionMet = (global.p1Rounds >= 2 || global.p2Rounds >= 2);
		
		// A player is defeated
		if (p1.hp <= 0 || p2.hp <= 0)
		{
			// Set the game manager's state to round win
			state = eGameManagerState.ROUND_WIN;
			
			p1.isEXFlash = false;
			p2.isEXFlash = false;
			
			// Disable inputs for players
			p1.isInCutscene = true; 
			p2.isInCutscene = true;
			instance_destroy(oTimeStop);
			audio_resume_sound(testBGM);
			
			global.roundOver = true;
			gameHaltTimer++;
			
			// If we're past the slowdown and both players are stable AND we havent set mWBPWS yet...
			if (gameHaltTimer >= 180 && p1.isInStableState && p2.isInStableState && momentWhenBothPlayersWereStable == 0)
			{
				// Set this frame as the moment both players became stable
				momentWhenBothPlayersWereStable = gameHaltTimer;
			}
			
			// If we're past the delay after both players became stable...
			if (gameHaltTimer >= (momentWhenBothPlayersWereStable + victoryAnimationDelay) && !winConditionMet && momentWhenBothPlayersWereStable != 0 && victoryAnimationTime == 0)
			{
				if (p1.hp > 0) // If p1 won...
				{
					// set state
					p1.state = eState.ROUND_WIN;
					
					// Set the time when a player entered their victory animation
					victoryAnimationTime = gameHaltTimer;
					
					// Set the camera's target
					global.camObj.isTargetingWinner = true;
					global.camObj.roundWinTarget = p1;
				}
				else if (p2.hp > 0) // If p2 won...
				{
					// set state
					p2.state = eState.ROUND_WIN;
					
					// Set the time when a player entered their victory animation
					victoryAnimationTime = gameHaltTimer;
					
					// Set the camera's target
					global.camObj.isTargetingWinner = true;
					global.camObj.roundWinTarget = p2;
				}
				else // if both players are defeated, transition immediately
				{
					ResetGame();

					SetupGame();
		
					global.gameHalt = 0;
					global.game_paused = false;
					global.roundOver = false;
					gameHaltTimer = 0;
					momentWhenBothPlayersWereStable = 0;
					victoryAnimationTime = 0;
				}
				
			}
			else if (gameHaltTimer >= (victoryAnimationTime + victoryAnimationDuration) && victoryAnimationTime != 0) // If the victory animation is complete...
			{
				ResetGame();

				SetupGame();
		
				global.gameHalt = 0;
				global.game_paused = false;
				global.roundOver = false;
				gameHaltTimer = 0;
				momentWhenBothPlayersWereStable = 0;
				victoryAnimationTime = 0;
			}
			else if (gameHaltTimer >= 180 && gameHaltTimer < 300) // Post-slowdown
			{
				global.game_paused = false;
			}
			else if (gameHaltTimer >= 60 && gameHaltTimer < 180) // Slowdown
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
			else if (gameHaltTimer == 1) // Initial end
			{
				// Set the game manager's state to round win
				state = eGameManagerState.ROUND_WIN;
				
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
			p1.isEXFlash = false;
			p2.isEXFlash = false;
			
			// Disable inputs for players
			p1.isInCutscene = true; 
			p2.isInCutscene = true;
			
			global.roundOver = true;
			gameHaltTimer++;
			
			
			// If we're past the delay and both players are idle AND we havent set mWBPWS yet...
			if (gameHaltTimer >= 60 && p1.state == eState.IDLE && p2.state == eState.IDLE && momentWhenBothPlayersWereStable == 0)
			{
				// Set this frame as the moment both players became stable
				momentWhenBothPlayersWereStable = gameHaltTimer;
			}
			
			if (gameHaltTimer >= (momentWhenBothPlayersWereStable + victoryAnimationDelay) && !winConditionMet && momentWhenBothPlayersWereStable != 0 && victoryAnimationTime == 0) // After the delay...
			{
				// If P1 won...
				if (p1.hp/p1.maxHitPoints > p2.hp/p2.maxHitPoints)
				{
					// set state
					p1.state = eState.ROUND_WIN;
					p2.state = eState.ROUND_LOSE;
					
					// Set the time when a player entered their victory animation
					victoryAnimationTime = gameHaltTimer;
					
					// Set the camera's target
					global.camObj.isTargetingWinner = true;
					global.camObj.roundWinTarget = p1;
				}
				else if (p2.hp/p2.maxHitPoints > p1.hp/p1.maxHitPoints)
				{
					// set state
					p2.state = eState.ROUND_WIN;
					p1.state = eState.ROUND_LOSE;
					
					// Set the time when a player entered their victory animation
					victoryAnimationTime = gameHaltTimer;
				}
				else // Both are equal
				{
					// Set both players to lose
					p1.state = eState.ROUND_LOSE;
					p2.state = eState.ROUND_LOSE;
					
					// Set the time when a player entered their victory animation
					victoryAnimationTime = gameHaltTimer;
				}
			}
			else if (gameHaltTimer >= (victoryAnimationTime + victoryAnimationDuration) && victoryAnimationTime != 0) // If the victory animation is complete...
			{
				ResetGame();

				SetupGame();
		
				global.gameHalt = 0;
				global.game_paused = false;
				global.roundOver = false;
				gameHaltTimer = 0;
				momentWhenBothPlayersWereStable = 0;
				victoryAnimationTime = 0;
			}
			else if (gameHaltTimer == 1) // Initial End
			{
				// Set the game manager's state to round win
				state = eGameManagerState.ROUND_WIN;
			
				
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
					lifetime = 59;
				}
			}
		}
		
		// When a player meets the win requirement for the match return players to the character selection screen
		if (global.p1Rounds >= 2 && global.p2Rounds >= 2)
		{
			// Once both players have been in a stable state, display the Draw... text
			if (gameHaltTimer == momentWhenBothPlayersWereStable + 60 && momentWhenBothPlayersWereStable != 0)
			{
				var particle = instance_create_layer(global.camObj.x-80, 0, "KO_Text", oParticles);
				with (particle)
				{
					sprite_index = sDraw;
					image_index = true;
					lifetime = 1000000000;
				}
			}
			else if (gameHaltTimer == momentWhenBothPlayersWereStable + 140 && momentWhenBothPlayersWereStable != 0)
			{
				state = eGameManagerState.POST_MATCH;
				audio_stop_sound(testBGM);
				
				var victoryScreen = instance_create_depth(global.camObj.x - 80, global.camObj.y, -10000, oVictoryScreen);
				victoryScreen.skipIntro = true;
				victoryScreen.setupfunction(global.p1SelectedCharacter, global.p2SelectedCharacter);
				victoryScreen.state = eVictoryScreenState.OPTIONS;
			}
		}
		else if (global.p1Rounds >= 2)
		{
			if (gameHaltTimer == 220)
			{
				state = eGameManagerState.POST_MATCH;
				audio_stop_sound(testBGM);
				
				var victoryScreen = instance_create_depth(global.camObj.x - 80, global.camObj.y, -10000, oVictoryScreen);
				victoryScreen.setupfunction(global.p1SelectedCharacter, global.p2SelectedCharacter);
			}
		}
		else if (global.p2Rounds >= 2)
		{ 
			if (gameHaltTimer == 220)
			{
				state = eGameManagerState.POST_MATCH;
				audio_stop_sound(testBGM);
				
				var victoryScreen = instance_create_depth(global.camObj.x - 80, global.camObj.y, -10000, oVictoryScreen);
				victoryScreen.setupfunction(global.p2SelectedCharacter, global.p1SelectedCharacter);
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
		// Handle Pausing
		if (!global.game_paused && !p1.isInCutscene) // Check to see if we are not in a cutscene right now
		{
			// If p1 pressed pause and the pause menu isn't up already
			if (global.p1ButtonMenuPause && pauseMenuObject == noone)
			{
				pauseMenuButtonHeldTimer_P1++; // increment P1's timer by 1
			}
			else
			{
				pauseMenuButtonHeldTimer_P1 = 0; // reset P1's timer
			}
			
			// If a player has reached the hold requirement (in singleplayer, pressing the button is enough)
			if (pauseMenuButtonHeldTimer_P1 == 1)
			{
				// Create the Pause menu
				pauseMenuObject = instance_create_depth(global.camObj.x-80, global.camObj.y, -10000, oPauseMenu);
				
				// Set the pause menu's owner
				pauseMenuObject.owner = id;
				
				// set Player number to 0 (animation already set by default)
				pauseMenuObject.playerNumber = 0;
				
				// Pause the game
				global.game_paused = true;
				
				// reset the pause button timers
				pauseMenuButtonHeldTimer_P1 = 0;
			}
		}
		
		// When a player completes a level
		if (global.hasCompletedLevel)
		{
			// Pause the game
			global.game_paused = true;
			
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
