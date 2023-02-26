// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PaletteSetup(_paletteID, _paletteData)
{
	paletteID = _paletteID;
	numOfColors = 16;

	var arrayEntryStart = paletteID * numOfColors;


	Color = function(r, g, b) constructor {
		red = r;
		green = g;
		blue = b;
		
		static toShaderValue = function(value) {
			return value / 255;
		}
	};

	colorMatch1 = new Color(_paletteData.baseColorMatch[0][0], _paletteData.baseColorMatch[0][1], _paletteData.baseColorMatch[0][2]);
	colorMatch2 = new Color(_paletteData.baseColorMatch[1][0], _paletteData.baseColorMatch[1][1], _paletteData.baseColorMatch[1][2]);
	colorMatch3 = new Color(_paletteData.baseColorMatch[2][0], _paletteData.baseColorMatch[2][1], _paletteData.baseColorMatch[2][2]);
	colorMatch4 = new Color(_paletteData.baseColorMatch[3][0], _paletteData.baseColorMatch[3][1], _paletteData.baseColorMatch[3][2]);
	colorMatch5 = new Color(_paletteData.baseColorMatch[4][0], _paletteData.baseColorMatch[4][1], _paletteData.baseColorMatch[4][2]);
	colorMatch6 = new Color(_paletteData.baseColorMatch[5][0], _paletteData.baseColorMatch[5][1], _paletteData.baseColorMatch[5][2]);
	colorMatch7 = new Color(_paletteData.baseColorMatch[6][0], _paletteData.baseColorMatch[6][1], _paletteData.baseColorMatch[6][2]);
	colorMatch8 = new Color(_paletteData.baseColorMatch[7][0], _paletteData.baseColorMatch[7][1], _paletteData.baseColorMatch[7][2]);
	colorMatch9 = new Color(_paletteData.baseColorMatch[8][0], _paletteData.baseColorMatch[8][1], _paletteData.baseColorMatch[8][2]);
	colorMatch10 = new Color(_paletteData.baseColorMatch[9][0], _paletteData.baseColorMatch[9][1], _paletteData.baseColorMatch[9][2]);
	colorMatch11 = new Color(_paletteData.baseColorMatch[10][0], _paletteData.baseColorMatch[10][1], _paletteData.baseColorMatch[10][2]);
	colorMatch12 = new Color(_paletteData.baseColorMatch[11][0], _paletteData.baseColorMatch[11][1], _paletteData.baseColorMatch[11][2]);
	colorMatch13 = new Color(_paletteData.baseColorMatch[12][0], _paletteData.baseColorMatch[12][1], _paletteData.baseColorMatch[12][2]);
	colorMatch14 = new Color(_paletteData.baseColorMatch[13][0], _paletteData.baseColorMatch[13][1], _paletteData.baseColorMatch[13][2]);
	colorMatch15 = new Color(_paletteData.baseColorMatch[14][0], _paletteData.baseColorMatch[14][1], _paletteData.baseColorMatch[14][2]);
	colorMatch16 = new Color(_paletteData.baseColorMatch[15][0], _paletteData.baseColorMatch[15][1], _paletteData.baseColorMatch[15][2]);
	colorReplace1 = new Color(_paletteData.colorReplaces[arrayEntryStart][0], _paletteData.colorReplaces[arrayEntryStart][1], _paletteData.colorReplaces[arrayEntryStart][2]);
	colorReplace2 = new Color(_paletteData.colorReplaces[arrayEntryStart+1][0], _paletteData.colorReplaces[arrayEntryStart+1][1], _paletteData.colorReplaces[arrayEntryStart+1][2]);
	colorReplace3 = new Color(_paletteData.colorReplaces[arrayEntryStart+2][0], _paletteData.colorReplaces[arrayEntryStart+2][1], _paletteData.colorReplaces[arrayEntryStart+2][2]);
	colorReplace4 = new Color(_paletteData.colorReplaces[arrayEntryStart+3][0], _paletteData.colorReplaces[arrayEntryStart+3][1], _paletteData.colorReplaces[arrayEntryStart+3][2]);
	colorReplace5 = new Color(_paletteData.colorReplaces[arrayEntryStart+4][0], _paletteData.colorReplaces[arrayEntryStart+4][1], _paletteData.colorReplaces[arrayEntryStart+4][2]);
	colorReplace6 = new Color(_paletteData.colorReplaces[arrayEntryStart+5][0], _paletteData.colorReplaces[arrayEntryStart+5][1], _paletteData.colorReplaces[arrayEntryStart+5][2]);
	colorReplace7 = new Color(_paletteData.colorReplaces[arrayEntryStart+6][0], _paletteData.colorReplaces[arrayEntryStart+6][1], _paletteData.colorReplaces[arrayEntryStart+6][2]);
	colorReplace8 = new Color(_paletteData.colorReplaces[arrayEntryStart+7][0], _paletteData.colorReplaces[arrayEntryStart+7][1], _paletteData.colorReplaces[arrayEntryStart+7][2]);
	colorReplace9 = new Color(_paletteData.colorReplaces[arrayEntryStart+8][0], _paletteData.colorReplaces[arrayEntryStart+8][1], _paletteData.colorReplaces[arrayEntryStart+8][2]);
	colorReplace10 = new Color(_paletteData.colorReplaces[arrayEntryStart+9][0], _paletteData.colorReplaces[arrayEntryStart+9][1], _paletteData.colorReplaces[arrayEntryStart+9][2]);
	colorReplace11 = new Color(_paletteData.colorReplaces[arrayEntryStart+10][0], _paletteData.colorReplaces[arrayEntryStart+10][1], _paletteData.colorReplaces[arrayEntryStart+10][2]);
	colorReplace12 = new Color(_paletteData.colorReplaces[arrayEntryStart+11][0], _paletteData.colorReplaces[arrayEntryStart+11][1], _paletteData.colorReplaces[arrayEntryStart+11][2]);
	colorReplace13 = new Color(_paletteData.colorReplaces[arrayEntryStart+12][0], _paletteData.colorReplaces[arrayEntryStart+12][1], _paletteData.colorReplaces[arrayEntryStart+12][2]);
	colorReplace14 = new Color(_paletteData.colorReplaces[arrayEntryStart+13][0], _paletteData.colorReplaces[arrayEntryStart+13][1], _paletteData.colorReplaces[arrayEntryStart+13][2]);
	colorReplace15 = new Color(_paletteData.colorReplaces[arrayEntryStart+14][0], _paletteData.colorReplaces[arrayEntryStart+14][1], _paletteData.colorReplaces[arrayEntryStart+14][2]);
	colorReplace16 = new Color(_paletteData.colorReplaces[arrayEntryStart+15][0], _paletteData.colorReplaces[arrayEntryStart+15][1], _paletteData.colorReplaces[arrayEntryStart+15][2]);

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