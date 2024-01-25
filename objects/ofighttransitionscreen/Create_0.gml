/// @description Insert description here
// You can write your code in this editor

transitionTimer = 0; // *GETS OVERWRITTEN BY CHARACTER SELECT* Timer to keep track of transition
transitionLength = 0; // *GETS OVERWRITTEN BY CHARACTER SELECT* When to make this object go away (in frames)

// Get the layer ids of the KO text that scrolls by
transitionKOText_top = layer_get_id("TransitionKOText_Top");
transitionKOText_bottom = layer_get_id("TransitionKOText_Bottom");

transitionKOText_StartScrolling = 50; // The frame to start scrolling the KO text on
transitionKOText_EndScrolling = 70; // The frame to stop scrolling the KO text on

#region Portaits
portaits_StartMoving = 60; // The frame to start moving the portaits on
portaits_EndMoving = 80; // The frame to stop moving the portaits on

// Player 1
p1Portait = sFullPortait_Russel; // The sprite to use for P1's portait
// Automatically assign the portait based on character
switch (global.p1SelectedCharacter)
{
	case oRussel:
		p1Portait = sFullPortait_Russel;
		break;
		
	case oBeverly:
		p1Portait = sFullPortait_Beverly;
		break;
		
	case oJay:
		p1Portait = sFullPortait_Jay;
		break;
		
	case oGunther:
		p1Portait = sFullPortait_Gunther;
		break;
}
p1CharacterPortait_x = 0; // The current X position of P1's portait
p1CharacterPortait_y = 86; // The current Y position of P1's portait
p1CharacterPortait_EndingPosition = [38, 86]; // The ending position of P1's portait [x, y]

// Player 2
p2Portait = sFullPortait_Russel; // The sprite to use for P2's portait
// Automatically assign the portait based on character
switch (global.p2SelectedCharacter)
{
	case oRussel:
		p2Portait = sFullPortait_Russel;
		break;
		
	case oBeverly:
		p2Portait = sFullPortait_Beverly;
		break;
		
	case oJay:
		p2Portait = sFullPortait_Jay;
		break;
		
	case oGunther:
		p2Portait = sFullPortait_Gunther;
		break;
}
p2CharacterPortait_x = 160; // The current X position of P2's portait
p2CharacterPortait_y = 86; // The current Y position of P2's portait
p2CharacterPortait_EndingPosition = [122, 86]; // The ending position of P2's portait [x, y]
#endregion