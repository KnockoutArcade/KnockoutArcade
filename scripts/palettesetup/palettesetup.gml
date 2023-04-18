// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PaletteSetup(_paletteID, _paletteData)
{
	numOfColors = 16;

	// Setup a color array
	Color = function(r, g, b) constructor 
	{
		red = r;
		green = g;
		blue = b;
		
		// Convert each value from 0-255 to 0-1
		static toShaderValue = function(value) 
		{
			return value / 255;
		}
	};

	colorMatch1 = new Color(_paletteData.BasePalette[0].Red, _paletteData.BasePalette[0].Green, _paletteData.BasePalette[0].Blue);
	colorMatch2 = new Color(_paletteData.BasePalette[1].Red, _paletteData.BasePalette[1].Green, _paletteData.BasePalette[1].Blue);
	colorMatch3 = new Color(_paletteData.BasePalette[2].Red, _paletteData.BasePalette[2].Green, _paletteData.BasePalette[2].Blue);
	colorMatch4 = new Color(_paletteData.BasePalette[3].Red, _paletteData.BasePalette[3].Green, _paletteData.BasePalette[3].Blue);
	colorMatch5 = new Color(_paletteData.BasePalette[4].Red, _paletteData.BasePalette[4].Green, _paletteData.BasePalette[4].Blue);
	colorMatch6 = new Color(_paletteData.BasePalette[5].Red, _paletteData.BasePalette[5].Green, _paletteData.BasePalette[5].Blue);
	colorMatch7 = new Color(_paletteData.BasePalette[6].Red, _paletteData.BasePalette[6].Green, _paletteData.BasePalette[6].Blue);
	colorMatch8 = new Color(_paletteData.BasePalette[7].Red, _paletteData.BasePalette[7].Green, _paletteData.BasePalette[7].Blue);
	colorMatch9 = new Color(_paletteData.BasePalette[8].Red, _paletteData.BasePalette[8].Green, _paletteData.BasePalette[8].Blue);
	colorMatch10 = new Color(_paletteData.BasePalette[9].Red, _paletteData.BasePalette[9].Green, _paletteData.BasePalette[9].Blue);
	colorMatch11 = new Color(_paletteData.BasePalette[10].Red, _paletteData.BasePalette[10].Green, _paletteData.BasePalette[10].Blue);
	colorMatch12 = new Color(_paletteData.BasePalette[11].Red, _paletteData.BasePalette[11].Green, _paletteData.BasePalette[11].Blue);
	colorMatch13 = new Color(_paletteData.BasePalette[12].Red, _paletteData.BasePalette[12].Green, _paletteData.BasePalette[12].Blue);
	colorMatch14 = new Color(_paletteData.BasePalette[13].Red, _paletteData.BasePalette[13].Green, _paletteData.BasePalette[13].Blue);
	colorMatch15 = new Color(_paletteData.BasePalette[14].Red, _paletteData.BasePalette[14].Green, _paletteData.BasePalette[14].Blue);
	colorMatch16 = new Color(_paletteData.BasePalette[15].Red, _paletteData.BasePalette[15].Green, _paletteData.BasePalette[15].Blue);
	colorReplace1 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[0].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[0].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[0].Blue);
	colorReplace2 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[1].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[1].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[1].Blue);
	colorReplace3 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[2].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[2].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[2].Blue);
	colorReplace4 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[3].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[3].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[3].Blue);
	colorReplace5 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[4].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[4].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[4].Blue);
	colorReplace6 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[5].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[5].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[5].Blue);
	colorReplace7 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[6].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[6].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[6].Blue);
	colorReplace8 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[7].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[7].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[7].Blue);
	colorReplace9 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[8].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[8].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[8].Blue);
	colorReplace10 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[9].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[9].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[9].Blue);
	colorReplace11 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[10].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[10].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[10].Blue);
	colorReplace12 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[11].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[11].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[11].Blue);
	colorReplace13 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[12].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[12].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[12].Blue);
	colorReplace14 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[13].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[13].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[13].Blue);
	colorReplace15 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[14].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[14].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[14].Blue);
	colorReplace16 = new Color(_paletteData.AlternatePalettes[_paletteID].ColorPalette[15].Red, _paletteData.AlternatePalettes[_paletteID].ColorPalette[15].Green, _paletteData.AlternatePalettes[_paletteID].ColorPalette[15].Blue);

	sh_handle_range = shader_get_uniform(sh_CharPalettes, "range");
	sh_handle_match1 = shader_get_uniform(sh_CharPalettes, "colorMatch1");
	sh_handle_match2 = shader_get_uniform(sh_CharPalettes, "colorMatch2");
	sh_handle_match3 = shader_get_uniform(sh_CharPalettes, "colorMatch3");
	sh_handle_match4 = shader_get_uniform(sh_CharPalettes, "colorMatch4");
	sh_handle_match5 = shader_get_uniform(sh_CharPalettes, "colorMatch5");
	sh_handle_match6 = shader_get_uniform(sh_CharPalettes, "colorMatch6");
	sh_handle_match7 = shader_get_uniform(sh_CharPalettes, "colorMatch7");
	sh_handle_match8 = shader_get_uniform(sh_CharPalettes, "colorMatch8");
	sh_handle_match9 = shader_get_uniform(sh_CharPalettes, "colorMatch9");
	sh_handle_match10 = shader_get_uniform(sh_CharPalettes, "colorMatch10");
	sh_handle_match11 = shader_get_uniform(sh_CharPalettes, "colorMatch11");
	sh_handle_match12 = shader_get_uniform(sh_CharPalettes, "colorMatch12");
	sh_handle_match13 = shader_get_uniform(sh_CharPalettes, "colorMatch13");
	sh_handle_match14 = shader_get_uniform(sh_CharPalettes, "colorMatch14");
	sh_handle_match15 = shader_get_uniform(sh_CharPalettes, "colorMatch15");
	sh_handle_match16 = shader_get_uniform(sh_CharPalettes, "colorMatch16");

	sh_handle_replace1 = shader_get_uniform(sh_CharPalettes, "colorReplace1");
	sh_handle_replace2 = shader_get_uniform(sh_CharPalettes, "colorReplace2");
	sh_handle_replace3 = shader_get_uniform(sh_CharPalettes, "colorReplace3");
	sh_handle_replace4 = shader_get_uniform(sh_CharPalettes, "colorReplace4");
	sh_handle_replace5 = shader_get_uniform(sh_CharPalettes, "colorReplace5");
	sh_handle_replace6 = shader_get_uniform(sh_CharPalettes, "colorReplace6");
	sh_handle_replace7 = shader_get_uniform(sh_CharPalettes, "colorReplace7");
	sh_handle_replace8 = shader_get_uniform(sh_CharPalettes, "colorReplace8");
	sh_handle_replace9 = shader_get_uniform(sh_CharPalettes, "colorReplace9");
	sh_handle_replace10 = shader_get_uniform(sh_CharPalettes, "colorReplace10");
	sh_handle_replace11 = shader_get_uniform(sh_CharPalettes, "colorReplace11");
	sh_handle_replace12 = shader_get_uniform(sh_CharPalettes, "colorReplace12");
	sh_handle_replace13 = shader_get_uniform(sh_CharPalettes, "colorReplace13");
	sh_handle_replace14 = shader_get_uniform(sh_CharPalettes, "colorReplace14");
	sh_handle_replace15 = shader_get_uniform(sh_CharPalettes, "colorReplace15");
	sh_handle_replace16 = shader_get_uniform(sh_CharPalettes, "colorReplace16");

}