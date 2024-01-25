/// @description Insert description here
// You can write your code in this editor

draw_self()


// Draw the character portaits
if (transitionTimer >= portaits_StartMoving)
{
	draw_sprite(p1Portait, 0, p1CharacterPortait_x, p1CharacterPortait_y);
	draw_sprite(p2Portait, 0, p2CharacterPortait_x, p2CharacterPortait_y);
	
	draw_sprite(sCharacterNames, p1PortaitNameID, p1PortaitName_x, p1PortaitName_y);
	draw_sprite(sCharacterNames, p2PortaitNameID, p2PortaitName_x, p2PortaitName_y);
	
	draw_sprite(sCharacterHintSheets, p1PortaitNameID, p1HintSheet_x, p1HintSheet_y);
	draw_sprite(sCharacterHintSheets, p2PortaitNameID, p2HintSheet_x, p2HintSheet_y);
}



