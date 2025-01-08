/// @description Insert description here
// You can write your code in this editor

if (!global.togglePresentationMode)
{
	x = (global.camObj.x-80);
	y = global.camObj.y;
	
	draw_self();
	
	if (p1Character == oRussel)
	{
		draw_sprite(sHUDPortraits_Russel, global.p1PaletteID, x, y);
		draw_sprite(sCharacterNames, 0, x+25, y+18);
	}
	else if (p1Character == oBeverly)
	{
		draw_sprite(sHUDPortraits_Beverly, global.p1PaletteID, x, y); 
		draw_sprite(sCharacterNames, 1, x+25, y+18);
	}
	else if (p1Character == oJay)
	{
		draw_sprite(sHUDPortraits_Jay, global.p1PaletteID, x, y); 
		draw_sprite(sCharacterNames, 2, x+25, y+18);
		draw_sprite(sUISpirit, 0, x+21, y+26);
		if (p1Reference.spiritON)
		{
			draw_sprite(sSpiritText, 0, x+1, y+26);
		}
	}
	else if (p1Character == oGunther)
	{
		draw_sprite(sHUDPortraits_Gunther, global.p1PaletteID, x, y); 
		draw_sprite(sCharacterNames, 3, x+25, y+18);
	}
	
	if (p2Character == oRussel)
	{
		draw_sprite_ext(sHUDPortraits_Russel, global.p2PaletteID, x+160, y, -1, 1, 0, c_white, 1);
		draw_sprite(sCharacterNames, 0, x+107, y+18);
	}
	else if (p2Character == oBeverly)
	{
		draw_sprite_ext(sHUDPortraits_Beverly, global.p2PaletteID, x+160, y, -1, 1, 0, c_white, 1);
		draw_sprite(sCharacterNames, 1, x+104, y+18);
	}
	else if (p2Character == oJay)
	{
		draw_sprite_ext(sHUDPortraits_Jay, global.p2PaletteID, x+160, y, -1, 1, 0, c_white, 1);
		draw_sprite(sCharacterNames, 2, x+121, y+18);
		draw_sprite(sUISpirit, 0, x+89, y+26);
		if (p2Reference.spiritON)
		{
			draw_sprite(sSpiritText, 0, x+140, y+26);
		}
	}
	else if (p2Character == oGunther)
	{
		draw_sprite_ext(sHUDPortraits_Gunther, global.p2PaletteID, x+160, y, -1, 1, 0, c_white, 1);
		draw_sprite(sCharacterNames, 3, x+103, y+18);
	}
}