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

switch (global.p1SelectedCharacter)
{
	case oRussel:
	{
		p1Portait = sFullPortait_Russel;
		p1PortaitNameID = 0;
		
		// Dislay name
		var particle = instance_create_depth(global.camObj.x-80, 0, -11000, oParticles);
		with (particle)
		{
			sprite_index = sRusselWins;
			lifetime = 1000000000;
			depth = -11000;
		}
	}
	break;
		
	case oBeverly:
	{
		p1Portait = sFullPortait_Beverly;
		p1PortaitNameID = 1;
		
		// Dislay name
		var particle = instance_create_depth(global.camObj.x-80, 0, -11000, oParticles);
		with (particle)
		{
			sprite_index = sBeverlyWins;
			lifetime = 1000000000;
			depth = -11000;
		}
	}
	break;
		
	case oJay:
	{
		p1Portait = sFullPortait_Jay;
		p1PortaitNameID = 2;
		
		// Dislay name
		var particle = instance_create_depth(global.camObj.x-80, 0, -11000, oParticles);
		with (particle)
		{
			sprite_index = sJayWins;
			lifetime = 1000000000;
			depth = -11000;
		}
	}
	break;
		
	case oGunther:
	{
		p1Portait = sFullPortait_Gunther;
		p1PortaitNameID = 3;
		
		// Dislay name
		var particle = instance_create_depth(global.camObj.x-80, 0, -11000, oParticles);
		with (particle)
		{
			sprite_index = sGuntherWins;
			lifetime = 1000000000;
			depth = -11000;
		}
	}
	break;
}