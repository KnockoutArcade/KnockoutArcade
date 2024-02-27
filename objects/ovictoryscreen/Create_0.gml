/// @description Insert description here
// You can write your code in this editor

animTimer = 0; // Animation timer for this object

state = eVictoryScreenState.OPENING_ANIMATION; // The current state of this menu object
enum eVictoryScreenState
{
	OPENING_ANIMATION,
	DISPLAY_WIN_QUOTE,
	OPTIONS
}

// Sprite Font
victoryFont = font_add_sprite_ext(sVictoryScreenFont, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ!.,'?", true, 1);

#region Portaits
portaits_StartMoving = 0; // The frame to start moving the portaits on
portaits_EndMoving = 20; // The frame to stop moving the portaits on

//portaits_StartLeaving = transitionFrame - 30; // The frame to start moving the portaits away on
//portaits_EndLeaving = transitionFrame - 10; // The frame to stop moving the portaits away on

// Player 1
p1Portait = sFullPortait_Russel; // The sprite to use for P1's portait
p1PortaitNameID = 0; // Which subimage on sCharacterNames to use
// Automatically assign the portait based on character

p1CharacterPortait_x = 160; // The current X position of P1's portait
p1CharacterPortait_y = 78; // The current Y position of P1's portait
p1CharacterPortait_StartingPosition = [160, 78]; // The starting position of P1's portait [x, y]
p1CharacterPortait_EndingPosition = [121, 78]; // The ending position of P1's portait [x, y]
#endregion

winningCharacter = global.p1SelectedCharacter;
losingCharacter = global.p2SelectedCharacter;

winQuote = "THIS MESSAGE SHOULD NOT APPEAR";

// This function will create the "[name] WINS!" text
function CreateWinnerText(sprite)
{
	// Dislay name
	var particle = instance_create_depth(global.camObj.x-80, 0, -11000, oParticles);
	with (particle)
	{
		sprite_index = sprite;
		lifetime = 1000000000;
		depth = -11000;
	}
}

// This function will take the character that won and set up all of the sprites, win quotes, etc.
setupfunction = function EstablishWinningCharacter(characterThatWon, characterThatLost)
{
	winningCharacter = characterThatWon;
	losingCharacter = characterThatLost;
	
	switch (winningCharacter)
	{
		case oRussel:
		{
			p1Portait = sFullPortait_Russel;
			p1PortaitNameID = 0;
			
			// Display Name
			CreateWinnerText(sRusselWins);
			
			// Set win quote
			switch(losingCharacter)
			{
				case oRussel:
				{
					winQuote = "WUBBA WUBBA! I'M IN THE PINK TODAY BOY!";
				}
				break;
				
				case oBeverly:
				{
					winQuote = "THANKS FOR THE HELP, BUT I'LL STICK TO MY GUT.";
				}
				break;
				
				case oJay:
				{
					winQuote = "WUBBA WUBBA! I'M IN THE PINK TODAY BOY!";
				}
				break;
				
				case oGunther:
				{
					winQuote = "WHAT STRENGTH! BUT DON'T FORGET THERE ARE GUYS LIKE YOU ALL OVER THE WORLD.";
				}
				break;
			}
		}
		break;
		
		case oBeverly:
		{
			p1Portait = sFullPortait_Beverly;
			p1PortaitNameID = 1;
		
			// Dislay name
			CreateWinnerText(sBeverlyWins);
			
			// Set win quote
			switch(losingCharacter)
			{
				case oRussel:
				{
					winQuote = "WUBBA WUBBA! I'M IN THE PINK TODAY BOY!";
				}
				break;
				
				case oBeverly:
				{
					winQuote = "YOU'RE GOOD! MAYBE YOU CAN HELP MY STUDENTS.";
				}
				break;
				
				case oJay:
				{
					winQuote = "WUBBA WUBBA! I'M IN THE PINK TODAY BOY!";
				}
				break;
				
				case oGunther:
				{
					winQuote = "WUBBA WUBBA! I'M IN THE PINK TODAY BOY!";
				}
				break;
			}
		}
		break;
		
		case oJay:
		{
			p1Portait = sFullPortait_Jay;
			p1PortaitNameID = 2;
		
			// Dislay name
			CreateWinnerText(sJayWins);
			
			// Set win quote
			switch(losingCharacter)
			{
				case oRussel:
				{
					winQuote = "MY SPIRIT, SMOOTH CRIMINAL, HAS NO WEAKNESS.";
				}
				break;
				
				case oBeverly:
				{
					winQuote = "BEVY ARE YOU OK? ARE YOU OK BEVY?";
				}
				break;
				
				case oJay:
				{
					winQuote = "WUBBA WUBBA! I'M IN THE PINK TODAY BOY!";
				}
				break;
				
				case oGunther:
				{
					winQuote = "WUBBA WUBBA! I'M IN THE PINK TODAY BOY!";
				}
				break;
			}
		}
		break;
		
		case oGunther:
		{
			p1Portait = sFullPortait_Gunther;
			p1PortaitNameID = 3;
		
			// Dislay name
			CreateWinnerText(sGuntherWins);
			
			// Set win quote
			switch(losingCharacter)
			{
				case oRussel:
				{
					winQuote = "I WANT THIS GUY BANNED FROM THE ARCADE!";
				}
				break;
				
				case oBeverly:
				{
					winQuote = "REMIND YOUR STUDENTS TO WIPE THEIR FEET AT THE DOOR.";
				}
				break;
				
				case oJay:
				{
					winQuote = "AT LEAST YOUR SPIRIT DOESN'T LEAVE RESIDUE.";
				}
				break;
				
				case oGunther:
				{
					winQuote = "YOU HAVE NO DIGNITY.";
				}
				break;
			}
		}
		break;
	}
}


