/// @description Insert description here
// You can write your code in this editor

// Debug Stuff
if (global.toggleHitboxVisibility)
{
	draw_line_width(characterID.x + (bottomlessPitDetectionDistance * sign(characterID.hsp)), characterID.y + 20, characterID.x + (bottomlessPitDetectionDistance * sign(characterID.hsp)), characterID.y - 20, 3);
	draw_line_width(characterID.x + (bottomlessPitDetectionDistance * sign(characterID.hsp)), characterID.y, characterID.x + (bottomlessPitDetectionDistance * sign(characterID.hsp)), characterID.y + 200, 3);
}




