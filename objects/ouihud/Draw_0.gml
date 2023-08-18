/// @description Insert description here
// You can write your code in this editor

if (!global.togglePresentationMode)
{
	x = (global.camObj.x-80);
	y = 0;
	
	if (p1Character == oRussel)
	{
		draw_sprite(sHUDPortraits, 0, x+15, 2);
		draw_sprite(sCharacterNames, 0, x+33, 18);
	}
	else if (p1Character == oBeverly)
	{
		draw_sprite(sHUDPortraits, 1, x+15, 2); 
		draw_sprite(sCharacterNames, 1, x+33, 18);
	}
	else if (p1Character == oJay)
	{
		draw_sprite(sHUDPortraits, 2, x+15, 2); 
		draw_sprite(sCharacterNames, 2, x+33, 18);
		draw_sprite(sUISpirit, 2, x+32, 26);
		if (p1Reference.spiritState)
		{
			draw_sprite(sSpiritText, 2, x+12, 26);
		}
	}
	else if (p1Character == oGunther)
	{
		draw_sprite(sHUDPortraits, 3, x+15, 2); 
		draw_sprite(sCharacterNames, 3, x+33, 18);
	}
	
	if (p2Character == oRussel)
	{
		draw_sprite_ext(sHUDPortraits, 0, x+143, 2, -1, 1, 0, c_white, 1);
		draw_sprite(sCharacterNames, 0, x+99, 18);
	}
	else if (p2Character == oBeverly)
	{
		draw_sprite_ext(sHUDPortraits, 1, x+143, 2, -1, 1, 0, c_white, 1);
		draw_sprite(sCharacterNames, 1, x+96, 18);
	}
	else if (p2Character == oJay)
	{
		draw_sprite_ext(sHUDPortraits, 2, x+143, 2, -1, 1, 0, c_white, 1);
		draw_sprite(sCharacterNames, 2, x+113, 18);
		draw_sprite(sUISpirit, 2, x+89, 26);
		if (p2Reference.spiritState)
		{
			draw_sprite(sSpiritText, 2, x+129, 26);
		}
	}
	else if (p2Character == oGunther)
	{
		draw_sprite_ext(sHUDPortraits, 3, x+143, 2, -1, 1, 0, c_white, 1);
		draw_sprite(sCharacterNames, 3, x+96, 18);
	}
	
	draw_self();
}