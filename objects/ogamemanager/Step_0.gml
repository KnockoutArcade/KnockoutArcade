/// @description Insert description here
// You can write your code in this editor

switch (global.gameMode)
{
	case GAMEMODE.VERSUS:
	{
		// This will tell us if someone has won, so we can stop any match resetting
		var winConditionMet = (global.p1Rounds >= 2 || global.p2Rounds >= 2);
		
		// A player is defeated
		if (p1.hp == 0 || p2.hp == 0)
		{
			p1.isEXFlash = false;
			p2.isEXFlash = false;
			instance_destroy(oTimeStop);
			
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
				if (p2.hp == 0)
				{
					global.p1Rounds++;
				}
				
				if (p1.hp == 0)
				{
					global.p2Rounds++;
				}
				
				if (p1.hp == 0 && p2.hp == 0)
				{
					var particle = instance_create_layer(global.camObj.x-80, 0, "KO_Text", oParticles);
					with (particle) 
					{
						sprite_index = sDoubleKOText;
						image_index = true;
						lifetime = 89;
					}
				}
				else
				{
					if (p1.state == eState.SUPER || p1.installActivated || p1.timeStopActivated || 
						 p2.state == eState.SUPER || p2.installActivated || p2.timeStopActivated)
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
						lifetime = 89;
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
		// handle intros
		if (p1.hasPerformedIntro && !global.hasCompletedIntros) 
		{
			global.hasCompletedIntros = true;
			var particle = instance_create_layer(0, 0, "Particles", oParticles);
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
}
